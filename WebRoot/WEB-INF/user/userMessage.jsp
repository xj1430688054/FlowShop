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
//int pageNow =1;
//int pageSize=4;//每页显示4条记录
//使用FlowerService 完成分页功能，也可以走一下Servlet
FlowerService flowerService = new FlowerService();

ArrayList keywordal = (ArrayList)request.getAttribute("keywordal");
ArrayList samefloweral = (ArrayList)request.getAttribute("samefloweral");
//得到pageNow
//String spageNow = (String)request.getAttribute("pageNow");
//if(spageNow!=null){		//表示是通过点击分页传过来的
	//pageNow = Integer.parseInt(spageNow);
//}

//ArrayList al = flowerService.getRestoreFlowersByPage(pageSize,pageNow,user.getUserid()+"");
//得到共有多少页
//int pageCount = flowerService.getRestorePageCount(pageSize,user.getUserid()+"");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml=transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户留言</title>
    
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
				var url="/FlowerShop/UserMessageCl?type=tj&mytime="+new Date();
				
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
					//提示完后跳转到首页
					window.location.href="/FlowerShop/index.jsp";
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
	
	function checkLength(){
		var Title = $("title").value;
		var title =Title.replace(/(^\s+)|(\s*$)/g,""); //去掉空格
		if(title.length>20){
			alert("您的标题内容太长,请不要超过20个字");
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
		if(content.length>125){
			alert("您的标题内容太长,请不要超过125个字");
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
	
	//重置
	function resetInfo(){
		$("content").value="";
		$("title").value="";
	}
	function $(id){
		return document.getElementById(id);
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
   
    
  	<div class="check">感谢您的光临,您目前在留言区</div>
  	<div class="user_info">我要留言<span style="float: right;margin-right: 10px;"><a href="/FlowerShop/index.jsp" style="text-decoration: none;color:#92E587;">返回首页</a></span></div>
  	
  	<div class="user_message">
   	<div class="message_info">
   	<div class="message_title"><span>留言标题: <input type="text" name="title" id="title"  onblur="return checkLength();"/><font style="margin-left:10px;">(提示:标题不宜太长)</font></div>
   	<div class="message_content1"><span>留言内容</div>
   	<div class="message_content">
    <textarea rows="13" cols="72" id="content" onblur="return checkText();"  style="border:0;overflow:auto; " ></textarea>
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

