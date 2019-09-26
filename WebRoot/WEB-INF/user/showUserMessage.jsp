<%@ page language="java" import="java.util.*,java.text.*,com.gcj.service.*,com.gcj.domain.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取当前时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义日期格式
String nowTime = sdf.format(new java.util.Date()); 
String time=nowTime.substring(0,11);//截取字符串

//接收用户信息
Users user = (Users)request.getSession().getAttribute("loginuser");

//分页操作

//默认显示第一页
//int pageNow =1;
//int pageSize=8;//每页显示8条记录
//使用FlowerService 完成分页功能，也可以走一下Servlet
//FlowerService flowerService = new FlowerService();

//得到pageNow
//String spageNow = (String)request.getAttribute("pageNow");
//if(spageNow!=null){		//表示是通过点击分页传过来的
	//pageNow = Integer.parseInt(spageNow);
//}

//ArrayList al = flowerService.getFlowersByPage(pageSize,pageNow);
//得到共有多少页

UserMessage userMessage = (UserMessage)request.getAttribute("usermessage");
ArrayList messageal =(ArrayList)request.getAttribute("messageal");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml=transitional.dtd"><!-- doctype声明很重要，没有后面这句话首页在ie中显示不正确 为了让IE浏览器支持w3c标准，需要声明DOCTYPE -->
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>太阳舞花卉预订主页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/admin_index.css">
	<link rel="stylesheet" type="text/css" href="css/user_index.css">
	<link rel="stylesheet" type="text/css" href="css/comm.css">
	<script type="text/javascript">
	function CheckIndexLogout(user){	//验证用户是否已经登录
		if(user==null){
			window.alert("您还没有登录，请先登录!");
			return false;
		}else{
			return true;
		}
	}
	
	function checkType(){	//下拉框 检查类型
		var flowertype=$("type").value;
		//window.alert(type);
		if(flowertype =="type"){
			window.alert("您还没有花卉类型,请先选择!");
			return false;
		}else{
			return true;
		}
		//获取选中的option的文本值
		//var flowertype=$("type");
		//var ftype=flowertype.options[flowertype.selectedIndex].text;
		//alert(ftype);
	
	}
	function $(id){
		return document.getElementById(id);
	}
	
	function selectFlower(){
		if(checkType()){
			var flowertype=$("type");
			var ftype=flowertype.options[flowertype.selectedIndex].text;
			var keyword=$("keyword").value;
			if(keyword==""){
				alert("请输入希望查询的花卉名");
				return false;
			}
			//跳转到处理这一请求的控制器
			window.open("/FlowerShop/ShowFlowerClServlet?type=selectflower&key="+keyword+"&ftype="+ftype+"","_self");
			//alert("关键字="+keyword);
			//alert("选择的花卉类型="+ftype);
		}else{
			alert("请先选择花卉类型!");
			return false;
		}
		
	}
	
	function CheckLogin(user){
		if(user==null){
			window.alert("您还没有登录，请先登录!若您还没有账号，请先注册,谢谢!");
			return false;
		}else{
			return true;
		}
	}
	</script>
	<!--  <style>
	a{cc:expression(window.status='')}
	</style>-->
  </head>
  
  <body background="images/bg.bmp">
<!-- 这是用户首页面 -->
    <div class="navi_head">
   <%
   		if(user !=null){
   		%>
   		<span>欢迎您, <font size="3"><%=user.getUsername() %></font></span>
   		<% 
   		}else{
   		 %>
   <span>您好, 请 <a href="/FlowerShop/LoginClServlet?type=gotoLoginView">登录</a> | <a href="/FlowerShop/UserClServlet?type=gotoregisterview">注册</a></span>
   <% } %>
   <span style="margin-left: 400px;">  <a href="/FlowerShop/UserClServlet?type=logout" onClick="return CheckIndexLogout(<%=user %>)">【安全退出】</a></span>
   </div>
   
   <div class="navi_pic">
   <img  onClick="return test1();"src="images/logo.gif"  height="150px" />
  <!-- 如何防止首页的logo被盗 -->
<table width="78%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="76%" align="center" ><font class="font1">花卉,让生活多姿多彩</font></td>
    <td width="24%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td bordercolor="#FFFFFF"><img src="images/account.gif" width="19" height="14" /><a href="/FlowerShop/UserClServlet?type=myaccount" onClick="return CheckIndexLogout(<%=user %>)">我的账户</a></td>
      </tr>
      <tr><td>&nbsp;</td></tr>
      <tr>
        <td bordercolor="#FFFFFF"><img src="images/cart.gif" width="20" height="15" /> <a href="/FlowerShop/ShowMyCartClServlet?type=myCart" onClick="return CheckIndexLogout(<%=user %>)">我的预订单</a></td>
      </tr>
       <tr><td>&nbsp;</td></tr>
      <tr>
        <td bordercolor="#FFFFFF"><img src="images/icon2.gif" width="20" height="20" />  <a href="/FlowerShop/OrderClServlet?type=myorder" onClick="return CheckIndexLogout(<%=user %>)">我的历史订单</a></td>
      </tr>
      <tr><td>&nbsp;</td></tr>
       <tr>
        <td bordercolor="#FFFFFF"><img src="images/icon2.gif" width="20" height="20" /> <a href="/FlowerShop/RestoreFlowerCl?type=goshowmyrestore" onClick="return CheckIndexLogout(<%=user %>)"> 我的收藏</a> </td>
      </tr>
       <tr><td>&nbsp;</td></tr>
    </table></td>
  </tr>
</table>
   
   </div>
   
   <div class="menu1">
   <ul>
   <li>
  <a href="/FlowerShop/index.jsp">首　页</a>
   </li>
   
   <li><a href="/FlowerShop/index.jsp">供应花卉</a>
  <ul>
   <li><a href="/FlowerShop/ShowFlowerClServlet?type=bh">&nbsp;百　合&nbsp;&nbsp;</a></li>
   <li><a href="/FlowerShop/ShowFlowerClServlet?type=rs">&nbsp;玫　瑰&nbsp;&nbsp;</a></li>
   <li><a href="/FlowerShop/ShowFlowerClServlet?type=lh">&nbsp;兰　花&nbsp;&nbsp;</a></li>
   <li><a href="/FlowerShop/ShowFlowerClServlet?type=fzj">&nbsp;非洲菊&nbsp;&nbsp;</a></li>
   <li><a href="/FlowerShop/ShowFlowerClServlet?type=knx">&nbsp;康乃馨&nbsp;&nbsp;</a></li>
   </ul>
   </li>
     <li><a href="/FlowerShop/ShowFlowerKnowledgeCl?type=showflowerknowledge">花卉知识</a></li>
   <li><a href="/FlowerShop/ShowFlowerTrendsCl?type=showflowernews">花卉动态</a>
   
   </li>
  <!-- <li><a href="/FlowerShop/ForumClServlet?type=showAllpost">论坛交流</a></li> -->
 
 <li><a href="/FlowerShop/UserMessageCl?type=aftersearch" onClick="return CheckLogin(<%=user %>);">我要留言</a></li>
   
    <li><a href="/FlowerShop/UserClServlet?type=showcontact">联系方式</a></li>
   </ul>
   </div>
   
   
   <div class="show_message_info">
   
   <div class="now_location"><span style="font-weight:bold;">当前所在>>用户留言</span></div>
   <!-- 此处显示用户点击的留言 -->
   <div class="select_message">
   <div class="show_message_title"><span>留言标题: <%=userMessage.getTitle() %></span><span>留言人: <%=userMessage.getUsername() %></span><span>留言时间: <%=userMessage.getMessagetime() %></span></div>
   <div class="show_message_content">留言内容: <%=userMessage.getContent() %></div>
   </div>
   <div class="other_message"><span style="font-weight:bold;">其他留言</span></div>
   <%
   		for(int i=0;i<messageal.size();i++){
   			UserMessage message = (UserMessage)messageal.get(i);
   	%>
   			<%
   					if(i !=0){
   			%>
   						<div class="other_message"><span style="font-weight:bold;"></span></div>
   			<% 		
   					}
   			 %>
   			
   
   			<div class="select_message">
   			<div class="show_message_title"><span>留言标题: <%=message.getTitle() %></span><span>留言人: <%=message.getUsername() %></span><span>留言时间: <%=message.getMessagetime() %></span></div>
   			<div class="show_message_content">留言内容: <%=message.getContent() %></div>
    
   			</div>
   	<% 
   		}
    %>
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