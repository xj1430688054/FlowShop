<%@ page language="java" import="java.util.*,java.text.*,com.gcj.domain.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取当前时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义日期格式
String nowTime = sdf.format(new java.util.Date()); 
String time=nowTime.substring(0,11);//截取字符串
//接收传递过来的FlowerBean 对象
FlowerBean flower=(FlowerBean)request.getAttribute("putintocart_flower");
System.out.println("userlogin1中接收到的flower的数量reserve_num="+flower.getReservenums());
//将flower放入session中
session.setAttribute("putintocart_flower", flower);
//此处将flower放入session中存在一个问题，如果数据量过大，session压力很大
//request.getSession().setAttribute("reserve_flower",flower);
//FlowerBean flower = (FlowerBean)request.getSession().getAttribute("reserve_flower");
//接收登录失败的信息
String err1=(String)request.getAttribute("err");
//System.out.println("登录界面nums="+flower.getReservenums());//验证通过,能接收到数据
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml=transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/user_index.css">
	<link rel="stylesheet" type="text/css" href="css/user_css.css">
	<script type="text/javascript">
		//function tiao(){		//调转函数
			//clearInterval(mytime);	//清空定时器
			//window.open("/FlowerShop/index.jsp","_self");
		//}
		//setTimeout("tiao()",5000);//设置定时器
		//function changeSec(){	//改变时间的函数
			//得到myspan值
			//document.getElementById("myspan").innerText=parseInt(document.getElementById("myspan").innerText)-1;
		//}
		//var mytime=setInterval("changeSec()",1000);
		function check(){	//验证用户输入的信息
			var username=document.getElementById("username").value;
			var pwd = document.getElementById("pwd").value;
			var checkcode=document.getElementById("checkCode").value;
			
			if(username==null || username==""){
				window.alert("请输入用户名");
				return false;
			}
			if(pwd==null || pwd==""){
				window.alert("请输入密码");
				return false;
			}
			if(checkcode==null ||checkcode==""){
				window.alert("请输入验证码");
				return false;
			}
		
		}
		
	</script>

  </head>
  
  <body background="images/bg.bmp">
   
    <!-- 这是用户首页面 -->
   <div class="navi_head">
   <span>您好，欢迎访问花卉预定管理系统</span>
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
   <!-- 无序列表 -->
   </div>
   
   <!-- 中间的内容版块 -->
   <div class="cont">
   <table>
   <tr><td><!-- 图片尺寸，最大500x400 --><img width="480px" src="images/loginbg.jpg" /></td>
   <td>
   <div class="login">
   <!-- 放一个table 7行2列 -->
   <form action="/FlowerShop/LoginClServlet?type=userlogin1" method="post">
   <table>
   <tr><td colspan="2"><img src="images/login_logo.jpg"/></td></tr>
   <tr><td align="center">用户名:</td><td style="text-align: left"><input id="username" type="text" name="username" /></td></tr>
   <tr><td align="center">密　码:</td><td><input type="password" name="pwd" id="pwd"/></td></tr>
   <tr><td align="center">验证码:</td><td><input id="checkCode" type="text" name="checkcode" /><span class="checkCodeimg"><img id="randomCode" src="/FlowerShop/CreateCode"></span></td></tr>
   <!-- <tr><td colspan="2"><input type="checkbox" name="checkinfo" /><font size="2px">在此电脑上保留登录信息</font></td></tr> -->
  
   	<%
        	if(err1 !=null){
        	%>
           <tr>
        <td align="center" style="text-align:center;" colspan="2"><font color="red"><%=err1 %></font></td>
      </tr>
      <% } %>
   
   <tr><td colspan="2"><span style="margin-left: 40px"><input type="submit" value="登录" onClick="return check()"/></span><span style="margin-left: 30px"><input type="reset" value="重置" /></span></td></tr>
   <tr><td colspan="2"><span style="margin-left: 20px"><a href="/FlowerShop/UserClServlet?type=gotoregisterview"><img border="0" width="70px" src="images/regit.gif" /></a></span><span style="margin-left: 30px"><a href="/FlowerShop/index.jsp" ><img src="images/back2.jpg" border="0"></a></span></td></tr>
   </table>
   </form>
   </div></td>
   </tr>
   </table>
   </div>
   
   
   <%
   		//测试通过，可以获取
   		//out.println("flowerid="+flower.getFlowerid());
   		//out.println("num="+flower.getReservenums());
   
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
