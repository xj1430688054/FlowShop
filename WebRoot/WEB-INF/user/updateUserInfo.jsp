<%@ page language="java" import="java.util.*,com.gcj.domain.*,com.gcj.service.*,java.text.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取当前时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义日期格式
String nowTime = sdf.format(new java.util.Date()); 


//得到用户信息
Users user=(Users)request.getSession().getAttribute("loginuser");
/* 修改个人信息要考虑的几点:(1)用户点击"立即修改"时，判断文本域中的内容是否为空;
  	(2)用户输入"用户名"时，判断输入的用户名是否已经存在，若存在，则给出"用户名已存在"的提示，否则，提示"用户名正确"
  	(3)验证电子邮件的格式是否正确;
  	(4)验证联系电话的格式是否正确;
  	(5)验证邮编是否为6为数字
  	(6)单独写一个js 文件
  */	 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml=transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>修改用户信息</title>
    
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
	
	function checktruename(){		//验证真实姓名
		if($("truename").value==""){
			$("mytruename").innerText="真实姓名很重要，不能为空";
			return false;
		}else{
			$("mytruename").innerText="";
			return true;
		}
	}
	
	function checksex(){		//验证性别
		if($("sex").value==""){
			$("mysex").innerText="性别不能为空";
			return false;
		}else if($("sex").value =="男" || $("sex").value =="女"){
			$("mysex").innerText="";
			return true;
		}else{
			$("mysex").innerText="性别只能为男或女";
			return false;
		}
	}

	function checkemail(){	//验证电子邮件
			var reg=/.+@.+\.[a-zA-Z]{2,4}$/gi ;
			//var reg=/^[-_A-Za-z0-9]+@([_A-Za-z0-9]+\.)+[A-Za-z0-9]{2,3}$/gi;
			if(!(reg.test($("email").value))){
				$("myemail").innerText="邮件格式不正确";
				return false;
			}else{
				$("myemail").innerText="";
				return true;
			}
		
	}
	
	function checkphone(){		//验证电话号码
		//var reg=/^[1](\d){10}$/gi;		//验证手机号码的正则表达式
		var reg=/^[1][3 4 5 8][0-9]{9}$/gi ;	//第一位为1，第二位只能为3，4,5,8中的任意一个
		if($("phone").value==""){
			$("myphone").innerText="联系电话很重要，不能为空";
			return false;
		}else{
			if(!(reg.test($("phone").value))){
				$("myphone").innerText="电话号码格式不正确";
				return false;
			}else{
				$("myphone").innerText="";
				return true;
			}
		}
	}
	
	function checkpostcode(){	//验证邮编
		if($("postcode").value==""){
			$("mypostcode").innerText="邮编不能为空";
			return false;
		}else{
			var reg=/^[1-9](\d){5}$/gi;//(?!)表示否定顺序环视，不匹配右边的内容。邮编的末尾不能是任意数字
			if(!(reg.test($("postcode").value))){
				$("mypostcode").innerText="邮编的格式不正确";
				return false;
			}else{
				$("mypostcode").innerText="";
				return true;
			}
		}
	}
	
	function checkaddress(){		//验证联系地址
		if($("address").value==""){
			$("myaddress").innerText="联系地址很重要，不能为空";
			return false;
		}else{
			$("myaddress").innerText="";
			return true;
		}
	}
	
	function checkInfo(){		//submit之前验证是否可以提交
		if(checkName() && checksex() && checktruename() && checkemail()&& checkphone() && checkaddress() && checkpostcode()){
			//如果以上的函数验证通过
			return true;
		}else{
			return false;
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
	}
	
	
	
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
	
		var  myXmlHttpRequest="";  	//设置为全局变量
		var  xmlHttpRequest="";
		//二号线:发送http请求
		function checkName(){		//验证用户名是否存在
			//此处的username1是用户未修改是的用户名
			//window.alert("*****程序执行到这里了*****);
			xmlHttpRequest = getXmlHttpObject();
			//window.alert("创建ok");
			//var val=document.getElementById("username").value;
			//window.alert(val);
			//怎么判断创建ok  创建失败给出错误提示
			if(xmlHttpRequest){	//创建成功
				//通过myXmlHttpRequest对象发送请求道服务器的某个页面
				//第一个参数表示请求的方式,"get" / "post"
				//第二个参数指定url,对哪个页面发出ajax 请求(本质仍然是http请求)
				//第三个参数表示 true 表示使用异步机制，false表示不使用异步机制
				//window.alert("创建ok");
				var val=document.getElementById("uname").value;
				if(val.length<6){
					document.getElementById("myres").innerText="用户名不能小于6位";
					return false;
				}
				//使用get 方式发出请求，如果提交的用户名不变化，浏览器将不会真的发请求，而是从缓存取数据
				//解决方法:url 后带一个总是变化的参数，比如当前时间
				var url="/FlowerShop/CheckNameServlet?mytime="+new Date()+"&uname1="+val;
				//打开请求
				xmlHttpRequest.open("get",url,true);
				//指定回调函数 chuli 是函数名
				xmlHttpRequest.onreadystatechange=chuli;
				
				//真的发送请求，如果是get请求则填入null即可
				//如果是post请求，则填入实际的数据
				xmlHttpRequest.send(null);
				
				if(document.getElementById("myres").innerText =="该用户名已经存在"){
					//当提示用户名已经存在时，表示用户未修改用户名
					return true;
				}
				//一旦用户修改了用户名并且合法，就返回true
				return true;
			}else{//创建失败，给出提示
				window.alert("xmlHttpRequest 创建失败!");
			}
			
		}
		
		//三号线:AjaxClServlet 处理
		//四号线:回调函数
		function chuli(){
			//window.alert("处理函数被调回"+myXmlHttpRequest.readyState);
			//取出从AjaxClServlet返回的数据
			if(xmlHttpRequest.readyState==4){		//HTTP就绪码为4  
				if(xmlHttpRequest.status==200){	//HTTP 状态码为200 说明服务器处理正确
					//取出值，根据返回信息的格式定
					//window.alert("服务器返回:"+myXmlHttpRequest.responseText);
					document.getElementById("myres").innerText=xmlHttpRequest.responseText;
					
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
			$("mypostcode").innerText="很重要，请确保正确";
			$("mytruename").innerText="很重要，请确保正确";
			$("myemail").innerText="很重要，请确保正确";
			$("myaddress").innerText="很重要，请确保正确";
			$("myphone").innerText="很重要，请确保正确";
			theform.reset();//theform 是表单名
			
		}
		
		//使用Ajax异步提交修改用户数据
		function updateInfo(){		//用户点击button立即修改
		if(checkName() && checktruename() && checkemail()&& checkphone() && checkaddress() && checkpostcode()){
			//如果以上的函数验证通过,通过Ajax异步提交到服务器，由服务器验证
			//首先创建一个XMLHttpRequest对象
			myXmlHttpRequest = getXmlHttpObject();
			if(myXmlHttpRequest){	//创建成功
				//获取需要的表单数据
				var userid = $("userid").value;
				var uname=$("uname").value;
				var truename=$("truename").value;
				var email = $("email").value;
				var phone=$("phone").value;
				var address=$("address").value;
				var postcode=$("postcode").value;
				var sex=$("sex").value;
				//创建连接服务器的url
				var url="/FlowerShop/UserClServlet?type=update&mytime="+new Date();
				var data="userid="+userid+"&username="+uname+"&truename="+truename+"&email="+email+"&phone="+phone+"&address="+address+"&postcode="+postcode+"&sex="+sex;
				//打开请求
				myXmlHttpRequest.open("post",url,true);
				//使用post 提交下面这句话必须有,告之服务器正在发送数据，且数据已经符合URL编码了
				myXmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				//指定回调函数 showResult 是函数名
				myXmlHttpRequest.onreadystatechange=showResult;
				//发送请求，填入数据
				myXmlHttpRequest.send(data);
	
			}else{//创建失败，给出提示
				window.alert("myXmlHttpRequest 创建失败!");
			}
			
		}else{
			window.alert("请正确填写信息");
			return false;
		}
		
	}
	function showResult(){	//回调函数
		if(myXmlHttpRequest.readyState==4){		//HTTP就绪码为4  
				if(myXmlHttpRequest.status==200){	//HTTP 状态码为200 说明服务器处理正确
					//取出值，根据返回信息的格式定
					window.alert(myXmlHttpRequest.responseText);	
				}else if(myXmlHttpRequest.status==404){	//客户端请求出错
						window.alert("请求的url不存在");
				}else{
					alert("Error:status code is:"+myXmlHttpRequest.status);
				}
			}
	}
	
	</script>
 </head>
  
  <body background="images/bg.bmp">
   
    <!-- 这是显示用户信息界面 -->
   <div class="navi_head">
   <span>您好，欢迎访问花卉预定管理系统</span>
   <span style="margin-left: 400px;"> <a href="/FlowerShop/index.jsp">【返回首页】</a></span>
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
  	<div class="check">感谢您的光临! 当前所在→修改个人基本信息</div>
  	<div class="user_info">修改个人信息</div>
  	<div class="updateUserInfo"><!-- userid,username,truename,email,phone,address,postcode,grade,score 插入一个表格-->
  	<form action="/FlowerShop/UserClServlet?type=update" method="post" name="theform">
  	<!-- action="/FlowerShop/UserClServlet?type=update" 可以不要，因为使用了button， Ajax异步提交 -->
  	<table border="0">
  	<tr><td class="td_width">用户编号:</td><td><%=user.getUserid() %><input id="userid" type="hidden" name="userid" value="<%=user.getUserid() %>"></td></tr>
  	<tr><td class="td_width">用户名:</td><td><input type="text" id="uname"   name='username' value="<%=user.getUsername() %>" onkeyup="return checkName();" /><span id="myres" style="color: red; font-size: 16px;margin-left:8px;"/></span></td></tr><!-- 使用onkeyup事件，当键盘up时响应事件 -->
  	<tr><td class="td_width">真实姓名:</td><td><input type="text" id="truename"  name='truename' value="<%=user.getTruename() %>" onkeyup="return checktruename();"/><span id="mytruename" style="color: red; font-size: 16px;margin-left:8px;"/>很重要，请确保正确</span></td></tr>
  	<tr><td class="td_width">性　别:</td><td><input type="text" id="sex"  name='sex' value="<%=user.getSex() %>" onkeyup="return checksex();"/><span id="mysex" style="color: red; font-size: 16px;margin-left:8px;"/>请确保正确</span></td></tr>
  	<tr><td class="td_width">电子邮件:</td><td><input type="text" id="email"  name='email' value="<%=user.getEmail() %>" onkeyup="return checkemail();"/><span id="myemail" style="color: red; font-size: 16px;margin-left:8px;"/>很重要，请确保正确</span></td></tr>
  	<tr><td class="td_width">移动电话:</td><td><input type="text" id="phone"  name='phone' value="<%=user.getPhone() %>" onkeyup="return checkphone();"/><span id="myphone" style="color: red; font-size: 16px;margin-left:8px;"/>很重要，请确保正确</span></td></tr>
  	<tr><td class="td_width">联系地址:</td><td><input type="text" id="address" name='address'  value="<%=user.getAddress() %>" onkeyup="return checkaddress();"/><span id="myaddress" style="color: red; font-size: 16px;margin-left:8px;"/>很重要，请确保正确</span></td></tr>
  	<tr><td class="td_width">邮　编:</td><td><input type="text" id="postcode"  name='postcode' value="<%=user.getPostcode() %>" onkeyup="return checkpostcode();"/><span id="mypostcode" style="color: red; font-size: 16px;margin-left:8px;"/>很重要，请确保正确</span></td></tr>
  	<tr><td class="td_width">用户等级:</td><td><%=user.getGrade() %></td></tr>
  	<tr><td class="td_width">用户积分:</td><td><%=user.getScore() %></td></tr>
  	</table>
  	<div class="score_info1">放个图片，此处放点积分的介绍</div>
  	<div class="updateNow"><span><input style="width:120px;"  id="send"  type="button" value="立即修改" onclick="return updateInfo();" /><!-- <input style="width:120px;"  id="send"  type="submit" value="立即修改" onclick="return checkInfo();" /> --></span> <span><input style="width:120px;" id="res" type="button" value="重置" onclick="resetval() "/> </span> <span><input style="width:120px;" type="button" value="返回上一页" onClick="goback();" /></span></div>
  	</form>
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
