<%@ page language="java" import="java.util.*,com.gcj.domain.*,com.gcj.service.*,java.text.*,com.gcj.domain.admin.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//获取当前时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义日期格式
String nowTime = sdf.format(new java.util.Date()); 
String time=nowTime.substring(0,11);//截取字符串

//接收管理员的信息
Admin admin = (Admin)request.getSession().getAttribute("loginadmin");
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
	function updateOrder(orderid){
			//window.alert("进来了=======");
			//首先创建一个XMLHttpRequest对象
			
			//获取选中的option的文本值
			var tradetype=document.getElementById("type");
			var ftype=tradetype.options[tradetype.selectedIndex].text;
			
			//alert("订单号="+orderid);
			
			
			if(ftype=="交易中" || ftype=="买家已付款"){
				alert("原先的状态未修改，请选择不同的状态!");
				return false;
			}else{
				myXmlHttpRequest = getXmlHttpObject();
			if(myXmlHttpRequest){	//创建成功
				//获取需要的表单数据
				//创建连接服务器的url
				var url="/FlowerShop/AdminOrderCl?type=updorder&mytime="+new Date();
				var data="no="+orderid+"&ftype="+ftype+"";
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
	}
	
	function showResult1(){	//回调函数
		if(myXmlHttpRequest.readyState==4){		//HTTP就绪码为4  
				if(myXmlHttpRequest.status==200){	//HTTP 状态码为200 说明服务器处理正确
					//取出值，根据返回信息的格式定
					//alert("执行到这里了⑤");
					window.alert(myXmlHttpRequest.responseText);
					//跳转到显示所有订单的控制器
    				window.location.href="/FlowerShop/AdminFenyeCl?type=orders";
    				//window.location.reload(true);//刷新页面
				}else if(myXmlHttpRequest.status==404){	//客户端请求出错
						window.alert("请求的url不存在");
				}else{
					alert("Error:status code is:"+myXmlHttpRequest.status);
				}
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
	</script>
  </head>
  
  <body background="images/bg.bmp" >
  
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
  	<div class="user_detailinfo">
  	<div class="check">以下为用户的预订信息</div>
  	<div class="user_info">修改订单信息<span style="float: right;margin-right: 10px;"><input type="button" style="border: 0px;height:40px;font-size: 20px;font-weight: bold" onclick="goback()" value="返回上一页"/></span></div>
  	
  	<!-- 中间放一个大的div，用于放订单信息 -->
  	<div class="show_order_area">
  	<div class="xiangxi_order">
  	<table border="0">
  	<tr><td>收花人</td><td>收花地址</td><td>邮编</td><td>联系电话</td><td>付款方式</td><td>买家留言</td></tr>
  	<tr><td><%=orderInfo.getTruename() %></td><td><%=orderInfo.getSendAddress() %></td><td><%=orderInfo.getPostcode() %></td><td><%=orderInfo.getPhone() %></td><td><%=orderInfo.getPayMode() %></td><td>
  	<%
  		if("您的其他需求".equals(extrainfo)){
  	%>
  		无
  	<% 
  		}else{
  		
  	 %>
  	<%=orderInfo.getExtraInfo() %>
  	<%
  		}
  	 %>
  	</td></tr>
  	</table>
  	</div>
  	
  	<div class="order_title">
  	<table border="0">
  	<tr><td width="240px">花卉</td><td width="120px">名称</td><td width="90px">价格</td><td width="75px">数量</td><td width="100px">总价</td><td>交易状态</td>
  	<%
  		if("交易中".equals(tradestate)){
  	%>
  		<td>修改状态</td>
  	<% 
  		}
  	 %>
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
  	
  	<%
  		//显示其他空的div
  		for(int j=1;j<=al.size();j++){
  			if(al.size()==1){		//如果只有一种花卉的话,直接显示一个div
  	%>
  				<div class="order_right">
  				<div class="order_right_one"><span style="font-size: 18px;font-weight: bold">￥<%=orderInfo.getTotalPrice() %></span></div>
  				<div class="order_right_one"><span style="color: red;">
  				
  				<select id="type" style="width:110px;font-size:20px;" name="infoType" onblur="return checkType()">
    			<option value="going"><%=orderInfo.getTradestate() %></option> 
    			<%
    				if(!orderInfo.getTradestate().equals("卖家已发货")){
    			%>
    					<option value="fahuo">卖家已发货</option>
    			<% 
    				}
    			 %>
    			<option value="finish">交易成功</option>
    			</select>
  				</span></div>
  				<%
  					if("交易关闭".equals(tradestate)){
  					%>
  						<div class="order_right_one"><span><%=cancelOrder.getCancelreason() %></span></div>
  					<%	
  					}else{
  					%>
  						<div class="order_right_one"><span><input type="button" value="修改"  onClick="return updateOrder(<%=orderInfo.getId() %>)" style="width:60px;height:25px;background-color:pink;"/>	</span></div>
  					<% 
  					}
  				 %>
  				</div>
  	<% 
  			}else{	//有多种花卉
  				if(j<al.size()){	//第一个
  					if(j==1){
  			%>
  					<div class="order_right">
  					<div class="order_right_two"><span style="font-size: 18px;font-weight: bold">￥<%=orderInfo.getTotalPrice() %></span></div>
  					<div class="order_right_two"><span style="color: red;">
  					
  					<select id="type" style="width:110px;font-size:20px;" name="infoType" onblur="return checkType()">
    			<option value="going"><%=orderInfo.getTradestate() %></option>
    			<%
    				if(!orderInfo.getTradestate().equals("卖家已发货")){
    			%>
    					<option value="fahuo">卖家已发货</option>
    			<% 
    				}
    			 %>
    			<option value="finish">交易成功</option>
    			</select>
  				</span></div>
  					
  					<%
  					if("交易关闭".equals(tradestate)){
  					%>
  						<div class="order_right_two"><span><%=cancelOrder.getCancelreason() %></span></div>
  					<%	
  					}else{
  					%>
  						<div class="order_right_two"><span><input type="button" value="修改"  onClick="return updateOrder(<%=orderInfo.getId() %>)" style="width:60px;height:25px;background-color:pink;"/>	</span></div>
  					<%
  					}
  				 %>
  					</div>
  			<% 	
  					}else{
  				%>
  					<div class="order_right">
  					<div class="order_right_two"><span></span></div>
  					<div class="order_right_two"><span></span></div>
  					<div class="order_right_two"><span></span></div>
  					</div>			
  				<% 
  					}	
  				}else if(j==al.size()){
  				%>
  					<div class="order_right">
  					<div class="order_right_one"><span></span></div>
  					<div class="order_right_one"><span></span></div>
  					<div class="order_right_one"><span></span></div>
  					</div>
  				<%
  				}
  			}
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
