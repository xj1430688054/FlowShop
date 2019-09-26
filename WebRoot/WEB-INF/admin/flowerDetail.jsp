<%@ page language="java" import="java.util.*,java.text.*,com.gcj.service.admin.*,com.gcj.domain.admin.*,com.gcj.domain.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//获取当前时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义日期格式
String nowTime = sdf.format(new java.util.Date()); 
String time=nowTime.substring(0,11);//截取字符串

//接收管理员的信息
Admin admin = (Admin)request.getSession().getAttribute("loginadmin");
//接收用户的详细信息
FlowerBean flower =(FlowerBean)request.getAttribute("flowerdetail");
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
			history.back();	//history 为js 的一个对象
		}
	
	
	function showFlowerInfo(flowerid){
		//查看花卉附加信息
		//alert("要查看的花卉的编号="+flowerid);
		//跳转到处理查看花卉附加信息的页面
		window.open("/FlowerShop/AdminFlowerCl?type=flowerinfo&no="+flowerid+"","_self");
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
   <div class="welcome">当前所在>>花卉详细信息</div>
   <!--  
   <div class="user_detail">
  	<table border="1" cellspacing=0>
  	
  	</table>
  	<div class="admin_go_back"><input type="image" src="images/back.jpg" onClick="goback();"/></div>
   </div>-->
   <div class="admin_flower_pic"><img src='images/<%=flower.getPhoto() %>' /></div>
   <div class="admin_flower_detail">
   <table border="0">
   <tr><td class="td_width2">编号:</td><td><%=flower.getFlowerid() %></td></tr>
   <tr><td class="td_width2">名称:</td><td><%=flower.getFlowername() %></td></tr>
   <tr><td class="td_width2">价格:</td><td>￥<%=flower.getFlowerprice() %></td></tr>
   <tr><td class="td_width2">市场价:</td><td>￥<%=flower.getFlowerprice() %></td></tr>
   <tr><td class="td_width2">类型:</td><td><%=flower.getFlowertype() %></td></tr>
   <tr><td class="td_width2">库存量:</td><td><%=flower.getFlowernum() %></td></tr>
   <tr><td class="td_width2">单位:</td><td><%=flower.getFlowerunit() %></td></tr>
   <tr><td class="td_width2">起批量:</td><td><%=flower.getStartsale() %></td></tr>
   <tr><td class="td_width2">产地:</td><td><%=flower.getFlowerfield() %></td></tr>
   <tr><td class="td_width2">介绍:</td><td><%=flower.getFlowerintro() %></td></tr>
   </table>
   </div>
   </div>
   <div class="admin_flower_ba">
    <!-- <div class="admin_flower_back"><input type="image" src="images/back.jpg" onClick="goback();"/></div>-->
    <span class="admin_flower_back"><input type="image" src="images/back.jpg" onClick="goback();"/></span>
    <span class="admin_flower_back1"><input type="button" value="查看花卉附加信息" style="width:180px;height:30px;border:0;background-color:#F35901;line-height: 30px;font-size: 20px;" onclick="showFlowerInfo(<%=flower.getFlowerid() %>)"/></span>
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
