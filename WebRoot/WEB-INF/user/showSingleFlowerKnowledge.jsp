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
int pageSize=24;//每页显示8条记录

//得到pageNow
String spageNow = (String)request.getAttribute("pageNow");
if(spageNow!=null){		//表示是通过点击分页传过来的
	pageNow = Integer.parseInt(spageNow);
}
//得到FlowerTrendsList对象
FlowerKnowledge flowerKnowledge = (FlowerKnowledge)request.getAttribute("knowledges");
FlowerKnowledge flowerKnowledge_before = (FlowerKnowledge)request.getAttribute("knowledge_before");
FlowerKnowledge flowerKnowledge_next = (FlowerKnowledge)request.getAttribute("knowledge_next");

//ArrayList al = flowerTrendsService.getFlowerTrendsListByPage(pageSize,pageNow);
//得到共有多少页
//int pageCount = flowerTrendsService.getRFlowerTrendsPageCount(pageSize);

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
    
    <title>太阳舞花卉预订主页面</title>
    
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
	
	
	
	function CheckLogin(user){
		if(user==null){
			window.alert("您还没有登录，请先登录!若您还没有账号，请先注册,谢谢!");
			return false;
		}else{
			return true;
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
	function addtimes(flowerknowledgeid){
			//window.alert("进来了=======");
			//首先创建一个XMLHttpRequest对象
			myXmlHttpRequest = getXmlHttpObject();
			if(myXmlHttpRequest){	//创建成功
				//获取需要的表单数据
				//alert("订单编号="+orderid +"退订原因="+reason);
				//创建连接服务器的url
				var url="/FlowerShop/ShowFlowerKnowledgeCl?type=addtimes&mytime="+new Date();
				var data="id="+flowerknowledgeid+"&mytime="+new Date();
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
					//window.alert(myXmlHttpRequest.responseText);
					//跳转到ReserveOkCl控制器
    				//window.location.href="/FlowerShop/ReserveOkCl?no="+orderid+"";
    				//window.location.reload(true);//刷新页面
				}else if(myXmlHttpRequest.status==404){	//客户端请求出错
						window.alert("请求的url不存在");
				}else{
					alert("Error:status code is:"+myXmlHttpRequest.status);
				}
			}
	}
	
	
	
	
	
	</script>
	<!--  <style>
	a{cc:expression(window.status='')}
	</style>-->
  </head>
  
  <body background="images/bg.bmp">&nbsp; 
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
   <div class="content_right_top"><span>>>花卉知识</span></div>
   
   <!-- 右下部分-->
   <div class="show_flower_trends_info">
    <div class="trend_info_title"><%=flowerKnowledge.getTitle() %></div>
     <div class="trend_info_time"><span>发布时间: <%=flowerKnowledge.getPublishtime() %></span> <span>浏览次数: <%=flowerKnowledge.getReadtimes() %></span></div>
      <div class="trend_info_cont"><%=flowerKnowledge.getContent() %></div>
      <%
      		if(flowerKnowledge_before.getTitle() !=null){
      	%>
      			<div class="trend_info_before">上一条: <a href="/FlowerShop/ShowFlowerKnowledgeCl?type=nr&no=<%=flowerKnowledge_before.getId() %>" onclick="addtimes(<%=flowerKnowledge_before.getId() %>)" ><%=flowerKnowledge_before.getTitle() %></a></div>
      	<% 
      		}
       %>
       <%
       		if(flowerKnowledge_next.getTitle()!= null){
       %>	
       			<div class="trend_info_next">下一条: <a href="/FlowerShop/ShowFlowerKnowledgeCl?type=nr&no=<%=flowerKnowledge_next.getId() %>" onclick="addtimes(<%=flowerKnowledge_next.getId() %>)"><%=flowerKnowledge_next.getTitle() %></a></div>
       <% 
       		}
        %>

       <!-- 当鼠标按下时，触发onmousedown事件，返回上一页 -->
       <div class="trend_info_back"><a href="" onmousedown="javascript:history.go(-1);" style="text-decoration: none;">【返回】</a></div>
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
