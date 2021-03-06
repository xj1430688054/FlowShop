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
//付款方式
String paymode = orderInfo.getPayMode();
//交易状态
String tradestate=orderInfo.getTradestate();
//是否付款
String ispayed = orderInfo.getIsPayed();
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
			alert("放弃取消订单");
			return false;
		}
	}
	
	function getOrderDetail(orderid){		//查看订单详情
		//alert("要查看的订单编号="+orderid);
		//跳转到处理查看订单详情的控制器
		window.open("/FlowerShop/OrderClServlet?type=goshoworderdetail&no="+orderid+"","_self");
	}
	
	function gotopay(orderid){	//模拟去付款 
		alert("将要前往付款界面!");
		//跳转到付款界面
		window.open("/FlowerShop/OrderClServlet?type=gotopayview&id="+orderid+"","_self");
	}
	
	</script>
  </head>
  
  <body background="images/bg.bmp" >
  
  <div class="navi_head">
   <span>您好,&nbsp;<font size="4px"><%=user.getUsername() %></font>&nbsp;&nbsp;&nbsp;等级:&nbsp;<%=user.getGrade() %></span>
   <span style="margin-left: 450px;"></span>
   </div>
    <div class="navi_reserve">
   <img  onClick="return test1();"src="images/logo.gif"  height="150px" />
  <!-- 如何防止首页的logo被盗 -->
  	<div class="cart_navi"><img src="images/cartnavi-4.gif" /></div>
   </div>
  	<div class="user_detailinfo">
  	<div class="check">感谢您的光临，订单处理成功</div>
  	<div class="user_info">订单信息<span style="float: right;margin-right: 10px;"><a href="/FlowerShop/index.jsp" style="text-decoration: none;color:#92E587;">返回首页</a></span></div>
  	
  	<!-- 中间放一个大的div，用于放订单信息 -->
  	<div class="show_order_area">
  	
  	<div class="order_title">
  	<table border="0">
  	<tr><td width="240px">花卉</td><td width="120px">名称</td><td width="90px">价格</td><td width="75px">数量</td><td width="100px">总价</td><td>交易状态</td><td>交易操作</td></tr>
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
  				<div class="order_right_one"><span style="color: red;"><%=orderInfo.getTradestate() %><br/><br/>
  					<%
  						if("网银付款".equals(paymode)&& !("交易关闭".equals(tradestate))&& ("否".equals(ispayed))){	//去付款的前提是:①付款方式为网银付款;②交易未关闭;③订单未付款
  						%>
  							<input type="button" value="去付款" onclick="gotopay(<%=orderInfo.getId() %>)"/>
  						<% 	
  						}
  						if("交易成功".equals(tradestate)){
  						%>
  							<input type="button" value="去评价" onclick="gotoevaluate()"/>
  						<% 
  						}
  						
  				 %>
  				
  				</span></div>
  				<div class="order_right_one"><span><input type="button" value="订单详情" onClick="getOrderDetail(<%=orderInfo.getId() %>)"/><br/><br/>
  				<%
  					if(!("交易关闭".equals(tradestate))){
  					%>
  						<input type="button" value="取消订单" onClick="return cancelOrder(<%=orderInfo.getId() %>);"/>
  					<%	
  					}
  				 %>
  				
  				
  				</span></div>
  				</div>
  	<% 
  			}else{	//有多种花卉
  				if(j<al.size()){	//第一个
  					if(j==1){
  			%>
  					<div class="order_right">
  					<div class="order_right_two"><span style="font-size: 18px;font-weight: bold">￥<%=orderInfo.getTotalPrice() %></span></div>
  					<div class="order_right_two"><span style="color: red;"><%=orderInfo.getTradestate() %><br/><br/>
  					<%
  						if("网银付款".equals(paymode)&& !("交易关闭".equals(tradestate)) && ("否".equals(ispayed))){
  						%>
  							<input type="button" value="去付款" onclick="gotopay(<%=orderInfo.getId() %>)"/>
  						<% 	
  						}
  					
  				 %>
  				
  					
  					</span></div>
  					<div class="order_right_two"><span><input type="button" value="订单详情" onClick="getOrderDetail(<%=orderInfo.getId() %>)"/><br/><br/>
  					
  					<%
  					if(!("交易关闭".equals(tradestate))){
  					%>
  						<input type="button" value="取消订单" onClick="return cancelOrder(<%=orderInfo.getId() %>);"/>
  					<%	
  					}
  				 %>
  				
  					
  					</span></div>
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
  	
  	<!-- 
  	<div class="order_right">
  	<div class="order_right_one"><span>￥<%=orderInfo.getTotalPrice() %></span></div>
  	<div class="order_right_one"><span><%=orderInfo.getTradestate() %></span></div>
  	<div class="order_right_one"><span>取消订单</span></div>
  	</div> -->
  	
  	
  	
  	<!-- <table>
  	<tr><td>订单号</td><td>收花人</td><td>收花地址</td><td>邮编</td><td>联系电话</td><td>订单时间</td><td>总价</td><td></td></tr>
  	<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><input type="button" name="detail" onclick="showDetail()"   value="查看详情"/></td></tr>
  	</table>
  	 -->
    </div>
  
  
  
  
  
  
  	<div class="ok_message">您的订单已经完成，客服稍后会打电话给您再次确认订单信息，谢谢!</div>
  	
  	<div class="show_order_info1">
  	
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
