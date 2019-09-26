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
OrderInfo orderInfo = (OrderInfo)request.getAttribute("orderinfo");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml=transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>付款界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/user_index.css">
	<link rel="stylesheet" type="text/css" href="css/user_css.css">
	<script type="text/javascript">
		function goback(){
			history.back();
		}
		
		
		function checkCard(){
			var cardnum=document.getElementById("cardnum").value;
			if(cardnum !=""){
			    var reg=/^[1-9][0-9]{18}$/gi; //第一位不能为0
				if(reg.test(cardnum)){
					return true;
				}else{
					alert("请输入正确的19位卡号");
					document.getElementById("cardnum").value="";//将控件中的内容清空
					//document.getElementById("cardnum").focus();//将光标聚焦到该控件上
				    return false;
				}	
			}else{
			    alert("请输入正确的卡号");
			    //document.getElementById("cardnum").focus();
				return false;
			}
		}
		
	   function checkPwd(){
	   		var pwd= document.getElementById("cardpwd").value;
	   		if(pwd !=""){
	   			if(pwd.length >6){	//密码位数大于6
	   				return true;
	   			}else{
	   				alert("密码不能小于6位，请重新输入");
	   				document.getElementById("cardpwd").value="";//将控件中的内容清空
					//document.getElementById("cardpwd").focus();//将光标聚焦到该控件上
				    return false;
	   			}
	   		}else{
	   			alert("请输入正确的密码");
			    //document.getElementById("cardpwd").focus();
				return false;
	   		}
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
	function pay(orderid){
	    if(checkCard() && checkPwd()){
			//window.alert("进来了=======");
			//首先创建一个XMLHttpRequest对象
			myXmlHttpRequest = getXmlHttpObject();
			if(myXmlHttpRequest){	//创建成功
				//获取需要的表单数据
				//alert("订单编号="+orderid +"退订原因="+reason);
				//创建连接服务器的url
				var url="/FlowerShop/OrderClServlet?type=pay&mytime="+new Date();
				var data="orderid="+orderid;
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
		}else{
				alert("请输入正确的信息");
				return false;
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
    				window.open("/FlowerShop/OrderClServlet?type=myorder","_self");//跳转到显示所有的历史订单
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
   
    <!-- 这是用户首页面 -->
   <div class="navi_head">
   <span>您好，欢迎您 <%=user.getUsername() %></span>
   <span style="margin-left: 400px;"></span>
   </div>
   
   <div class="navi_pic">
   <img src="images/logo.gif"  height="150px" />
  
<table width="78%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="76%" align="center"><font class="font1">花卉,让生活多姿多彩</font></td>
    <td width="24%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td bordercolor="#FFFFFF"></td>
      </tr>
      <tr><td>&nbsp;</td></tr>
      <tr>
        <td bordercolor="#FFFFFF"></td>
      </tr>
       <tr><td>&nbsp;</td></tr>
      <tr>
        <td bordercolor="#FFFFFF"></td>
      </tr>
       <tr><td>&nbsp;</td></tr>
    </table></td>
  </tr>
</table>
   
   </div>
   
   <div class="navi_content">
   </div>
   
  <div class="pay">
  <div class="gotopay">当前所在>>付款<span style="float: right;margin-right:10px;"><input type="button" style="border: 0;background-color: pink;height: 30px;font-size: 20px;"  value="返回上一页"  onclick="goback()"/></span></div>
   <div class="pay_left">
  <div class="pay_left_order">订单号: <%=orderInfo.getId() %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;总价: <%=orderInfo.getTotalPrice() %></div>
  <div class="pay_left_table">
  <table border="0">
  <tr><td align="center" width="140px">请输入卡号:</td><td align="left"><input style="width:200px; height:30px; white;border: 1px solid silver;font-size: 20px;" id="cardnum" type="text" value="" onblur="return checkCard()" /></td></tr>
  <tr><td align="center">请输入密码:</td><td align="left"><input  style="width:200px; height:30px; white;border: 1px solid silver;font-size: 20px;"  type="password" value=""  id="cardpwd" onblur="return checkPwd()"/></td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
   <tr><td align="center" colspan="2"><input  style="width:120px; height:30px; border:0; background-color: pink;font-size: 20px;"  type="button" value="立即支付" onclick="return pay(<%=orderInfo.getId() %>)" /></td></tr>
  </table>
  </div>
  
  
   </div>
   
   
   <div class="pay_right">右边的部分</div>
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
