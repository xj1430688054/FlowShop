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
//得到购物车的信息
ArrayList al = (ArrayList)request.getAttribute("mycartinfo");
//得到购物车
MyCart myCart =(MyCart)request.getSession().getAttribute("myCart");
FlowerService flowerService = new FlowerService();
//得到reserve_flower
//FlowerBean flowerBean =(FlowerBean)request.getSession().getAttribute("reserve_flower");
/*此页面显示的数据来自两个操作，一个是"立即预订",另一个是通过购物车结算来的,所以要分开显示,可以判断reserve_flower*/
/*是否为空来决定怎样显示预订的花卉信息*/

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml=transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>提交订单</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/user_index.css">
	<link rel="stylesheet" type="text/css" href="css/comm.css">
	<script type="text/javascript">
	function goback(){	//返回上一页
			history.back();	//history 为js 的一个对象
		}
		
	function submitOrder(){
		//提交订单之前验证用户是否已经输入该填的信息
		//①验证留言栏是否有留言
		var message=document.getElementById("extrainfo").value;
		if(message.length >=50){
			document.getElementById("extrainfo").value="您的其他需求";
			window.alert("您输入的内容太多!");
			return false;
		}
		if(document.getElementById("sendaddress").value==""){
			window.alert("收花地址不能为空，请保证地址正确!默认为联系地址");
			//document.getElementById("sendaddress").value=addressinfo;
			theform.reset();
			return false;
		}
		
		var paymode=document.getElementsByName("payedway");	//通过getElementsByName("payedway")获取所有的属性值
		var b=false;
		var i=0;
		for(i=0;i<paymode.length;i++){
			if(paymode[i].checked){	//如果有被选中的
				b=true;
				break;
			}
		}
		if(b){
			//window.alert("您已选择了付款方式");
			//window.open("/FlowerShop/OrderClServlet?type=reserve","_self");
			return true;
		}else{
			window.alert("请选择付款方式");
			return false;
		}
	}	
	
	function checkExtraInfo(){
		//鼠标聚焦到文本框	
		document.getElementById("extrainfo").value="";
	}
	</script>
  </head>
  
  <body background="images/bg.bmp">
   <div class="navi_head">
   <span>您好,&nbsp;<font size="4px"><%=user.getUsername() %></font>&nbsp;&nbsp;&nbsp;等级:&nbsp;<%=user.getGrade() %></span>
   <span style="margin-left: 400px;"> <a href="">【返回首页】</a></span>
   </div>
    <div class="navi_reserve">
   <img  onClick="return test1();"src="images/logo.gif"  height="150px" />
  <!-- 如何防止首页的logo被盗 -->
  	<div class="cart_navi"><img src="images/cartnavi-3.gif" /></div>
   </div>
  	<div class="user_detailinfo">
  	<div class="check">感谢您的光临，请您确认以下信息</div>
  	<div class="user_info">个人详细信息</div>
  	<div class="detail_info"><!-- userid,username,truename,email,phone,address,postcode,grade,score 插入一个表格-->
  	<table>
  	<tr><td>用户编号:</td><td><%=user.getUserid() %></td></tr>
  	<tr><td>用户名:</td><td><%=user.getUsername() %></td></tr>
  	<tr><td>真实姓名:</td><td><%=user.getTruename() %></td></tr>
  	<tr><td>电子邮件:</td><td><%=user.getEmail() %></td></tr>
  	<tr><td>联系电话:</td><td><%=user.getPhone() %></td></tr>
  	<tr><td>联系地址:</td><td><%=user.getAddress() %></td></tr>
  	<tr><td>邮　编:</td><td><%=user.getPostcode() %></td></tr>
  	<tr><td>用户等级:</td><td><%=user.getGrade() %></td></tr>
  	<tr><td>用户积分:</td><td><%=user.getScore() %></td></tr>
  	<tr><td colspan="2">如果您的信息有误，请先<a href="/FlowerShop/UserClServlet?type=myaccount" style="text-decoration:none;color:red;">修改</a>再进行其他操作，谢谢！</td></tr>
  	</table>
  	<div class="score_info">放个图片，此处放点积分的介绍</div>
  	</div>
  	<div class="reservation_info">预订花卉信息</div>
  	<div class="flower_info">
  	<table class="flower_detail_info">
  	<tr><td>编号</td><td>花卉名称</td><td>价格</td><td>数量</td><td>市场价</td><td>为您节省</td><td>小计</td></tr>
  	<%	//此处主要是处理用户点击"去结算"提交订单的
  		for(int i=0;i<al.size();i++){
  			FlowerBean flower = (FlowerBean)al.get(i);
  			//System.out.println("展示预订花卉界面中nums="+flower.getReservenums());
  	 %>
  	 <tr><td><%=flower.getFlowerid() %></td><td><%=flower.getFlowername() %></td><td>￥<%=flower.getFlowerprice() %></td><td><%=myCart.getFlowerNumById(""+flower.getFlowerid()) %> <%=flower.getFlowerunit() %></td><td>￥<%=flower.getMarketprice() %></td><td>￥<%=flowerService.getSaveSingleMoney(flower,myCart)%></td><td>￥<%=flowerService.getSingleFlowerPrice(flower,myCart) %></td></tr>
  	 <% }
  	  %>
  	</table>
  	</div>
  	<form action="/FlowerShop/OrderClServlet?type=frommyCart" method="post" name="theform">
  	<div class="flower_other_info">
  	<table>
  	<tr><td rowspan="2">给我留言:<input type="text"  id="extrainfo" name="othermessage" value="您的其他需求"  onFocus="checkExtraInfo()" /></td><td>付款方式:<input type="radio" name="payedway" value="货到付款" />货到付款 &nbsp;<input type="radio" name="payedway" value="网银付款"/>网银付款</td></tr>
  	<!--  <tr><td>您的积分:0 &nbsp;&nbsp;折扣率:0</td></tr>-->
  	</table>
  	</div>
  	<div class="send_address">送花地址:<input id="sendaddress"  type="text" name="sendfloweraddress" value="<%=user.getAddress() %>"/><span>(如果送花地址不正确，请您修改)</span></div>
  	<div class="total_price_info"><div class="total_price"><font size="4px">订单总价:￥<%=myCart.getTotalPrice() %><br/>联系人:<%=user.getTruename() %><br/>联系电话:<%=user.getPhone() %></font></div></div>
  	<div class="submit_order"><input onClick="return submitOrder();" type="image" src="images/submitorder.jpg" /></div>
  	</form>
  	<div class="go_back"><input type="image" src="images/back.jpg" onClick="goback();"/></div>
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
