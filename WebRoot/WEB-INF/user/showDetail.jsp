<%@ page language="java" import="java.util.*,java.text.*,com.gcj.domain.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取当前时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义日期格式
String nowTime = sdf.format(new java.util.Date()); 
String time=nowTime.substring(0,11);//截取字符串

//接收用户信息
Users user = (Users)request.getSession().getAttribute("loginuser");
//从request域中获取flowerinfo
FlowerBean flowerBean = (FlowerBean)request.getAttribute("flowerinfo");
FlowerInfo flowerInfo = (FlowerInfo)request.getAttribute("flower_info");
FlowerIntro flowerIntro = (FlowerIntro)request.getAttribute("flowerintro");
ArrayList al = (ArrayList)request.getAttribute("similar_flower");
ArrayList commental = (ArrayList)request.getAttribute("commental");
//获取成交数量
int tradeflowernum = Integer.parseInt(request.getAttribute("flowernum")+"");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml=transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>显示具体信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/admin_index.css">
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
		function CheckIndexLogout(user){	//验证用户是否已经登录
		if(user==null){
			window.alert("您还没有登录，请先登录!");
			return false;
		}else{
			return true;
		}
		}
	
		function reserve(flowerid){ //点击"立即预订"调用的函数
			//document.getElementById("myreservation").value 得到的是字符串类型，通过parseInt()转为整数型
			var reserve_num = document.getElementById("myreservation").value;
			var startsale = document.getElementById("startsale").value;
			var flowernum = document.getElementById("flowernum").value;
			//window.alert("预定量="+reserve_num);
			//window.alert("起批量="+startsale);
			//window.alert("库存量="+flowernum);
			//判断输入的数量是否合法
			//使用正则表达式控制输入中文
			var reg=/^(\d)+$/gi;	
			if(reserve_num =="" || !reg.test(reserve_num)){ 
				window.alert("请输入正确的预订量，谢谢!");
			}else{
				var reserve_num=parseInt(reserve_num);
				var startsale = parseInt(startsale);
				var flowernum = parseInt(flowernum); 
				if(reserve_num < startsale){
					window.alert("对不起，您的预定量少于起批量，请重新输入数量");
					return false;
				}
				if(reserve_num > flowernum){
					window.alert("对不起，您的预定量超过了库存量!");
					return false;
				}
				//如果输入的数量合法，则调转到处理预订这个请求的servlet
				//window.open("ReserveClServlet?type=reserve&reserve_num="+reserve_num+""&flowerid="+flowerid,"_self");
				//跳转的同时传递花卉的id 和用户预订的数量
				window.location.href='/FlowerShop/ReserveClServlet?type=reserve&reserve_num='+reserve_num+'&flowerid='+flowerid;
			}
		}
		
		function updatenum(event){		//使用js 的事件驱动编程技术验证输入的是否是数字
			//用户每按下一个键，就去判断是否是数字 0到9的编码
			if(event.keyCode<48||event.keyCode>57){
				window.alert("请输入数字,谢谢!");
				return false;
			}	
		}
		function goback(){	//返回上一页
			history.back();	//history 为js 的一个对象
		}
		function putIntoCart(flowerid){		//点"加入预订单"调用的函数
			var reserve_num = document.getElementById("myreservation").value;
			var startsale = document.getElementById("startsale").value;
			var flowernum = document.getElementById("flowernum").value;
			//判断输入的数量是否合法
			//使用正则表达式控制输入中文
			var reg=/^(\d)+$/gi;	 
			if(reserve_num =="" || !reg.test(reserve_num)){  
				window.alert("请输入正确的预订量，谢谢!"); 
			}else{
				var reserve_num=parseInt(reserve_num); 
				var startsale = parseInt(startsale); 
				var flowernum = parseInt(flowernum);  
				if(reserve_num < startsale){ 
					window.alert("对不起，您的预定量少于起批量，请重新输入数量"); 
					return false;
				}
				if(reserve_num > flowernum){
				    window.alert("对不起，您的预定量超过了库存量!"); 
					return false;
				}
				//如果输入的数量合法，则调转到处理加入购物车这个请求的servlet
				//跳转的同时传递花卉的id 和用户预订的数量
				window.location.href='/FlowerShop/PutIntoCartClServlet?type=putintocart&reserve_num='+reserve_num+'&flowerid='+flowerid;
			}
		}
		//使用Ajax异步执行收藏这一动作
		
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
		
		function checkStore(flowerid){	//点击收藏触发的事件
			//window.location.href="/FlowerShop/RestoreFlowerCl?type=restore&no="+flowerid;
			//首先创建一个XMLHttpRequest对象
			myXmlHttpRequest = getXmlHttpObject();
			if(myXmlHttpRequest){	//创建成功
				//获取需要的表单数据
				//创建连接服务器的url
				var url="/FlowerShop/RestoreFlowerCl?type=restore&mytime="+new Date();
				//alert("执行到这里了②");
				var data="flowerid="+flowerid;
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
		}
		
		function showResult1(){
			if(myXmlHttpRequest.readyState==4){		//HTTP就绪码为4  
				if(myXmlHttpRequest.status==200){	//HTTP 状态码为200 说明服务器处理正确
					//取出值，根据返回信息的格式定
					//alert("执行到这里了⑤");
					//将myXmlHttpRequest.responseText进行处理，利用正则表达式去掉空格，回车，空行，再进行字符串的比较
					var val = (myXmlHttpRequest.responseText).replace(/[ ]/g,"").replace(/[\r\n]/g,"");
					if(val=="您还没有登录,立即登录?"){
						if(window.confirm(val)){
							window.open("/FlowerShop/RestoreFlowerCl?type=gorestore","_self");
						}
					}else if(val=="恭喜您,收藏成功!" || val=="您已经收藏过该花卉!"){
						if(window.confirm(val+ "立即查看我的收藏")){
							//调转到显示我的收藏的控制器
							window.open("/FlowerShop/RestoreFlowerCl?type=goshowmyrestore","_self");
							//alert(val);
							//window.location.reload(true);
						}
						//alert(val);
						//window.location.reload(true);
					}
						//window.open("/FlowerShop/RestoreFlowerCl?type=gorestore","_self");
					//}
					//window.location.reload(true);
				}else if(myXmlHttpRequest.status==404){	//客户端请求出错
						window.alert("请求的url不存在");
				}else{
					alert("Error:status code is:"+myXmlHttpRequest.status);
				}
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
   
   <div class="showDetail">
   
   <div class="flower_pic"><img src='images/<%=flowerBean.getPhoto() %>' />
   <div class="watch"><span></span><span><input style="width:60px; font-size:20px; height:25px; border:0px; background-color:#92E587;"   type="button" name="store" value="收藏" onclick="return checkStore(<%=flowerBean.getFlowerid() %>);"/></span></div>
   </div>
   
   <div class="flower_detail">
   
   <div class="flower_name"><span>名 称:<%=flowerBean.getFlowername() %></span></div>
   <div class="flower_price"><span>价 格:￥<%=flowerBean.getFlowerprice() %></span></div>
    <div class="flower_marketprice"><span>市场价:￥<%=flowerBean.getMarketprice() %></span></div>
    <div class="flower_startsale"><span>起批量: <input type="text" id="startsale" name="startsale"  readonly="readonly" value='<%=flowerBean.getStartsale() %>'/><%=flowerBean.getFlowerunit() %></span></div>
    <div class="flower_nums"><span>库存量: <input type="text" id="flowernum" name="flowernum"  readonly="readonly" value='<%=flowerBean.getFlowernum() %>'/><%=flowerBean.getFlowerunit() %></span></div>
     <div class="flower_intro"><span>介 绍:<%=flowerBean.getFlowerintro() %></span></div>
      <div class="flower_intro"><span>预订量:<input id="myreservation" type="text" name="buynum" onkeypress="return updatenum(event)" value='<%=flowerBean.getStartsale() %>'/><%=flowerBean.getFlowerunit() %>&nbsp;&nbsp;&nbsp;<font size="2" color="red">(如需修改数量，请您自行修改!)</font></span></div>
      <!--  <div class="flower_buy"><span><a href="#"><img src="images/order.jpg" border="0"></a></span><span><a href="/SunDance_V0.2"><img src="images/back.jpg" border="0"></a></span></div>-->
      <!-- 使用图片作为button 提交 -->
      <div class="flower_buy"><span><input type="image" src="images/order.jpg" onClick="reserve(<%=flowerBean.getFlowerid() %>);"/></span><span><input type="image" src="images/putintocart.jpg" onClick="putIntoCart(<%=flowerBean.getFlowerid() %>);"/></span></div>
      <div class="flower_buy"><span><input type="image" src="images/back.jpg" onClick="goback();"/></span></div>
 
   </div> 
   </div>
  
   <!-- 显示花卉的附加信息 -->
   <div class="flower_attachinfo">
   <div class="xiangxi"><span>详细信息</span></div>
   <%
   		if(flowerInfo !=null){	//不为空时
   	%>
   			 <table border="0" class="info">
   <tr><td>类型: <%=flowerInfo.getType() %></td><td>等级: <%=flowerInfo.getGrade() %></td><td>颜色: <%=flowerInfo.getColor() %></td></tr>
    <tr><td>用途: <%=flowerInfo.getUseway() %></td><td>规格: <%=flowerInfo.getSpecification() %></td><td>适用节日: <%=flowerInfo.getUsefestival() %></td></tr>
   </table>
   	<% 
   		
   		}else{
   		%>	
   			 <table border="0" class="info">
   <tr><td>类型: xxx</td><td>等级: xxx</td><td>颜色: xxx</td></tr>
    <tr><td>用途: xxx</td><td>规格: xxx</td><td>适用节日: xxx</td></tr>
   </table>
   		<% 
   		}
   
    %>
  
   <div class="xiangxi"><span>成交(<%=tradeflowernum %>)/评价(<%=commental.size() %>)</span></div>
   
   <%
   			if(commental.size()==0){
   		%>
   				<div class="record1">
   				<div class="no_comment">暂时还没有评论</div>
   				</div>
   		<% 	
   				
   			}else{
   				for(int b=0;b<commental.size();b++){
   					Comment comment = (Comment)commental.get(b);
   			%>
   					 <div class="record">
   
   						<div class="user_comment"><div class="neirong">评论内容: <%=comment.getUsercomment() %></div><div class="time_name"><%=comment.getCommenttime() %> &nbsp;&nbsp;&nbsp; <%=comment.getUsername() %></div></div>
   
   					</div>
   			<% 
   				}
   			}
   
    %>
  
   <div class="xiangxi"><span>您可能喜欢的花卉</span></div>
    <div class="lianxi">
    <%
    	//此处开始显示相同类型的花卉，最多显示6个,每行3个
    	int start =1;
    	if(al.size()==0){	//没有相同类型的花卉，给出提示
    	%>
    	<div class="no_similar_flower">暂时没有相同类型的花卉</div>
    	<% 
    	}else{
    		for(int i=0;i<al.size();i++){
    			if(start>6){
    				break;//大于6条，跳出循环
    			}
    			FlowerBean flower=(FlowerBean)al.get(i);
    		%>
    		
    		 <div class="similar_flower">
   				<div class="similar_flower_pic"><a href="/FlowerShop/ShowFlowerClServlet?type=showDetail&id=<%=flower.getFlowerid() %>"><img src="images/<%=flower.getPhoto() %>"></a></div>
   				<table border="0"><tr><td colspan="2"><a href="/FlowerShop/ShowFlowerClServlet?type=showDetail&id=<%=flower.getFlowerid() %>">花卉名称:<%=flower.getFlowername() %></a></td></tr></table>
   			 </div>
    		<% 
    			start++;
    		}
    	}
    		
     %>
    </div>
    
    <div class="xiangxi"><span>联系方式</span></div>
    <div class="lianxi">
    	<span>联系电话:　88888888<br/>联系地址:　CHINA<br/>邮　　编:　100000</span>
    </div>
    
     <!-- 导入花卉的介绍 -->
    <div class="xiangxi"><span>花卉介绍</span></div>
   <div class="flower_extrainfo">
    <div class="flower_extrainfo">
  		<%=flowerIntro.getFlowerintro() %>
   </div>
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

