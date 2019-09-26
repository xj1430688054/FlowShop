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
		var xmlHttpRequest="";//设置为全局变量
	
	function tijiao(){
		//获得Ajax引擎
		if(checkLength() && checkText()){
			xmlHttpRequest=getXmlHttpObject();
			if(xmlHttpRequest){	//创建成功
				//通过xmlHttpRequest对象发送请求道服务器的某个页面
				//第一个参数表示请求的方式,"get" / "post"
				//第二个参数指定url,对哪个页面发出ajax 请求(本质仍然是http请求)
				//第三个参数表示 true 表示使用异步机制，false表示不使用异步机制
				//window.alert("创建ok");
				//var val=document.getElementById("adminid").value;
				var title = $("title").value.replace(/(^\s+)|(\s*$)/g,"");
				var content = $("content").value.replace(/(^\s+)|(\s*$)/g,"");
				//使用get 方式发出请求，如果提交的用户名不变化，浏览器将不会真的发请求，而是从缓存取数据
				//解决方法:url 后带一个总是变化的参数，比如当前时间
				var url="/FlowerShop/AdminFlowerCl?type=tj&mytime="+new Date();
				
				var data="title="+title+"&content="+content;
				//打开请求
				//alert("执行到这里了③");
				xmlHttpRequest.open("post",url,true);
				//使用post 提交下面这句话必须有,告之服务器正在发送数据，且数据已经符合URL编码了
				xmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				//指定回调函数 showResult 是函数名
				//alert("执行到这里了④");
				xmlHttpRequest.onreadystatechange=chuli;
				//发送请求，填入数据
				xmlHttpRequest.send(data);
				
			}else{//创建失败，给出提示
				window.alert("xmlHttpRequest 创建失败!");
			}
		}else{
			alert("请检查您的输入!");
		}
	}
	function chuli(){
			//window.alert("处理函数被调回"+myXmlHttpRequest.readyState);
			//取出从AjaxClServlet返回的数据
			if(xmlHttpRequest.readyState==4){		//HTTP就绪码为4  
				if(xmlHttpRequest.status==200){	//HTTP 状态码为200 说明服务器处理正确
					//取出值，根据返回信息的格式定
					//window.alert("服务器返回:"+myXmlHttpRequest.responseText);
					window.alert(xmlHttpRequest.responseText);
					//刷新当前页面
					//window.location.reload(true);
					//提示完后跳转到显示所有动态页面
					window.location.href="/FlowerShop/AdminFlowerCl?type=showFlowerTrends";
				}else if(xmlHttpRequest.status==404){	//客户端请求出错
						window.alert("请求的url不存在");
				}else{
					alert("Error:status code is:"+xmlHttpRequest.status);
				}
			}
		}
		
	
	function checkLength(){
		var Title = $("title").value;
		var title =Title.replace(/(^\s+)|(\s*$)/g,""); //去掉空格
		if(title.length>125){
			alert("您的标题内容太长,请不要超过125个字");
			return false;
		}else if(title==""){
			alert("标题不能为空");
			return  false;
		}else{
			return true;
		}
	}
	function checkText(){
		var Content = $("content").value;
		var content = Content.replace(/(^\s+)|(\s*$)/g,""); //去掉空格
		if(content.length>65535){
			alert("您的标题内容太长,请不要超过65535个字");
			//$("content").focus();//焦点在此文本域上
			return false;
		}else if(content==""){
			alert("内容不能为空");
			//$("content").focus();//焦点在此文本域上
			return false;
		}else{
			return true;
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
   
  	<div class="user_info">当前所在>>添加花卉动态</div>
  	
  	<div class="user_message">
   	<div class="add_news">
   	<div class="message_title"><span>动态标题: <input type="text" name="title" id="title"  onblur="return checkLength();"/><font style="margin-left:10px;">(提示:标题不宜太长)</font></div>
   	<div class="message_content1"><span>动态内容</div>
   	<div class="add_content">
    <textarea rows="20" cols="73" id="content" onblur="return checkText();"  style="border:0;overflow:auto; " ></textarea>
   	</div><!-- style="border:0;overflow:auto; " 设置文本域没有滚动条 -->
   	<div class="tijiao"><span><input class="tijiao_input" type="button" value="提交" onclick="tijiao()"/> <input class="tijiao_input" type="button" value="重置"  onClick="resetInfo()"/></span></div>
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
