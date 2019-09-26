<%@ page language="java" import="java.util.*,com.gcj.domain.*,com.gcj.service.*,java.text.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取当前时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义日期格式
String nowTime = sdf.format(new java.util.Date()); 


//得到用户信息
Users user=(Users)request.getSession().getAttribute("loginuser");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml=transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>修改用户密码</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/user_index.css">
	<link rel="stylesheet" type="text/css" href="css/user_css.css">
	<!-- 导入jQuery框架文件 -->
	<script type="text/javascript" src="js/jquery-1.6.4.min.js"></script>
	<script type="text/javascript">
	function goback(){	//返回上一页
		//返回上一页并刷新上一页
		self.location=document.referrer;
		//history.back();	//history 为js 的一个对象
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
	
	
		//修改用户信息的方案
		//方案一.将立即修改的type设为submit,点击提交后将请求交给UsersClServlet处理,①接收传递过去的数据;
		//②根据用户id 得到用户已经存在数据库中的信息，然后判断接收到的用户名和已经存在的用户名是否相同，
		//③若相同，则不修改用户名，只修改其他几项(相应的sql语句要变);若不同，则连用户名也一起修改
		//④修改成功后跳转到一个新的页面，提示修改成功的信息
		//方案二.使用Ajax提交，将立即修改的type值设为buttton
		//①点击按钮之后，响应checkInfo()函数，使用Ajax提交数据到UserClServlet，在本页面通过alert()提示修改成功
		//②具体步骤如下:
		//③checkInfo()函数中，<1>创建一个XMLHttpRequest对象，可以使用已有的xmlHttpRequst
		//④<2>获取表单中提交的所有数据，通过getElementById()获取
		//⑤<3>建立要连接的url，即var url="/FlowerShop/UserClServlet?type=update";
		//⑥<4>打开到服务器的连接，即 myXmlHttpRequest.open("post",url,true);因为要传递的数据很多，所以用post方式提交
		//⑦<5>设置服务器在完成后要运行的函数。function showResult(){//跟chuli()函数类似，使用alert()提示用户修改成功}
		//⑧<6>发送请求。myXmlHttpRequest.send();//在send()中填入相应的参数
	
	
	//使用ajax和服务器异步交互，验证用户名是否唯一
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
				var userid=$("userid").value;
				//创建连接服务器的url
				var url="/FlowerShop/UserClServlet?type=getOldPwd&mytime="+new Date();
				var data="userid="+userid+"&passwd="+passwd;
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
	
	//使用Ajax异步修改密码
	function updatePwd(){
		
		if(checkpasswd()&& checkNewpasswd()&& checkNewpasswd1()){
			//首先创建一个XMLHttpRequest对象
			xmlHttpRequest = getXmlHttpObject();
			if(xmlHttpRequest){	//创建成功
				//获取需要的表单数据
				var newpasswd = $("newpasswd").value;
				var userid=$("userid").value;
				//创建连接服务器的url
				var url="/FlowerShop/UserClServlet?type=updatePwd&mytime="+new Date();
				var data="userid="+userid+"&newpasswd="+newpasswd;
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
		
	
		function $(id){
			return document.getElementById(id);
		}
		//重置
		function resetval(){
			$("mypasswd").innerText="";
			$("mynewpasswd").innerText="";
			$("mynewpasswd1").innerText="";
			theform.reset();//theform 是表单名
		}
		
	
	</script>
 </head>
  
  <body background="images/bg.bmp">
   
    <!-- 这是显示用户信息界面 -->
   <div class="navi_head">
   <span>您好，欢迎访问花卉预定管理系统</span>
   <span style="margin-left: 350px;"> <a href="/FlowerShop/index.jsp">【返回首页】</a></span>
   </div>
   
   <div class="navi_pic">
   <img src="images/logo.gif"  height="150px" />
  
<table width="78%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="76%" align="center"><font class="font1">花卉,让生活多姿多彩</font></td>
  </tr>
</table>
   
   </div>
   
   <div class="navi_content">
   </div>
   
    	<div class="user_detailinfo">
  	<div class="check">感谢您的光临! 当前所在→修改密码</div>
  	<div class="user_info">修改个人密码</div>
  	<div class="updateUserpwd">
  	<form action="/FlowerShop/UserClServlet?type=update" method="post" name="theform">
  	<!-- action="/FlowerShop/UserClServlet?type=update" 可以不要，因为使用了button， Ajax异步提交 -->
  	<table border="0">
  	<tr><td class="td_width">用户编号:</td><td><%=user.getUserid() %><input id="userid" type="hidden" name="userid" value="<%=user.getUserid() %>"></td></tr>
  	<tr><td class="td_width">用户名:</td><td><%=user.getUsername() %></td></tr><!-- 使用onkeyup事件，当键盘up时响应事件 -->
  	<tr><td class="td_width">原密码:</td><td><input type="password" id="passwd"  name='passwd' value="" onblur="return checkpasswd();"/><span id="mypasswd" style="color: red; font-size: 16px;margin-left:8px;"/></span></td></tr>
  	<tr><td class="td_width">新密码:</td><td><input type="password" id="newpasswd"  name='newpasswd' value="" onblur="return checkNewpasswd();"/><span id="mynewpasswd" style="color: red; font-size: 16px;margin-left:8px;"/></span></td></tr>
  	<tr><td class="td_width">再次输入新密码:</td><td><input type="password" id="newpasswd1"  name='newpasswd1' value="" onblur="return checkNewpasswd1();"/><span id="mynewpasswd1" style="color: red; font-size: 16px;margin-left:8px;"/></span></td></tr>
  	</table>
  	<div class="updateNow"><span class="upd_pwd"><input style="width:120px;"  id="send"  type="button" value="立即修改" onclick="return updatePwd();" /></span> <span><input style="width:120px;" id="res" type="button" value="重置" onclick="resetval() "/> </span> <span><input style="width:120px;" type="button" value="返回上一页" onClick="goback();" /></span></div>
  	</form>
  	</div>
  	<div class="score_info1">放个图片，此处放点积分的介绍</div>
   
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
