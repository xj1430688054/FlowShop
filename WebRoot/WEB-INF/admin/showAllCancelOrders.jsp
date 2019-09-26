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
//得到al
ArrayList cancelal = (ArrayList)request.getAttribute("cancelal");
//String spageCount=(String)request.getAttribute("pagecount");
//String spageNow=(String)request.getAttribute("pageNow");
int pageNow = (Integer)request.getAttribute("pageNow");//Integer.parseInt(spageNow);
int pageCount = (Integer)request.getAttribute("pagecount");//Integer.parseInt(spageCount);
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
	
	function getOrderDetail(orderid){	//查看订单的具体信息
		//首先获取订单的id 
		//跳转到处理这一请求的控制器
		//alert("订单编号="+orderid);
		window.open("/FlowerShop/AdminOrderCl?type=orderDetail&id="+orderid+"","_self");
		
	}
	function selectOrder(){	//查询订单
		//查询订单
		//获得订单号
		var id = document.getElementById("orderid").value;
		var reg = /^(\d)+$/gi;
		if(id==""){
			window.alert("请输入要查询的订单号");
			return false;
		}
		if(!reg.test(id)){
			window.alert("请输入正确的订单号");
			document.getElementById("orderid").value="";
			return false;
		}
		window.open("/FlowerShop/AdminOrderCl?type=selectorder&orderid="+id,"_self");
	}
	
	function updOrder(orderid){
		//编辑订单
		//跳转到处理这一请求的控制器
		window.open("/FlowerShop/AdminOrderCl?type=gotoupdview&id="+orderid,"_self");
	}
	function tishi(){
		alert("该订单状态不能再修改!");
	}
	
	function gotoshowallorder(){
		window.location.href="/FlowerShop/AdminFenyeCl?type=orders";
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
   <div class="welcome">当前所在>>所有取消的订单</div>
   <div class="fenye_info"> 
   
    <div class="search_order"><span style="display:block;text-align:left; margin-left:10px;">请输入订单号: <input type="text" id="orderid" name="orderid" style="width:150px;height:20px;border:solid silver;"/>&nbsp;<input type="button" value="查询" onClick="return selectOrder()" style="width:60px;height:28px;background-color:pink;"/></span></div>
   
   <table border="1" cellspacing=0>
   <tr class="tr_css"><td>订单编号</td><td>退订时间</td><td>交易状态</td><td>退订原因</td><td>订单详情</td><td>编辑</td></tr>
   <%
   
   		for(int i=0;i<cancelal.size();i++){	//分页显示
   			CancelOrder cancelOrder= (CancelOrder)cancelal.get(i);
   			String state = cancelOrder.getTradestate();
   		%>
   		<tr class="tr_css1"><td><%=cancelOrder.getOrderid() %></td>
   		<td><%=cancelOrder.getCanceltime() %></td>
   		<td><%=cancelOrder.getTradestate() %></td>
   		<td><%=cancelOrder.getCancelreason() %></td>
   		<td><input type="button" value="查看" onClick="return getOrderDetail(<%=cancelOrder.getOrderid() %>)" style="width:60px;height:25px;background-color:pink;"/></td>
   		<td>
   		<%
   			if("交易关闭".equals(state)|| "交易成功".equals(state)){
   		%>
   				<input type="button" value="编辑"  style="width:60px;height:25px;background-color:gray;" onClick="tishi()"/>
   		<%		
   			}else{
   		%>		
   				<input type="button" value="编辑" onClick="return updOrder(<%=cancelOrder.getOrderid() %>)" style="width:60px;height:25px;background-color:pink;"/>	
   		<% 
   			}
   		 %>
   		
   		</td>
   		</tr>
   	<% 
   		}
   	%>
   </table>
   
   <div class="ye">	
    <%
    	    //显示上一页
			if(pageNow !=1){	//不等于第一页才有上一页
			%>
				<a href='/FlowerShop/AdminFenyeCl?type=cancelorders&pageNow=<%=pageNow-1 %>'>上一页</a>
			<% 
			}
			
    
     %>
   
    <%
    		
    		for(int i=1;i<=pageCount;i++){
    		%>
    			<a href='/FlowerShop/AdminFenyeCl?type=cancelorders&pageNow=<%=i %>'>[<%=i %>]</a>
    		<%
    		}
    		
    		
     %>
     <%
            //显示下一页
			if(pageNow!=pageCount){	//不等于最后一页才有下一页
			%>
				<a href='/FlowerShop/AdminFenyeCl?type=cancelorders&pageNow=<%=pageNow+1 %>'>下一页</a>
			<% 
			}
			//最后一页
			if(pageNow!=pageCount){	//不等于最后一页才有最后一页
			
			%>
				<a href='/FlowerShop/AdminFenyeCl?type=cancelorders&pageNow=<%=pageCount %>'>最后一页</a>
			<% 
			}
			%>
			<% 
			//显示分页信息
			
			%>
			<font>当前页<%=pageNow%>/总页数<%=pageCount%></font>
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
