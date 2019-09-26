<%@ page language="java" import="java.util.*,com.gcj.domain.*,com.gcj.service.*,java.text.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取当前时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义日期格式
String nowTime = sdf.format(new java.util.Date()); 
//String time=nowTime.substring(0,11);//截取字符串

//得到用户信息
Users user=(Users)request.getSession().getAttribute("loginuser");
//得到购物车的信息
ArrayList al = (ArrayList)request.getAttribute("mycartinfo");
//得到购物车
MyCart myCart =(MyCart)request.getSession().getAttribute("myCart");
FlowerService flowerService = new FlowerService();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml=transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'showMyCart.JSP' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/user_index.css">
	<link rel="stylesheet" type="text/css" href="css/comm.css">
	<script type="text/javascript" language="javascript">
	function confirmOper()		//删除花卉
	{
		return window.confirm('真的要删除这种花吗？');
			
		
	}
	function CheckLogout(){		//退出前的检查
		return window.confirm('您正在查看预订的花卉，真的要退出吗?');
	}
	function gobacksearch(){	//返回继续预订
		window.location.href="/FlowerShop/index.jsp";
	}
	function clearAll(){		//清空所有预订
		if(window.confirm('您真的想清空全部预订花卉吗?')){		//返回值为真时，跳转到ShowMyCartClServlet
			window.location.href="/FlowerShop/ShowMyCartClServlet?type=clearAll";
		}
	}
	function updatenum(event){		//使用js 的事件驱动编程技术验证输入的是否是数字
			//用户每按下一个键，就去判断是否是数字 0到9的编码
			if(event.keyCode<48||event.keyCode>57){
				window.alert("请输入数字,谢谢!");
				return false;
			}	
	}
		
		function checkNum(){
			//获取所有花卉的预订数量
			var orderflowernums = document.getElementsByName("orderflowernums");
			//获取所有花卉的库存
			var allflowernums= document.getElementsByName("allflowernums");		//花的库存量
			var startsale = document.getElementsByName("startsale");		//起批量
			//window.alert("预订花的种类="+orderflowernums.length);
			//window.alert("库存量的种类="+allflowernums.length);
			//window.alert("起批量的种类="+startsale.length);
			//var reg=/^\d+$/gi;不能再此处定义
			//先验证是否为空，不为空在使用正则表达式验证是否合法
			var reg=null;
			for(var j=0;j< orderflowernums.length;j++){//如果输入的不是数字或为空
				//var reg=/^\d+$/gi;		//在此处放了一个错误，导致调试代码了1天!!!!!!!
				// 正则表达式只能使用一次，不能定义在循环体外面
				if(orderflowernums[j].value !=""){
					reg=/^\d+$/gim;
					//var reg=new RegExp("/^(\\d)\+\$/","gi");
					//window.alert(orderflowernums[j].value);
					if(!reg.test(orderflowernums[j].value)){		//为什么验证多个text就不行？？？？
						//输入不合法，返回
						window.alert("输入的格式不正确！");
						//window.alert("您的输入为"+orderflowernums[j].value);
						//document.getElementsByName("orderflowernums")[j].value = startsale[i].value;
						//window.location.reload(true);
						return false;
					}
				}else{		//为空的话直接返回
					window.alert("输入不能为空!");
					//document.getElementsByName("orderflowernums")[j].value = startsale[i].value;
					return false;
				}
			}
			for(var i=0;i<orderflowernums.length;i++){
				//window.alert("i="+i);
				//window.alert("第"+(i+1)+"种花:"+orderflowernums[i].value);
				//window.alert(allflowernums[i].value);
				//window.alert(startsale[i].value);
				//验证输入的数字是否合法
				var orderflowernum = parseInt(orderflowernums[i].value);
				var allflowernum = parseInt(allflowernums[i].value);
				var start_sale = parseInt(startsale[i].value);
				if(orderflowernum >allflowernum ){
					window.alert("请输入正确的预订量,谢谢=======!");
					document.getElementsByName("orderflowernums")[i].innerText=startsale[i].value;
					//进来之后页面刷新一个
					//b=false;
					return false;
				}
				if(orderflowernum< start_sale){
					window.alert("请输入正确的预订量,谢谢=======!");
					document.getElementsByName("orderflowernums")[i].innerText=startsale[i].value;
					return false;
				}
			} 
			return true;
		}
		
		function gotopay(){	//用户点击"去结算"执行的函数
			//1.先验证myCart是否为空
			//2.验证用户输入的数据是否正确
			//3.若正确，则把请求交给控制器
			//if(al ==""){	//如果al为空
				//window.alert("您没有预定任何花卉，请返回继续挑选!");
				//window.location.href="/FlowerShop/index.jsp";
				//return false;
			//}
				window.open("/FlowerShop/ShowMyCartClServlet?type=gotopay","_self");
			//}
		}
	</script>

  </head>
  
  <body background="images/bg.bmp">
   <div class="navi_head">
   <span>您好,&nbsp;<font size="4px"><%=user.getUsername() %></font>&nbsp;&nbsp;&nbsp;等级:&nbsp;<%=user.getGrade() %></span>
   <span style="margin-left: 280px;"> <a href="/FlowerShop/index.jsp">【返回首页】</a><a href="/FlowerShop/UserClServlet?type=logout" onClick="return CheckLogout();">【安全退出】</a></span>
   </div>
    <div class="navi_reserve">
   <img  onClick="return test1();"src="images/logo.gif"  height="150px" />
  <!-- 如何防止首页的logo被盗 -->
  	<div class="cart_navi"><img src="images/cartnavi-1.gif" /></div>
   </div>
   <%
   		//if(al ==null){
   			//显示一个大的div
   			
   		//}
    %>
    <div class="check">感谢您的光临，以下为您的订单情况</div>
    <div class="all_reserve_flower">全部预订花卉</div>
    <div class="order_flower_info">
    <form action="/FlowerShop/ShowMyCartClServlet?type=update" method="post" onsubmit="return checkNum();">
    <table>
    <tr class="order_font"><td>编号</td><td>花卉名称</td><td>价格</td><td>市场价</td><td>数量</td><td>预订范围</td><td>小计</td><td>操作</td></tr>
    <%
    		for(int i=0;i< al.size();i++){
    			FlowerBean flower = (FlowerBean)al.get(i);			
				String flower_nums= myCart.getFlowerNumById(""+flower.getFlowerid());//得到数量
     %>
    <tr><td><%=flower.getFlowerid() %> <!-- 使用hidden传递花卉的id,库存,起批量 --><input type="hidden" name="flowerId" value="<%=flower.getFlowerid() %>" /><input type="hidden" name="startsale" value="<%=flower.getStartsale() %>"/><input type="hidden" name="allflowernums" value="<%=flower.getFlowernum() %>"/></td>
    <td><a style="text-decoration: none; color: black;" href="/FlowerShop/ShowFlowerClServlet?type=showDetail&id=<%=flower.getFlowerid() %>"><%=flower.getFlowername() %></a></td>
    <td>￥<%=flower.getFlowerprice() %></td>
    <td>￥<%=flower.getMarketprice() %></td>
    <td><input onkeypress="return updatenum(event)"  type="text" class="order_flowernums" name="orderflowernums" value="<%=Integer.parseInt(flower_nums) %>" /> <%=flower.getFlowerunit() %></td>
    <td>( <%=flower.getStartsale() %>, <%=flower.getFlowernum() %>)<%=flower.getFlowerunit() %></td>
    <td>￥<%=flowerService.getSingleFlowerPrice(flower,flower_nums) %></td><td><a style="font-size: 14px;" onClick='return confirmOper();' href='/FlowerShop/ShowMyCartClServlet?type=del&flowerid=<%=flower.getFlowerid() %>'>删除</a></td></tr>
    <%
    	
    	if(i==al.size()-1){		//最后一个
    	%>
    	 <tr><td colspan="8">&nbsp;</tr>
    <tr><td colspan="4" valign="bottom">您共预订了价值￥<%=myCart.getTotalPrice() %>的花卉</td><td colspan="4" valign="bottom">如果您修改了数量，请点此 &nbsp;<!--  <input type="submit" value="修改数量" onClick="return checkNum();"/>--><input type="image" src="images/xiugai.jpg" /><!-- 此处使用image提交数据 --></td></tr>
    <% 
    	}
     %>
     <%
		}     
      %>
    </table>
    </form>
    <div class="clearCart">如果您想清空预订，请点此</div>
    <div class="clearcart_img"><input onClick="return clearAll()" type="image" src="images/clearall.jpg"/></div>
    <div class="goto_pay"><input onClick="gotopay();" type="image" src="images/gotopay.jpg"/></div>
    <div class="goback_search"><input onClick="gobacksearch()" type="image" src="images/gobacksearch.jpg"/></div>
  <!-- 点击"去结算"时如何先在js 中验证al是否为空，为空的话给出提示，并跳转到首页。不为空则跳转到下一个控制器处理-->
    </div>
    
    <!-- 用一个大的div填充页面 -->
    <div class="big_nulldiv"></div>
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
