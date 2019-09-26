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
FlowerBean flower= (FlowerBean)request.getAttribute("flower_info");
String message = (String)request.getAttribute("message");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>编辑花卉信息</title>
    
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
	function resetval(){
		theform.reset();
	}
	function goback(){	//返回上一页
		//返回上一页并刷新上一页
		//self.location=document.referrer;
		history.back();	//history 为js 的一个对象
	}
	
	function updPrice(flowerprice){		//修改价格
		var price = $("price").value;
	    var reg=/^(\d)+\.(\d)+$/gi;	
	    if(price=="" || !reg.test(price)){
	    	window.alert("请输入正确的价格");
	    	$("price").value = flowerprice;
	    	return false;
	    }else{
			return true;
		}
	}
	function updmarketPrice(marketprice){	//市场价
		var price = $("marketprice").value;
	    var reg=/^(\d)+\.(\d)+$/gi;	
	    if(price=="" || !reg.test(price)){
	    	window.alert("请输入正确的价格");
	    	$("marketprice").value = marketprice;
	    	return false;
	    }else{
			return true;
		}
	}
	function updnums(flowernums){
		var nums=$("nums").value;
		var reg=/^[1-9]\d+$/gi;
		if(nums=="" || !reg.test(nums)){
	    	window.alert("请输入正确的库存量");
	    	$("nums").value = flowernums;
	    	return false;
	    }else{
			return true;
		}
	}
	function updstartsale(startnum){
		var startnums = $("startsale").value;
		var nums=$("nums").value;//库存量
		var reg=/^(\d)+$/gi;
		if(startnums=="" || !reg.test(startnums)|| parseInt(startnums)>parseInt(nums)){
	    	window.alert("请输入正确的起批量");
	    	$("startsale").value = startnum;
	    	return false;
	    }else{
			return true;
		}
	}
	function updfield(){
		var flower_field=$("field").value;
		if(flower_field ==""){
			window.alert("请输入花卉产地");
			return false;
		}else{
			return true;
		}
	}
	function updintro(){
		var intro=$("intro").value;
		if(intro ==""){
			window.alert("请输入花卉介绍");
			return false;
		}else{
			return true;
		}
	}
	
	function check(){
		var file=$("filepic").value;
		if(file ==""){
			window.alert("请选择花卉图片");
			return false;
		}else{
			return true;
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
	
	var myXmlHttpRequest="";//设置为全局变量
	var xmlHttpRequest="";//设置为全局变量
	//二号线:发送http请求
	//使用Ajax异步修改花卉信息
	function updateFlower(){
		if(updPrice()&& updmarketPrice()&& updnums()&& updstartsale() && updfield() && updintro()){
			//window.alert("进来了=======");
			//首先创建一个XMLHttpRequest对象
			myXmlHttpRequest = getXmlHttpObject();
			if(myXmlHttpRequest){	//创建成功
				//获取需要的表单数据
				var flowerid=$("flowerid").value;
				var price = $("price").value;
				var marketprice = $("marketprice").value;
				var nums=$("nums").value;
				var startnums = $("startsale").value;
				var flower_field=$("field").value;
				var intro=$("intro").value;
				//创建连接服务器的url
				//alert("编号="+flowerid);
				//alert("执行到这里了①");
				var url="/FlowerShop/AdminFlowerCl?type=updflower&mytime="+new Date();
				//alert("执行到这里了②");
				var data="price="+price+"&marketprice="+marketprice+"&nums="+nums+"&startsale="+startnums+"&field="+flower_field+"&intro="+intro+"&id="+flowerid;
				//打开请求
				//alert("执行到这里了③");
				myXmlHttpRequest.open("post",url,true);
				//使用post 提交下面这句话必须有,告之服务器正在发送数据，且数据已经符合URL编码了
				myXmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				//指定回调函数 showResult 是函数名
				//alert("执行到这里了④");
				myXmlHttpRequest.onreadystatechange=showResult1;
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
	
	function showResult1(){	//回调函数
		if(myXmlHttpRequest.readyState==4){		//HTTP就绪码为4  
				if(myXmlHttpRequest.status==200){	//HTTP 状态码为200 说明服务器处理正确
					//取出值，根据返回信息的格式定
					//alert("执行到这里了⑤");
					window.alert(myXmlHttpRequest.responseText);
					window.location.reload(true);
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
   
   <div class="center_updflower">
   <div class="welcome">当前所在>>修改花卉信息</div>
   
    <div class="admin_flower_pic"><span>当前花卉图片</span><img src='images/<%=flower.getPhoto() %>' />
    <!-- 使用组件上传文件无法直接接收 表单传递的参数enctype='multipart/form-data',解决方法是将参数写在url后面-->
     <form action="/FlowerShop/UpdateFlowerServlet?no=<%=flower.getFlowerid() %>" method="post" enctype='multipart/form-data'>
    <table>
    <tr><td class="td_width2">更改图片:</td><td><input id="filepic" type="file" name="flowerpic"/> <input style="width:60px;height: 20px;border-color: gray;"  type="submit" value="修改" onClick="return check()"/></td></tr>
    <tr><td colspan="2" align="center"><font size="3" color="red">注意:图片大小不要超过1M</font></td></tr>
    <%
    	if(message !=null){
    	%>
    	 <tr><td colspan="2" align="center"><font size="3" color="red">图片修改成功</font></td></tr>
    <% 
    	}
    
     %>
    </table>
    </form>
    </div>
   <div class="admin_flower_detail">
   <form action="" method="post" name="theform"> 
   <table border="0">
   <tr><td class="td_width2">编号:</td><td><input type="hidden" id="flowerid" value="<%=flower.getFlowerid() %>"/><%=flower.getFlowerid() %></td></tr>
   <tr><td class="td_width2">名称:</td><td><%=flower.getFlowername() %></td></tr>
   <tr><td class="td_width2">价格:</td><td>￥<input onblur="return updPrice(<%=flower.getFlowerprice() %>)" class="updflower_css" type="text" name="price" id="price" value="<%=flower.getFlowerprice() %>" /></td></tr>
   <tr><td class="td_width2">市场价:</td><td>￥<input onblur="return updmarketPrice(<%=flower.getMarketprice() %>)" class="updflower_css" type="text" name="marketprice" id="marketprice" value="<%=flower.getMarketprice() %>" /></td></tr>
   <tr><td class="td_width2">类型:</td><td><%=flower.getFlowertype() %></td></tr>
   <tr><td class="td_width2">库存量:</td><td><input onblur="return updnums(<%=flower.getFlowernum() %>)" class="updflower_css" type="text" name="nums" id="nums" value="<%=flower.getFlowernum() %>" /></td></tr>
   <tr><td class="td_width2">单位:</td><td><%=flower.getFlowerunit() %></td></tr>
   <tr><td class="td_width2">起批量:</td><td><input onblur="return updstartsale(<%=flower.getStartsale() %>)" class="updflower_css" type="text" name="startsale" id="startsale" value="<%=flower.getStartsale() %>" /></td></tr>
   <tr><td class="td_width2">产地:</td><td><input onblur="return updfield()" class="updflower_intro" type="text" name="field" id="field" value="<%=flower.getFlowerfield() %>" /></td></tr>
   <tr><td class="td_width2">介绍:</td><td><input onblur="return updintro()" class="updflower_intro" type="text" name="intro" id="intro" value="<%=flower.getFlowerintro() %>" /></td></tr>
   <tr><td colspan="2"><input class="updnow_css"  id="send"  type="button" value="立即修改" onclick="return updateFlower()"/><input class="updnow_css" id="res" type="button" value="重置" onclick="resetval() "/><input class="updnow_css" type="button" value="返回上一页" onClick="goback();" /></td></tr>
   </table>
   </form>
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
