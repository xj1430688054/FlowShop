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
ArrayList al = (ArrayList)request.getAttribute("message");
//String spageCount=(String)request.getAttribute("pagecount");
//String spageNow=(String)request.getAttribute("pageNow");
int pageNow = (Integer)request.getAttribute("pageNow");//Integer.parseInt(spageNow);
int pageCount =(Integer)request.getAttribute("pagecount");// Integer.parseInt(spageCount);
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
	function selectMessage(){	//查询订单
		//查询订单
		//获得订单号
		var message = document.getElementById("message").value;
		var reg = /^(\d)+$/gi;
		if(message==""){
			window.alert("请输入要查询的留言编号");
			return false;
		}
		if(!reg.test(message)){
			window.alert("请输入正确的留言编号");
			document.getElementById("message").value="";
			return false;
		}
		window.open("/FlowerShop/AdminMessageCl?type=selectmessage&no="+message,"_self");
	}
	
	
	
	//使用Ajax 异步删除user
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
	
	function updMessage(messageid){
		xmlHttpRequest=getXmlHttpObject();
		if(xmlHttpRequest){	//创建成功
				//通过xmlHttpRequest对象发送请求道服务器的某个页面
				//第一个参数表示请求的方式,"get" / "post"
				//第二个参数指定url,对哪个页面发出ajax 请求(本质仍然是http请求)
				//第三个参数表示 true 表示使用异步机制，false表示不使用异步机制
				//window.alert("创建ok");
				//使用get 方式发出请求，如果提交的用户名不变化，浏览器将不会真的发请求，而是从缓存取数据
				//解决方法:url 后带一个总是变化的参数，比如当前时间
				//window.alert("用户编号="+userid);
				var url="/FlowerShop/AdminMessageCl?type=upd&mytime="+new Date()+"&no="+messageid;
				//打开请求
				xmlHttpRequest.open("get",url,true);
				//指定回调函数 chuli 是函数名
				xmlHttpRequest.onreadystatechange=chuli;
				
				//真的发送请求，如果是get请求则填入null即可
				//如果是post请求，则填入实际的数据
				xmlHttpRequest.send(null);
			}else{//创建失败，给出提示
				window.alert("xmlHttpRequest 创建失败!");
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
					window.location.reload(true);
				}else if(xmlHttpRequest.status==404){	//客户端请求出错
						window.alert("请求的url不存在");
				}else{
					alert("Error:status code is:"+xmlHttpRequest.status);
				}
			}
		}
	
	
	
	
	function tishi(){
		alert("该留言已经审核过!");
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
   
   <div class="show_allmessage"> 
   
    <div class="welcome1"><span>当前所在>>所有留言</span></div>
   <div class="search_message">
   <span>请输入留言编号: <input type="text" id="message" name="message" style="width:150px;height:20px;border:solid silver;"/>&nbsp;<input type="button" value="查询" onClick="return selectMessage()" style="width:60px;height:28px;background-color:pink;"/></span>
   </div>
   
   <div class="show_messagetitle">
   <table border="0">
   <tr><td class="message_td">留言编号</td><td>用户名</td><td>留言时间</td><td>是否审核过</td><td>审核</td></tr>
   </table>
   </div>
   
   <%
   		for(int i=0;i<al.size();i++){
   			UserMessage userMessage = (UserMessage)al.get(i);
   			String state = userMessage.getIschecked();
   	%>
   			<div class="show_messagecontent">
   			<div class="nei_rong"><span><%=userMessage.getId() %></span></div>
   			<div class="nei_rong"><span><%=userMessage.getUsername() %></span></div>
   			<div class="nei_rong"><span><%=userMessage.getMessagetime() %></span></div>
   			<div class="nei_rong"><span><%=userMessage.getIschecked() %></span></div>
   			<div class="nei_rong"><span>
   			<%
   				if("是".equals(state)){
   			%>
   					<input type="button" value="审核"  style="width:60px;height:25px;background-color:gray;" onClick="tishi()"/>
   			<% 
   				}else{
   			%>
   					<input type="button" value="审核" onClick="return updMessage(<%=userMessage.getId() %>)" style="width:60px;height:25px;background-color:pink;"/>	
   			<% 
   				}
   			
   			 %>
   			</span></div>
   			</div>
   			<div class="message_title"> <span><font color="red">留言标题:</font><%=userMessage.getTitle() %></span></div>
   
   			 <div class="message_con"><span><font color="red">留言内容:</font><%=userMessage.getContent() %></span></div>
   			
   		
   	<% 
   		}
   	
    %>
   		
   	    
   	    
  		
   	</div>
   		<div class="message_ye"><span>
   		<%
    	    //显示上一页
			if(pageNow !=1){	//不等于第一页才有上一页
			%>
				<a href='/FlowerShop/AdminFenyeCl?type=message&pageNow=<%=pageNow-1 %>'>上一页</a>
			<% 
			}
			
    
     %>
   
    <%
    		
    		for(int i=1;i<=pageCount;i++){
    		%>
    			<a href='/FlowerShop/AdminFenyeCl?type=message&pageNow=<%=i %>'>[<%=i %>]</a>
    		<%
    		}
    		
    		
     %>
     <%
            //显示下一页
			if(pageNow!=pageCount){	//不等于最后一页才有下一页
			%>
				<a href='/FlowerShop/AdminFenyeCl?type=message&pageNow=<%=pageNow+1 %>'>下一页</a>
			<% 
			}
			//最后一页
			if(pageNow!=pageCount){	//不等于最后一页才有最后一页
			
			%>
				<a href='/FlowerShop/AdminFenyeCl?type=message&pageNow=<%=pageCount %>'>最后一页</a>
			<% 
			}
			%>
			<% 
			//显示分页信息
			
			%>
			<font>当前页<%=pageNow%>/总页数<%=pageCount%></font>
   		
   		
   		</span></div>
   	
   	

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
