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
		//使用Ajax异步提交修改用户密码
		function checkpasswd(){		//用户点击button立即修改
			//首先创建一个XMLHttpRequest对象
			myXmlHttpRequest = getXmlHttpObject();
			if(myXmlHttpRequest){	//创建成功
				//获取需要的表单数据
				var passwd = $("passwd").value;
				var adminid=$("adminid").value;
				//创建连接服务器的url
				var url="/FlowerShop/AdminClServlet?type=getOldPwd&mytime="+new Date();
				var data="adminid="+adminid+"&passwd="+passwd;
				//打开请求
				myXmlHttpRequest.open("post",url,true);
				//使用post 提交下面这句话必须有,告之服务器正在发送数据，且数据已经符合URL编码了
				myXmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				//指定回调函数 showResult 是函数名
				myXmlHttpRequest.onreadystatechange=showResult;
				//发送请求，填入数据
				myXmlHttpRequest.send(data);
				
				if($("mypasswd").innerText=="原密码输入正确"){		//注意此处是$("mypasswd").innerText 而不是$("mypasswd").value
					return true;
				}else{
					return false;
				}
				//return true;
			}else{//创建失败，给出提示
				window.alert("myXmlHttpRequest 创建失败!");
			}
			
	}
		
		//三号线:服务器脚本处理
		//四号线:回调函数
		
			
	function showResult(){	//回调函数
		if(myXmlHttpRequest.readyState==4){		//HTTP就绪码为4  
				if(myXmlHttpRequest.status==200){	//HTTP 状态码为200 说明服务器处理正确
					//取出值，根据返回信息的格式定
					$("mypasswd").innerText=myXmlHttpRequest.responseText;	
				}else if(myXmlHttpRequest.status==404){	//客户端请求出错
						window.alert("请求的url不存在");
				}else{
					alert("Error:status code is:"+myXmlHttpRequest.status);
				}
			}
	}
	
	//重置
		function resetval(){
			$("mypasswd").innerText="";
			$("mynewpasswd").innerText="";
			$("mynewpasswd1").innerText="";
			theform.reset();//theform 是表单名
		}
	
	
	//使用Ajax异步修改密码
	function updatePwd(){
		
		if(checkpasswd()&& checkNewpasswd()&& checkNewpasswd1()){
			//window.alert("进来了=======");
			//首先创建一个XMLHttpRequest对象
			xmlHttpRequest = getXmlHttpObject();
			if(xmlHttpRequest){	//创建成功
				//获取需要的表单数据
				var newpasswd = $("newpasswd").value;
				var adminid=$("adminid").value;
				//创建连接服务器的url
				var url="/FlowerShop/AdminClServlet?type=updatePwd&mytime="+new Date();
				var data="adminid="+adminid+"&newpasswd="+newpasswd;
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
					$("mypasswd").innerText="";
					$("mynewpasswd").innerText="";
					$("mynewpasswd1").innerText="";
					$("passwd").value="";
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
   <div class="welcome">当前所在>>修改个人信息</div>
   <div class="update_AdminInfo">
   <div class="adminInfo"><span>管理员:<%=admin.getName() %></span>  <span>权限:<%=admin.getGrade() %></span></div>
   <div class="detail_admin_info">
   <div class="title_info">修改密码</div>
   <form action="/FlowerShop/AdminClServlet?type=update" method="post" name="theform">
   <!-- action="/FlowerShop/AdminClServlet?type=update" 可以不要，因为使用了button， Ajax异步提交 -->
   <table border="0">
   <tr><td class="td_width1">编号:</td><td><%=admin.getId() %><input id="adminid" type="hidden" name="adminid" value="<%=admin.getId() %>"></td></tr>
  	<tr><td class="td_width1">用户名:</td><td><%=admin.getName() %></td></tr><!-- 使用onkeyup事件，当键盘up时响应事件 -->
  	<tr><td class="td_width1">原密码:</td><td><input type="password" id="passwd"  name='passwd' value="" onblur="return checkpasswd();"/><span id="mypasswd" style="color: red; font-size: 16px;margin-left:8px;"/></span></td></tr>
  	<tr><td class="td_width1">新密码:</td><td><input type="password" id="newpasswd"  name='newpasswd' value="" onblur="return checkNewpasswd();"/><span id="mynewpasswd" style="color: red; font-size: 16px;margin-left:8px;"/></span></td></tr>
  	<tr><td class="td_width1">再次输入新密码:</td><td><input type="password" id="newpasswd1"  name='newpasswd1' value="" onblur="return checkNewpasswd1();"/><span id="mynewpasswd1" style="color: red; font-size: 16px;margin-left:8px;"/></span></td></tr>
   </table>
   </form>
   <div class="updateNow1"><span class="upd_pwd1"><input style="width:120px;"  id="send"  type="button" value="立即修改" onclick="return updatePwd();" /></span> <span><input style="width:120px;" id="res" type="button" value="重置" onclick="resetval() "/> </span> <span><input style="width:120px;" type="button" value="返回上一页" onClick="goback();" /></span></div>
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
