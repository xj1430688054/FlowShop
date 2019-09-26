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

//分页操作

//默认显示第一页
int pageNow =1;
int pageSize=8;//每页显示8条记录
//使用FlowerService 完成分页功能，也可以走一下Servlet
FlowerService flowerService = new FlowerService();

ArrayList al = flowerService.getFlowersByPage(pageSize,pageNow);
//得到共有多少页
int pageCount = flowerService.getPageCount(pageSize);

//查询用户留言表，显示后8条 select * from usermessage order by id desc limit 8;
UserMessageService userMessageService = new UserMessageService();
ArrayList messageal = userMessageService.getMessages();
//订单细节service
OrderItemService orderItemService = new OrderItemService();
//得到热门花卉
ArrayList hotfloweral = orderItemService.getOrderItemFlower();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml=transitional.dtd"><!-- doctype声明很重要，没有后面这句话首页在ie中显示不正确 为了让IE浏览器支持w3c标准，需要声明DOCTYPE -->
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>联系方式</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/admin_index.css">
	<link rel="stylesheet" type="text/css" href="css/comm.css">
	<link rel="stylesheet" type="text/css" href="css/user_index.css">
	<script type="text/javascript">
	function CheckIndexLogout(user){	//验证用户是否已经登录
		if(user==null){
			window.alert("您还没有登录，请先登录!");
			return false;
		}else{
			return true;
		}
	}
	
	function checkType(){	//下拉框 检查类型
		var flowertype=$("type").value;
		//window.alert(type);
		if(flowertype =="type"){
			window.alert("您还没有花卉类型,请先选择!");
			return false;
		}else{
			return true;
		}
		//获取选中的option的文本值
		//var flowertype=$("type");
		//var ftype=flowertype.options[flowertype.selectedIndex].text;
		//alert(ftype);
	
	}
	function $(id){
		return document.getElementById(id);
	}
	
	function selectFlower(){
		if(checkType()){
			var flowertype=$("type");
			var ftype=flowertype.options[flowertype.selectedIndex].text;
			var keyword=$("keyword").value;
			if(keyword==""){
				alert("请输入希望查询的花卉名");
				return false;
			}
			//跳转到处理这一请求的控制器
			window.open("/FlowerShop/ShowFlowerClServlet?type=selectflower&key="+keyword+"&ftype="+ftype+"","_self");
			//alert("关键字="+keyword);
			//alert("选择的花卉类型="+ftype);
		}else{
			alert("请先选择花卉类型!");
			return false;
		}
		
	}
	
	function CheckLogin(user){
		if(user==null){
			window.alert("您还没有登录，请先登录!若您还没有账号，请先注册,谢谢!");
			return false;
		}else{
			return true;
		}
	}

	</script>
	<!--  <style>
	a{cc:expression(window.status='')}
	</style>-->
  </head>
  
  <body background="images/bg.bmp">
<!-- 这是用户首页面 -->
   <div class="navi_head">
   <%
   		if(user !=null){
   		%>
   		<span>欢迎您, <font size="3"><%=user.getUsername() %></font></span>
   		<% 
   		}else{
   		 %>
   <span>您好, 请 <a href="/FlowerShop/LoginClServlet?type=gotoLoginView">登录</a> | <a href="/FlowerShop/UserClServlet?type=gotoregisterview">注册</a></span>
   <% } %>
  <span style="margin-left: 400px;">  <a href="/FlowerShop/UserClServlet?type=logout" onClick="return CheckIndexLogout(<%=user %>)">【安全退出】</a></span>
   </div>
   
   <div class="navi_pic">
   <img  onClick="return test1();"src="images/logo.gif"  height="150px" />
  <!-- 如何防止首页的logo被盗 -->
<table width="78%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="76%" align="center" ><font class="font1">花卉,让生活多姿多彩</font></td>
    <td width="24%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td bordercolor="#FFFFFF"><img src="images/account.gif" width="19" height="14" /><a href="/FlowerShop/UserClServlet?type=myaccount" onClick="return CheckIndexLogout(<%=user %>)">我的账户</a></td>
      </tr>
      <tr><td>&nbsp;</td></tr>
      <tr>
        <td bordercolor="#FFFFFF"><img src="images/cart.gif" width="20" height="15" /> <a href="/FlowerShop/ShowMyCartClServlet?type=myCart" onClick="return CheckIndexLogout(<%=user %>)">我的预订单</a></td>
      </tr>
       <tr><td>&nbsp;</td></tr>
      <tr>
        <td bordercolor="#FFFFFF"><img src="images/icon2.gif" width="20" height="20" />  <a href="/FlowerShop/OrderClServlet?type=myorder" onClick="return CheckIndexLogout(<%=user %>)">我的历史订单</a></td>
      </tr>
      <tr><td>&nbsp;</td></tr>
       <tr>
        <td bordercolor="#FFFFFF"><img src="images/icon2.gif" width="20" height="20" /> <a href="/FlowerShop/RestoreFlowerCl?type=goshowmyrestore" onClick="return CheckIndexLogout(<%=user %>)"> 我的收藏</a> </td>
      </tr>
       <tr><td>&nbsp;</td></tr>
    </table></td>
  </tr>
</table>
   
   </div>
   
   
    <div class="menu1">
   <ul>
   <li>
  <a href="/FlowerShop/index.jsp">首　页</a>
   </li>
   
   <li><a href="/FlowerShop/index.jsp">供应花卉</a>
  <ul>
   <li><a href="/FlowerShop/ShowFlowerClServlet?type=bh">&nbsp;百　合&nbsp;&nbsp;</a></li>
   <li><a href="/FlowerShop/ShowFlowerClServlet?type=rs">&nbsp;玫　瑰&nbsp;&nbsp;</a></li>
   <li><a href="/FlowerShop/ShowFlowerClServlet?type=lh">&nbsp;兰　花&nbsp;&nbsp;</a></li>
   <li><a href="/FlowerShop/ShowFlowerClServlet?type=fzj">&nbsp;非洲菊&nbsp;&nbsp;</a></li>
   <li><a href="/FlowerShop/ShowFlowerClServlet?type=knx">&nbsp;康乃馨&nbsp;&nbsp;</a></li>
   </ul>
   </li>
     <li><a href="/FlowerShop/ShowFlowerKnowledgeCl?type=showflowerknowledge">花卉知识</a></li>
   <li><a href="/FlowerShop/ShowFlowerTrendsCl?type=showflowernews">花卉动态</a>
   
   </li>
  <!-- <li><a href="/FlowerShop/ForumClServlet?type=showAllpost">论坛交流</a></li> -->
 
 <li><a href="/FlowerShop/UserMessageCl?type=aftersearch" onClick="return CheckLogin(<%=user %>);">我要留言</a></li>
   
    <li><a href="/FlowerShop/UserClServlet?type=showcontact">联系方式</a></li>
   </ul>
   </div>
   
   
   
   <!-- 内容板块 -->
   <div class="content_center">
   <div class="content_left">
   <!-- 左上的广告条 -->
   <!-- <div class="content_left_ad">此处放广告条,一个图片300x50</div>-->
   <div class="content_left_ad"><span>>>>花卉欣赏</span></div>
   <div class="content_left_flash"><!-- 此处放一个flash文件，修改图片文件大小，banner.js文件中 --><script type="text/javascript" language="javascript" src="banner.js"></script></div>
   <!--  <div class="content_left_search">快速花卉搜索，图片300x40</div>-->
   <div class="content_left_search"><span>>>>快速花卉搜索</span></div>
   <!-- 信息检索部分，一个table，里面放表单 -->
   <div class="content_left_form"><!-- 快速信息检索，表单300x150-->
   <!--  <form action="/FlowerShop/ShowFlowerClServlet?type=selectflower" method="post">-->
   <table>
    <tr><td style="font-size:12px;">花卉名:</td><td><input type="text" name="keyword" id="keyword"/></td></tr>
    <tr><td style="font-size:12px;">类　型:</td>
    <td><select id="type" name="infoType" onblur="return checkType()"><option value="type">---选择花卉类型---</option>
    <option value="baihe">百合</option>
    <option value="rose">玫瑰</option>
     <option value="lanhua">兰花</option>
      <option value="feizhouju">非洲菊</option>
       <option value="kangnaixin">康乃馨</option>
    </select>
    </td>
    </tr>
    <tr><td><br></td><td>
    <!-- <input type="image" src="images/search.gif"/> -->
    <input type="button" value="搜素" onclick="return selectFlower();"  style="width:60px;height:25px;border:0px;background-color:#93F588;margin-top: 5px;margin-left:20px;"/>
    </td></tr>
    </table>
   <!--</form>-->
   
   </div>
    <!--  <div class="content_left_range">热门花卉排行，图片300x40</div>-->
    <div class="content_left_range"><span>>>>热门花卉排行</span></div>
    <div class="content_left_flower">
    <!-- 花卉排行榜 -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td align="center">排行</td>
        <td align="center">花卉名称</td>
        <td align="center">销售数量</td>
      </tr>
      
      <%	
    	//显示7条热门花卉
    	int hotstart =0;
    	for(int j=0;j<7;j++){
    		HotFlower hotFlower = new HotFlower();
    		if(hotstart>=hotfloweral.size()){	////当记录的条数不够显示时，采用的办法为：把不够显示的用一个特定大小的div填充起来
   					//不能再取，用一个固定大小的div填充
   					%>
   					  <tr>
        				<td align="center">xx</td>
        				<td align="center">xxx</td>
        				<td align="center">xx</td>
      				</tr>
   				<%
   				}else{
   					hotFlower = (HotFlower)hotfloweral.get(hotstart);
   					hotstart++;
   			%>
   				 <tr>
       			 <td align="center"><%=j+1 %></td>
        		<td align="center"><a href="/FlowerShop/ShowFlowerClServlet?type=showDetail&id=<%=hotFlower.getFlowerid()%>"><%=hotFlower.getFlowername() %></a></td>
        		<td align="center"><%=hotFlower.getTotalnum() %> <%=hotFlower.getFlowerunit() %></td>
      			</tr>
   			<% 
   				}
   		}
     %>
     
    </table>
    </div>
    
    
    <div class="content_left_user"><img src="images/message.jpg" /></div>
    <div class="content_left_message">
    <ul>
    
    <%	
    	//显示8条留言
    	int messagenum =0;
    	for(int j=0;j<8;j++){
    		UserMessage userMessage = new UserMessage();
    		if(messagenum>=messageal.size()){	////当记录的条数不够显示时，采用的办法为：把不够显示的用一个特定大小的div填充起来
   					//不能再取，用一个固定大小的div填充
   					%>
   					  <li>暂无用户留言<font class="message_time"><%=time %></font></li>
   				<%
   				}else{
   					userMessage = (UserMessage)messageal.get(messagenum);
   					messagenum++;
   			%>
   				 <li><a href="/FlowerShop/UserMessageCl?type=showmessage&no=<%=userMessage.getId() %>"><%=userMessage.getTitle() %> </a><font class="message_time"><%=userMessage.getMessagetime() %></font></li>
   			<% 
   				}
   		}
     %>
    </ul>
    </div>
    
    <div class="content_left_contact"><span><img src="images/contact.gif" /></span></div>
    <!-- <div class="content_left_contact"><span><img src="images/conta.gif" /><font>联系我们</font></span></div>-->
    <div class="content_left_contactinfo">
    <span>
    <font style="color:#008000;font-weight:bold;">花卉预定管理系统</font><br/><hr/>联系电话:　88888888<br/>联系地址:　CHINA<br/>邮　　编:　100000
    </span>
    </div>
   </div>
   <!-- <div class="content_right_top">最新花卉推荐600x30的图片条</div> -->
   <div class="content_right_top"><span>>>经营概况</span></div>
   
   
   <!-- 右下部分-->
   <div class="show_company_info">
      <br/>
      <p style="font-size: 18px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本系统主要提供预订的花卉包括百合，玫瑰，兰花，康乃馨，非洲菊等。每种花卉都有很多具体的品种，随着经营规模的扩大，以及广大用户的需求，我们将提供更多类型的花卉，敬请关注！</p>
    <div class="content_right_top"><span>>>系统概况</span></div>
     
        <p>&nbsp;</p>
        <p style="font-size:18px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本系统是第二个版本。		
      </p> 
      <p style="font-size:18px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;相比第一个版本，此版本提供了更多的功能，设计更加满足消费者的需求。相对于第一个版本，该版本新增了如下内容：（1）增加了介绍花卉知识的板块，您可以从中了解更多的花卉知识；（2）增加了花卉动态板块，您可以从中了解更多关于我们提供的花卉信息，以便您的预订；（3）增加了我们的介绍模块，您可以更好的了解我们，以方便您的预订。
      </p> 
      <p style="font-size:18px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;感谢您的光临，有任何问题请留言或联系高先生，谢谢！
      </p> 
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
