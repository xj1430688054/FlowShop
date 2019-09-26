<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//接收err
String err=(String)request.getAttribute("err");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'login.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<!-- <link rel="stylesheet" type="text/css" href="css/comm.css">-->
	<link rel="stylesheet" type="text/css" href="css/admin_css.css">
	
	<script type="text/javascript">
	function check(){	//验证用户输入的信息
			var username=document.getElementById("username").value;
			var pwd = document.getElementById("pwd").value;
			if(username==null || username==""){
				window.alert("请输入用户名");
				return false;
			}
			if(pwd==null || pwd==""){
				window.alert("请输入密码");
				return false;
			}
		}
	
	
	</script>
	
  </head>
  <body>
  <!-- 放一个管理员登录的div -->
   <div class="admin_login">
   <div class="login_head">花卉预定管理系统</div>
   <div class="login_left"> <img src="images/logo.gif"/></div>
   <div class="login_right">
   <div class="login_right_head">管理员登录</div>
   <div class="login_right_center">
   <form action="/FlowerShop/AdminLoginCl?type=login" method="post">
   <table border="0">
   <tr><td align="right">用户名:</td><td><input id="username" class="input_css" type="text" name="adminname"/></td></tr>
   <tr><td align="right">密　码:</td><td><input id="pwd" class="input_css" type="password" name="passwd" /></td></tr>
   <%
   		if(err!=null){
   	%>
   		<tr><td colspan="2" align="center"><font color="red">用户名或密码错误</font></td></tr>
   	<% 	
   		}
   
    %>
   <tr><td colspan="2" align="center"><span><input class="submit_css" type="submit" value="登录" onClick="return check()"/></span><span><input class="submit_css" type="reset" value="重置" /></span></td></tr>
   </table>
   </form>
   </div>
   </div>
  
   </div>
   
    
  </body>
</html>
