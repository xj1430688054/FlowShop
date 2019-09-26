<%@ page language="java" import="java.util.*,java.text.*,com.gcj.service.admin.*,com.gcj.domain.admin.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//获取当前时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义日期格式
String nowTime = sdf.format(new java.util.Date()); 
String time=nowTime.substring(0,11);//截取字符串

//接收管理员的信息
Admin admin = (Admin)request.getSession().getAttribute("loginadmin");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/admin_index.css">
	<link rel="stylesheet" type="text/css" href="css/comm.css">
	<link rel="stylesheet" type="text/css" href="css/user_index.css">
	
	<script type="text/javascript">
	function checkLogout(){
		if(window.confirm("您确定立即退出吗?")){
			return true;
		}else{
			return false;
		}
	}
	
	function goback(){	//返回上一页
		//返回上一页并刷新上一页
		//self.location=document.referrer;
		history.back();	//history 为js 的一个对象
	}
	
	function checkNewpasswd(){	//验证新的密码
		if($("newpasswd").value.length<6){
			$("mynewpasswd").innerText="密码长度不能少于6位";
			return false;
		}else{
			$("mynewpasswd").innerText="新密码输入成功";
			return true;
		}
	}
	function checkNewpasswd1(){		//确认输入的密码
		if(checkNewpasswd()){
			if($("newpasswd1").value ==$("newpasswd").value){
				$("mynewpasswd1").innerText="密码输入成功";
				return true;
			}else{
				$("mynewpasswd1").innerText="密码输入不正确";
				return false;
			}
		}else{
			$("mynewpasswd1").innerText="请先成功输入新密码";
			return false;
		}
	}
	function $(id){
		return document.getElementById(id);
	}
	
	
	//一号线:创建ajax引擎
		function getXmlHttpObject(){
		
			var xmlHttpRequest;
			//不同的浏览器获取对象xmlhttprequest的方法不一样
			if(window.ActiveXobject){
				//如果是IE浏览器
				xmlHttpRequust = new ActiveXobject("Microsoft.XMLHTTP");
			}else{
				//其他浏览器
				xmlHttpRequest = new XMLHttpRequest();
			}
			return xmlHttpRequest;
		}
	
		 	
	    var myXmlHttpRequest="";//设置为全局变量
		var xmlHttpRequest="";//设置为全局变量
		//二号线:发送http请求
		function checkName(){		//验证用户名是否存在
			xmlHttpRequest = getXmlHttpObject();
			//window.alert("创建ok");
			//var val=document.getElementById("username").value;
			//window.alert(val);
			//怎么判断创建ok  创建失败给出错误提示
			if(xmlHttpRequest){	//创建成功
				//通过myXmlHttpRequest对象发送请求道服务器的某个页面
				//第一个参数表示请求的方式,"get" / "post"
				//第二个参数指定url,对哪个页面发出ajax 请求(本质仍然是http请求)
				//第三个参数表示 true 表示使用异步机制，false表示不使用异步机制
				//window.alert("创建ok");
				var val=document.getElementById("adminname").value;
				if(val.length<6){
					document.getElementById("myres").innerText="用户名不能小于6位";
					return false;
				}
				//使用get 方式发出请求，如果提交的用户名不变化，浏览器将不会真的发请求，而是从缓存取数据
				//解决方法:url 后带一个总是变化的参数，比如当前时间
				var url="/FlowerShop/AdminClServlet?type=checkname&mytime="+new Date()+"&adminname="+val;
				//打开请求
				xmlHttpRequest.open("get",url,true);
				//指定回调函数 chuli 是函数名
				xmlHttpRequest.onreadystatechange=chuli;
				
				//真的发送请求，如果是get请求则填入null即可
				//如果是post请求，则填入实际的数据
				xmlHttpRequest.send(null);
				
				if(document.getElementById("myres").innerText =="该用户名已经存在"){
					//当提示用户名已经存在时，表示用户未修改用户名
					return false;
				}
				//一旦用户修改了用户名并且合法，就返回true
				return true;
			}else{//创建失败，给出提示
				window.alert("xmlHttpRequest 创建失败!");
			}
			
		}
		
		//三号线:AjaxClServlet 处理
		//四号线:回调函数
		function chuli(){
			//window.alert("处理函数被调回"+myXmlHttpRequest.readyState);
			//取出从AjaxClServlet返回的数据
			if(xmlHttpRequest.readyState==4){		//HTTP就绪码为4  
				if(xmlHttpRequest.status==200){	//HTTP 状态码为200 说明服务器处理正确
					//取出值，根据返回信息的格式定
					//window.alert("服务器返回:"+myXmlHttpRequest.responseText);
					document.getElementById("myres").innerText=xmlHttpRequest.responseText;
					
				}else if(xmlHttpRequest.status==404){	//客户端请求出错
						window.alert("请求的url不存在");
				}else{
					alert("Error:status code is:"+xmlHttpRequest.status);
				}
			}
		}
	
		
		
		
		
	
	//重置
		function resetval(){
			$("myres").innerText="";
			$("mynewpasswd").innerText="";
			$("mynewpasswd1").innerText="";
			
			theform.reset();//theform 是表单名
		}
	
	
	//使用Ajax异步添加管理员
	function addAdmin(){
		
		if(checkName()&& checkNewpasswd()&& checkNewpasswd1()){
			//window.alert("进来了=======");
			//首先创建一个XMLHttpRequest对象
			xmlHttpRequest = getXmlHttpObject();
			if(xmlHttpRequest){	//创建成功
				//获取需要的表单数据
				var newpasswd = $("newpasswd").value;
				var adminname=$("adminname").value;
				//创建连接服务器的url
				var url="/FlowerShop/AdminClServlet?type=addAdmin&mytime="+new Date();
				var data="adminname="+adminname+"&newpasswd="+newpasswd;
				//打开请求
				xmlHttpRequest.open("post",url,true);
				//使用post 提交下面这句话必须有,告之服务器正在发送数据，且数据已经符合URL编码了
				xmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				//指定回调函数 showResult 是函数名
				xmlHttpRequest.onreadystatechange=showResult1;
				//发送请求，填入数据
				xmlHttpRequest.send(data);
				
			}else{//创建失败，给出提示
				window.alert("myXmlHttpRequest 创建失败!");
			}
				
		}else{
			window.alert("请正确填写信息");
			return false;
		}
		
	}
	
	function showResult1(){	//回调函数
		if(xmlHttpRequest.readyState==4){		//HTTP就绪码为4  
				if(xmlHttpRequest.status==200){	//HTTP 状态码为200 说明服务器处理正确
					//取出值，根据返回信息的格式定
					window.alert(xmlHttpRequest.responseText);
					$("myres").innerText="";
					$("mynewpasswd").innerText="";
					$("mynewpasswd1").innerText="";
					$("adminname").value="";
					$("newpasswd").value="";
					$("newpasswd1").value="";
				}else if(xmlHttpRequest.status==404){	//客户端请求出错
						window.alert("请求的url不存在");
				}else{
					alert("Error:status code is:"+xmlHttpRequest.status);
				}
			}
	}
	</script>

  </head>
  
  <body background="images/bg.bmp">
    <div class="navi_head">
   		<span>欢迎您, 管理员 <font size="3"><%=admin.getName() %></font></span>
   		
   <span class="span1">  <a href="/FlowerShop/AdminLoginCl?type=logout" onClick="return checkLogout()">【安全退出】</a></span>
   </div>
   
   <!-- 这是用户首页面 -->
   <div class="navi_pic">
   <img  onClick="return test1();"src="images/logo.gif"  height="150px" />
  <!-- 如何防止首页的logo被盗 -->
<table width="78%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="76%" align="center" ><font class="font1">花卉预定管理系统</font></td>
    <td width="24%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
    </table></td>
  </tr>
</table>
   </div>
   
  <div class="menu">
   <ul>
   <li>
   <a href="/FlowerShop/AdminClServlet?type=manage">管理员管理</a>
   		<ul>
   		<li><a href="/FlowerShop/AdminClServlet?type=goupdview">改个人信息</a></li>
   		<% 
   		if(admin.getGrade().equals("超级管理员")){ 
   		%>
   		<li><a href="/FlowerShop/AdminClServlet?type=showAllAdmin">管理员列表</a></li><!--查看管理员 显示管理员信息后，可以在信息后增加一个"删除"的超链接-->
   		<li><a href="/FlowerShop/AdminClServlet?type=goinsertview">添加管理员</a></li>
   		<% 
   			}
   		%>
   		</ul>
   </li>
   
    <li><a href="/FlowerShop/AdminUserCl?type=showAllAdmin">用户管理</a></li>
   
   <li><a href="/FlowerShop/AdminFlowerCl?type=manage">花卉管理</a>
  <ul>
   <li><a href="/FlowerShop/AdminFlowerCl?type=showAllFlower">花卉列表</a></li><!-- 显示列表后可以进行删除操作,修改(编辑)操作--> 
   <li><a href="/FlowerShop/AdminFlowerCl?type=goinsertflowerview">添加花卉</a></li>
   </ul>
   </li>
   <li><a href="/FlowerShop/AdminOrderCl?type=manage">订单管理</a>
   <ul><li><a href="/FlowerShop/AdminOrderCl?type=showAllOrders">订单列表</a></li><li><a href="/FlowerShop/AdminOrderCl?type=showcancelOrders">退订订单</a></li></ul>
   </li>
   
   <li><a href="/FlowerShop/AdminOrderCl?type=manage">其他管理</a>
   <ul><li><a href="/FlowerShop/AdminMessageCl?type=message">留言管理</a></li><li><a href="/FlowerShop/AdminFlowerCl?type=showFlowerTrends">花卉动态</a></li><li><a href="/FlowerShop/AdminFlowerCl?type=showFlowerKnowledge">花卉知识</a></li></ul>
   </li>
   
    <li><a href="/FlowerShop/AdminOrderCl?type=manage">销售评价</a>
   <ul><li><a href="/FlowerShop/AdminFlowerCl?type=reservedflower">预订花卉</a></li><li><a href="/FlowerShop/AdminFlowerCl?type=ok">交易花卉</a></li><li><a href="/FlowerShop/AdminCommentCl?type=showcomment">评价管理</a></li></ul>
   </li>
   
   </ul>
   </div>
   
   <div class="center_content">
   <div class="welcome">当前所在>>添加管理员</div>
   <div class="update_AdminInfo">
   <div class="adminInfo"><span>管理员:<%=admin.getName() %></span>  <span>权限:<%=admin.getGrade() %></span></div>
   <div class="detail_admin_info">
   <div class="title_info">添加管理员</div>
   <form action="/FlowerShop/AdminClServlet?type=update" method="post" name="theform">
   <!-- action="/FlowerShop/AdminClServlet?type=update" 可以不要，因为使用了button， Ajax异步提交 -->
   <table border="0">
  	<tr><td class="td_width1">管理员名:</td><td><input type="text" name="adminname" id="adminname" value="" onkeyup="return checkName();"/><span id="myres" style="color: red; font-size: 16px;margin-left:8px;"/></span></td></tr><!-- 使用onkeyup事件，当键盘up时响应事件 -->
  	<tr><td class="td_width1">密码:</td><td><input type="password" id="newpasswd"  name='newpasswd' value="" onblur="return checkNewpasswd();"/><span id="mynewpasswd" style="color: red; font-size: 16px;margin-left:8px;"/></span></td></tr>
  	<tr><td class="td_width1">再次输入密码:</td><td><input type="password" id="newpasswd1"  name='newpasswd1' value="" onblur="return checkNewpasswd1();"/><span id="mynewpasswd1" style="color: red; font-size: 16px;margin-left:8px;"/></span></td></tr>
   </table>
   </form>
   <div class="updateNow1"><span class="upd_pwd1"><input style="width:120px;"  id="send"  type="button" value="立即添加" onclick="return addAdmin();" /></span> <span><input style="width:120px;" id="res" type="button" value="重置" onclick="resetval() "/> </span> <span><input style="width:120px;" type="button" value="返回上一页" onClick="goback();" /></span></div>
   </div>
   </div>
   
   
   </div>
   <!-- 尾部 -->
   <div class="tail">
   
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="abc">
  <tr>
    <td align="center" height="20px">&copy;</td>
  </tr>
  <tr>
    <td align="center" height="20px">&copy;花卉预定管理系统</td>
  </tr>
</table>
   </div>
  </body>
</html>
