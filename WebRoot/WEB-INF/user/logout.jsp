<%@ page language="java" import="java.util.*,java.text.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取当前时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义日期格式
String nowTime = sdf.format(new java.util.Date()); 
String time=nowTime.substring(0,11);//截取字符串
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml=transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>安全退出</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/user_index.css">
	<link rel="stylesheet" type="text/css" href="css/user_css.css">
	<script type="text/javascript">
		function tiao(){		//调转函数
			clearInterval(mytime);	//清空定时器
			window.open("/FlowerShop/index.jsp","_self");
		}
		setTimeout("tiao()",5000);//设置定时器
		function changeSec(){	//改变时间的函数
			//得到myspan值
			document.getElementById("myspan").innerText=parseInt(document.getElementById("myspan").innerText)-1;
		}
		var mytime=setInterval("changeSec()",1000);
		
	</script>

  </head>
  
  <body background="images/bg.bmp">
   
    <!-- 这是用户首页面 -->
   <div class="navi_head">
   <span>您好，欢迎您再次光临!</span>
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
   
  <div class="logout">
   <table border="0">
   <!--  <tr><td width="300px" >此处放退出的图片</td><td><font style="font-size:26px;">恭喜你，成功退出！系统将在<span id="myspan">5</span> 秒后返回首页......</font></td></tr>-->
   <tr><td width="150px;"></td><td><font style="font-size:26px;">恭喜你，成功退出！系统将在<span id="myspan">5</span> 秒后返回首页......</font></td></tr>
   </table>
   
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
