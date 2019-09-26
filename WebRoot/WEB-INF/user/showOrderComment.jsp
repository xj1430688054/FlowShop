<%@ page language="java" import="java.util.*,com.gcj.domain.*,com.gcj.service.*,java.text.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//获取当前时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义日期格式
String nowTime = sdf.format(new java.util.Date()); 
String time=nowTime.substring(0,11);//截取字符串

//得到用户信息
Users user=(Users)request.getSession().getAttribute("loginuser");
//接收orderinfo
OrderInfo orderInfo =(OrderInfo)request.getAttribute("orderinfo");
//接收al
ArrayList al = (ArrayList)request.getAttribute("al"); //存放的是orderItem实例
//接收floweral
ArrayList floweral=(ArrayList)request.getAttribute("floweral");//存放的是预订的花卉的实例
//接收cancelOrder
CancelOrder cancelOrder = (CancelOrder)request.getAttribute("cancelorder");
//付款方式
String paymode = orderInfo.getPayMode();
//交易状态
String tradestate=orderInfo.getTradestate();
//买家留言
String extrainfo = orderInfo.getExtraInfo();
//需要orderInfo 和orderDetail实例

 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml=transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ReserveOk.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/user_index.css">
	<link rel="stylesheet" type="text/css" href="css/comm.css">
	
	<script type="text/javascript">
	function showDetail(orderid){	//用户点击"查看详情"时显示订单细节 难点:使用js 操作css
		
		window.open("/FlowerShop/OrderClServlet?type=showorderDetail&id="+orderid,"_self");
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
	//使用Ajax异步修改订单
	function updateOrder(orderid,reason){
			//window.alert("进来了=======");
			//首先创建一个XMLHttpRequest对象
			myXmlHttpRequest = getXmlHttpObject();
			if(myXmlHttpRequest){	//创建成功
				//获取需要的表单数据
				//alert("订单编号="+orderid +"退订原因="+reason);
				//创建连接服务器的url
				var url="/FlowerShop/OrderClServlet?type=cancelorder&mytime="+new Date();
				var data="orderid="+orderid+"&reason="+reason+"&mytime="+new Date();
				//打开请求
				myXmlHttpRequest.open("post",url,true);
				//使用post 提交下面这句话必须有,告之服务器正在发送数据，且数据已经符合URL编码了
				myXmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				//指定回调函数 showResult1是函数名
				myXmlHttpRequest.onreadystatechange=showResult1;
				//发送请求，填入数据
				myXmlHttpRequest.send(data);
				
			}else{//创建失败，给出提示
				window.alert("myXmlHttpRequest 创建失败!");
			}
		
	}
	
	function showResult1(){	//回调函数
		if(myXmlHttpRequest.readyState==4){		//HTTP就绪码为4  
				if(myXmlHttpRequest.status==200){	//HTTP 状态码为200 说明服务器处理正确
					//取出值，根据返回信息的格式定
					//alert("执行到这里了⑤");
					window.alert(myXmlHttpRequest.responseText);
					//跳转到ReserveOkCl控制器
    				//window.location.href="/FlowerShop/ReserveOkCl?no="+orderid+"";
    				window.location.reload(true);//刷新页面
				}else if(myXmlHttpRequest.status==404){	//客户端请求出错
						window.alert("请求的url不存在");
				}else{
					alert("Error:status code is:"+myXmlHttpRequest.status);
				}
			}
	}
	
	
	//取消订单的操作
	function cancelOrder(orderid){
		//window.alert("订单编号为"+orderid);
		if(window.confirm("订单已生成，您真的要取消预订吗?")){
			//alert("订单取消成功");
			//window.prompt("感谢您的光临，请填写退订原因，以便我们为您更好地服务，谢谢!","退订原因");
			//window.open("cancelreason.html","newwindow","height=200,width=400,top=200,left=550,toolbar=no,menuba=no,scrollbars=no,resizable=no,location=no,status=no");
			var reason=prompt("感谢您的光临，请填写退订原因，以便我们为您更好地服务，谢谢!","");//prompt() 方法用于显示可提示用户进行输入的对话框。
  			if(reason=="")
    		{
    			alert("请输入退订原因，谢谢");
    			return false;
    		}else if(reason==null){
    				alert("您取消了该操作");
    				return false;
    		}else{
    			//此处使用Ajax异步执行取消订单的实际操作
    			//alert(reason);
    			updateOrder(orderid,reason);
    			//跳转到ReserveOkCl控制器
    			//window.location.href="/FlowerShop/ReserveOkCl?no="+orderid+"";
    			//window.open("/FlowerShop/ReserveOkCl?no="+orderid+"","_self");	
    		}
		}else{
			alert("订单取消失败");
			return false;
		}
	}
	
	function getOrderDetail(orderid){		//查看订单详情
		alert("要查看的订单编号="+orderid);
		//跳转到处理查看订单详情的控制器
		window.open("/FlowerShop/OrderClServlet?type=goshoworderdetail&no="+orderid+"","_self");
	}
	
	
	function goback(){
		history.back();
	}
	
	function gotoevaluate(orderid){	//去评价
		//跳转到处理评价订单的控制器
		alert("要评价的订单号="+orderid);
		window.open("/FlowerShop/OrderClServlet?type=gotoevaluate&no="+orderid+"","_self");
	}
	
	window.onload = function(){	//页面加载时将光标聚焦在第一个文本域
		//document.getElementsByName("comment")[0].focus();
		var neirong = document.getElementsByName("comment");
		neirong[0].focus();
		neirong[0].innerText="";
	}
	
	function checkTextArea(){
		//var neirong = document.getElementById("comment").innerHTML;
		//alert(neirong);
		var neirong = document.getElementsByName("comment");//通过标签名字获取所有的textarea
		//alert("共有的文本域="+neirong.length);
		//var neirong_length = neirong.length;
		//Array text_ = new Array(neirong_length);
		//alert("创建的数组的长度="+text_.length);
		for(var i=0;i<neirong.length;i++){
			//alert("第"+(i+1)+"个文本域的内容是:"+neirong[i].innerText);
			if(neirong[i].innerText==""){
				alert("请对第"+(i+1)+"种花进行评价，谢谢!");
				return false;
			}
			if(i==neirong.length-1){
				return true;
			}
		}
	}
	function checkLength(){
		var title = $("title").value;
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
		var content = $("content").innerText;
		if(content.length>125){
			alert("您的评论内容太长,请不要超过125个字");
			return false;
		}else if(content==""){
			alert("内容不能为空");
			return false;
		}else if(content=="请在此输入对该种花的评价"){
			alert("请输入您的评价,谢谢!");
			$("content").innerText="";
			return false;
		}else{
			return true;
		}
		
	}
	function $(id){
		return document.getElementById(id);
	}
	function check(){
		if(checkText() && checkTextArea()){	//验证通过
			return true;
		}else{
			return false;
		}
	}
	function qudiaomoren(){
		$("content").innerText="";
	}
	</script>
  </head>
  
  <body background="images/bg.bmp" >
  
  <div class="navi_head">
   <span>您好,&nbsp;<font size="4px"><%=user.getUsername() %></font>&nbsp;&nbsp;&nbsp;等级:&nbsp;<%=user.getGrade() %></span>
   <span style="margin-left: 400px;"> <a href="/FlowerShop/index.jsp">返回首页</a></span>
   </div>
    <div class="navi_reserve">
   <img  onClick="return test1();"src="images/logo.gif"  height="150px" />
  <!-- 如何防止首页的logo被盗 -->
  	<div class="cart_navi"><img src="images/cartnavi-4.gif" /></div>
   </div>
  	<div class="user_detailinfo">
  	<div class="check">感谢您的光临，您可以评价花卉</div>
  	<div class="user_info">花卉评价<span style="float: right;margin-right: 10px;"><input type="button" style="border: 0px;height:40px;font-size: 20px;font-weight: bold" onclick="goback()" value="返回上一页"/></span></div>
  	
  	<!-- 中间放一个大的div，用于放订单信息 -->
  	<div class="show_order_area">
  	
  	
  	<div class="order_title">
  	<table border="0">
  	<tr><td width="240px">花卉</td><td width="120px">名称</td><td width="90px">价格</td><td width="75px">数量</td><td width="360px">评价内容</td>
  	</tr>
  	</table>
  	</div>
  	
  	<div class="orderdate"><span>订单编号:<%=orderInfo.getId() %></span><span>预订时间:<%=orderInfo.getOrderDate() %></span></div>
  	
  	<div class="order_left">
  	
  	<%
  		//此处将预订的花卉信息循环显示出来 ,floweral 和al的长度一样.floweral 根据al得到
  		for(int i=0;i<floweral.size();i++){
  			FlowerBean flower = (FlowerBean)floweral.get(i);
  			OrderItem orderItem =(OrderItem)al.get(i);
  	 %>
  	<div class="order_left_pic"><a href="/FlowerShop/ShowFlowerClServlet?type=showDetail&id=<%=flower.getFlowerid() %>"><img src="images/<%=flower.getPhoto() %>" border="0"/></a></div>
  	<div class="order_left_flower">
  	<table border="0"><tr><td><a href="/FlowerShop/ShowFlowerClServlet?type=showDetail&id=<%=flower.getFlowerid()%>" style="border: 0px;text-decoration: none;color:black;"><%=flower.getFlowername() %></a></td><td>￥<%=flower.getFlowerprice() %>/<%=flower.getFlowerunit() %></td><td><%=orderItem.getFlowernum() %><%=flower.getFlowerunit() %></td></tr></table>
  	</div>
  	<%
  		}
  	 %>
  	</div>
  	<!-- 通过表单提交数据 -->
  	<form action="/FlowerShop/OrderClServlet?type=evaluate" method="post">
  	<%
  		//显示其他空的div
  		for(int j=1;j<=al.size();j++){
  			if(al.size()==1){		//如果只有一种花卉的话,直接显示一个div
  	%>
  				<div class="order_right">
  				<div class="order_right_three">
  				 <textarea rows="11" cols="40" name="comment"  id="content" onblur="return checkText();"  onFocus="qudiaomoren()"  style="border:0;overflow:auto; " >请在此输入对该种花的评价</textarea>
  				</div>
  				</div>
  	<% 
  			}else{	//有多种花卉
  				if(j<al.size()){	//第一个
  					if(j==1){
  			%>
  					<div class="order_right">
  					<div class="order_right_three">
  					 <textarea rows="11" cols="40" name="comment" id="content1" onblur="return checkTextArea();"     style="border:0;overflow:auto; " >请在此输入对该种花的评价</textarea>
  					 <!-- style="border:0;overflow:auto; " 无滚动条的文本域;onBlur IE3|N2|O3 当前元素失去焦点时触发的事件 [鼠标与键盘的触发均可] ;  onFocus IE3|N2|O3 当某个元素获得焦点时触发的事件 -->
  					</div>
  					</div>
  			<% 	
  					}else{
  				%>
  					<div class="order_right">
  					<div class="order_right_three">
  					 <textarea rows="11" cols="40" name="comment" id="content2" onblur="return checkTextArea();"     style="border:0;overflow:auto; margin-top: 3px; " ></textarea>
  					</div>
  					</div>			
  				<% 
  					}	
  				}else if(j==al.size()){
  				%>
  					<div class="order_right">
  					<div class="order_right_three">
  					 <textarea rows="11" cols="40" name="comment" id="content3" onblur="return checkTextArea();"    style="border:0;overflow:auto; margin-top: 3px; " ></textarea>
  					</div>
  					</div>
  				<%
  				}
  			}
  		}
  		
  	
  	 %>
  	 	<!-- 通过隐藏表单传递订单号 onClick="evaluate()"-->
  		<input type="hidden" name="orderid" value="<%=orderInfo.getId() %>"/>
  		<div class="ping_lun"><input  style="height: 30px;width:100px;margin-top: 5px;" type="submit" value="发表评论" onClick="return check();"/></div>
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
