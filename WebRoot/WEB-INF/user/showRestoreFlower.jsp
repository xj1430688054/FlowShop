<%@ page language="java" import="java.util.*,com.gcj.domain.*,com.gcj.service.*,java.text.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取当前时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义日期格式
String nowTime = sdf.format(new java.util.Date()); 


//得到用户信息
Users user=(Users)request.getSession().getAttribute("loginuser");
//得到al
//ArrayList al = (ArrayList)request.getAttribute("restoreflower");

//默认显示第一页
int pageNow =1;
int pageSize=4;//每页显示4条记录
//使用FlowerService 完成分页功能，也可以走一下Servlet
FlowerService flowerService = new FlowerService();

//得到pageNow
String spageNow = (String)request.getAttribute("pageNow");
if(spageNow!=null){		//表示是通过点击分页传过来的
	pageNow = Integer.parseInt(spageNow);
}

ArrayList al = flowerService.getRestoreFlowersByPage(pageSize,pageNow,user.getUserid()+"");
//得到共有多少页
int pageCount = flowerService.getRestorePageCount(pageSize,user.getUserid()+"");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml=transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>我的收藏</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/admin_index.css">
	<link rel="stylesheet" type="text/css" href="css/user_index.css">
	<link rel="stylesheet" type="text/css" href="css/user_css.css">
	
	<script type="text/javascript">
	
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
	
	function del(flowerid){
		//获得Ajax引擎
		if(window.confirm("您真的要删除吗?")){
			xmlHttpRequest=getXmlHttpObject();
			if(xmlHttpRequest){	//创建成功
				//通过xmlHttpRequest对象发送请求道服务器的某个页面
				//第一个参数表示请求的方式,"get" / "post"
				//第二个参数指定url,对哪个页面发出ajax 请求(本质仍然是http请求)
				//第三个参数表示 true 表示使用异步机制，false表示不使用异步机制
				//window.alert("创建ok");
				//var val=document.getElementById("adminid").value;
				//使用get 方式发出请求，如果提交的用户名不变化，浏览器将不会真的发请求，而是从缓存取数据
				//解决方法:url 后带一个总是变化的参数，比如当前时间
				var url="/FlowerShop/RestoreFlowerCl?type=del&mytime="+new Date()+"&flowerid="+flowerid;
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
		}else{
			return false;
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
		
	function CheckLogin(user){
		if(user==null){
			window.alert("您还没有登录，请先登录!若您还没有账号，请先注册,谢谢!");
			return false;
		}else{
			return true;
		}
	}
	
	function CheckIndexLogout(user){	//验证用户是否已经登录
		if(user==null){
			window.alert("您还没有登录，请先登录!");
			return false;
		}else{
			return true;
		}
	}
	</script>
	
  </head>
  
  <body background="images/bg.bmp">
   
    <!-- 这是显示用户信息界面 -->
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
   
    
  	<div class="check">感谢您的光临，以下为您收藏的花卉</div>
  	<div class="user_info">收藏的花卉 <span style="float: right;margin-right: 10px;"><a href="/FlowerShop/index.jsp" style="text-decoration: none;color:#92E587;">返回首页</a></span></div>
  	
  	<%
  		if(al.size()==0){	//没有收藏过花
  	%>
  		
  			<div class="no_store_flower"><div class="no_store_flower_tishi">您还没有收藏过花卉!</div></div>
  	<% 
  		}else{
  	 %>
  	
  	<!-- 分页显示收藏的花卉，每页显示4条记录 -->
  	<div class="show_restore">
  	
  	<%
   		//此处开始分页显示记录
   		int start=0;
   		for(int i=0;i<2;i++){	//显示2行，每行两个，可能不够显示
   			for(int j=0;j<2;j++){	//每行显示两个
   				RestoreFlower flower = new RestoreFlower();
   				if(start>=al.size()){	////当记录的条数不够显示时，采用的办法为：把不够显示的用一个特定大小的div填充起来
   					//不能再取，用一个固定大小的div填充
   					%>
   					 <div class="restore_flower"></div>
   				<%
   				}else{
   					flower = (RestoreFlower)al.get(start);
   					start++;
   				%>
  	<div class="restore_flower">
  	<div class="restore_flower_pic"><a href="/FlowerShop/ShowFlowerClServlet?type=showDetail&id=<%=flower.getFlowerid() %>"><img src="images/<%=flower.getPhoto() %>" border="0"/></a></div>
  	<div class="restore_intro">
  	<table border="0">
  	<tr><td colspan="2"><a href="/FlowerShop/ShowFlowerClServlet?type=showDetail&id=<%=flower.getFlowerid()%>" style="border: 0px;"><%=flower.getFlowername() %></a></td></tr>
  	<tr><td>价格:￥<%=flower.getFlowerprice() %></td><td>市场价:￥<%=flower.getMarketprice() %></td></tr>
  	<tr><td colspan="2">收藏时间:<%=flower.getRestoretime() %> &nbsp;<input type="button" value="删除" onclick="return del(<%=flower.getFlowerid() %>)" style="border: 0px;font-size: 18px;background-color:#92E587;"/></td></tr>
  	</table>
  	</div>
  	</div>
  	<%
  			}
  		}
  	}
  	 %>
  	</div>
  	<div class="restore_flower_fenye"><span>
  	
  	 <%
    	    //显示上一页
			if(pageNow !=1 && pageCount!=0){	//不等于第一页才有上一页
			%>
				<a href='/FlowerShop/RestoreFlowerCl?type=goshowmyrestore&pageNow=<%=pageNow-1 %>'>上一页</a>
			<% 
			}
			
    
     %>
  	
  	
  	 <%
    		for(int i=1;i<=pageCount;i++){
    			out.println("&nbsp;");
    		
    		%>
    			<a href='/FlowerShop/RestoreFlowerCl?type=goshowmyrestore&pageNow=<%=i %>'>[<%=i %>]</a>
    		<%
    		}
    		%>
  	
  	 <%
            //显示下一页
			if(pageNow!=pageCount && pageCount!=0){	//不等于最后一页才有下一页
			%>
				<!-- <a href='/UsersManager4/ManageUsers?pageNow="+(pageNow+1)+"'>下一页</a>-->
				<a href='/FlowerShop/RestoreFlowerCl?type=goshowmyrestore&pageNow=<%=pageNow+1 %>'>下一页</a>
			<% 
			}
			//最后一页
			if(pageNow!=pageCount && pageCount!=0){	//不等于最后一页才有最后一页
			
			%>
				<a href='/FlowerShop/RestoreFlowerCl?type=goshowmyrestore&pageNow=<%=pageCount %>'>最后一页</a>
			<% 
			}
			%>
			<% 
			//显示分页信息
			
			%>
			<%
				if(pageCount==0){
					pageNow=0 ;
			 %>
			<font>当前页<%=pageNow%>/总页数<%=pageCount%></font>
			<%
			}else{
			 %>
			 <font>当前页<%=pageNow%>/总页数<%=pageCount%></font>
			 <%
			 }
			  %>
			  </span>
  	</div>
  	<%
  		}
  	 %>
	
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

