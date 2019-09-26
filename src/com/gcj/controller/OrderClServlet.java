 package com.gcj.controller;
 
 import com.gcj.domain.CancelOrder;
 import com.gcj.domain.ExtraInfo;
 import com.gcj.domain.FlowerBean;
 import com.gcj.domain.OrderInfo;
 import com.gcj.domain.OrderItem;
 import com.gcj.domain.Users;
 import com.gcj.service.CommentService;
 import com.gcj.service.FlowerService;
 import com.gcj.service.MyCart;
 import com.gcj.service.OrderService;
 import java.io.IOException;
 import java.io.PrintStream;
 import java.io.PrintWriter;
 import java.util.ArrayList;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;
 
 public class OrderClServlet extends HttpServlet
 {
   public void doGet(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html;charset=utf-8");
     response.setCharacterEncoding("utf-8");
     response.setHeader("content-type", "text/html;charset=utf-8");
     request.setCharacterEncoding("utf-8");
     PrintWriter out = response.getWriter();
 
     String type = request.getParameter("type");
 
     MyCart myCart = (MyCart)request.getSession().getAttribute("myCart");
 
     Users user = (Users)request.getSession().getAttribute("loginuser");
     OrderService orderService = new OrderService();
     FlowerService flowerService = new FlowerService();
     CommentService commentService = new CommentService();
     if ("reserve".equals(type))
     {
       FlowerBean flowerBean = (FlowerBean)request.getSession().getAttribute("reserve_flower");
 
       String extrainfo = request.getParameter("othermessage");
       String paymode = request.getParameter("payedway");
       String sendAddress = request.getParameter("sendfloweraddress");
 
       ExtraInfo extraInfo = new ExtraInfo();
       extraInfo.setExtrainfo(extrainfo);
       extraInfo.setPaymode(paymode);
       extraInfo.setSendaddress(sendAddress);
       extraInfo.setIspayed("否");
 
       int orderId = orderService.addOrder1(flowerBean, flowerService, user, extraInfo);
       System.out.println("生成的id=" + orderId);
 
       if (orderId != -1)
       {
         response.sendRedirect("/FlowerShop/ReserveOkCl?no=" + orderId + "&type=reserve");
       }
       else {
         request.getRequestDispatcher("/WEB-INF/user/ReserveErr.jsp").forward(request, response);
       }
     }
     else if ("frommyCart".equals(type))
     {
       String extrainfo = request.getParameter("othermessage");
       String paymode = request.getParameter("payedway");
       String sendAddress = request.getParameter("sendfloweraddress");
 
       ExtraInfo extraInfo = new ExtraInfo();
       extraInfo.setExtrainfo(extrainfo);
       extraInfo.setPaymode(paymode);
       extraInfo.setSendaddress(sendAddress);
       extraInfo.setIspayed("否");
 
       int orderId = orderService.addOrderByMyCart(myCart, user, extraInfo);
       if (orderId != -1)
       {
         response.sendRedirect("/FlowerShop/ReserveOkCl?no=" + orderId + "&type=reserve");
       }
       else
         request.getRequestDispatcher("/WEB-INF/user/ReserveErr.jsp").forward(request, response);
     }
     else if ("showorderdetail".equals(type))
     {
       String orderId = request.getParameter("no");
 
       OrderInfo orderInfo = orderService.getOrderInfoById(orderId);
 
       ArrayList al = orderService.getOrderDetailById(orderId);
 
       ArrayList floweral = new ArrayList();
       for (int i = 0; i < al.size(); i++) {
         OrderItem orderItem = (OrderItem)al.get(i);
         FlowerBean flower = flowerService.getFlowerById(orderItem.getFlowerid());
         floweral.add(flower);
       }
 
       CancelOrder cancelOrder = orderService.getCancelOrderById(orderId);
 
       System.out.println("预订的花卉种类有" + floweral.size() + "种");
       System.out.println("该订单的交易状态为" + orderInfo.getTradestate());
 
       request.setAttribute("orderinfo", orderInfo);
       request.setAttribute("floweral", floweral);
       request.setAttribute("al", al);
       request.setAttribute("cancelorder", cancelOrder);
       request.getRequestDispatcher("/WEB-INF/user/showOrderDetail.jsp").forward(request, response);
     }
     else if ("cancelorder".equals(type))
     {
       String orderid = request.getParameter("orderid");
       String reason = request.getParameter("reason");
       String state = "交易关闭";
       if ((orderService.insertCancelorder(orderid, reason)) && (orderService.updOrders(orderid, state)))
       {
         out.println("恭喜您，订单取消成功!");
       }
       else out.println("对不起，订单取消失败!");
     }
     else if ("goshoworderdetail".equals(type))
     {
       String orderid = request.getParameter("no");
 
       response.sendRedirect("/FlowerShop/OrderClServlet?type=showorderdetail&no=" + orderid);
     } else if ("myorder".equals(type))
     {
       ArrayList allOrderInfo = orderService.getAllOrdersByUserId(""+user.getUserid());
 
       request.setAttribute("allorderinfo", allOrderInfo);
       request.getRequestDispatcher("/WEB-INF/user/showAllOrder.jsp").forward(request, response);
     } else if ("gotoevaluate".equals(type))
     {
       String orderId = request.getParameter("no");
       System.out.println("要评价的订单编号=" + orderId);
 
       OrderInfo orderInfo = orderService.getOrderInfoById(orderId);
 
       ArrayList al = orderService.getOrderDetailById(orderId);
 
       ArrayList floweral = new ArrayList();
       for (int i = 0; i < al.size(); i++) {
         OrderItem orderItem = (OrderItem)al.get(i);
         FlowerBean flower = flowerService.getFlowerById(orderItem.getFlowerid());
         floweral.add(flower);
       }
 
       System.out.println("预订的花卉种类有" + floweral.size() + "种");
       System.out.println("该订单的交易状态为" + orderInfo.getTradestate());
 
       request.setAttribute("orderinfo", orderInfo);
       request.setAttribute("floweral", floweral);
       request.setAttribute("al", al);
 
       request.getRequestDispatcher("/WEB-INF/user/showOrderComment.jsp").forward(request, response);
     }
     else if ("evaluate".equals(type))
     {
       String orderId = request.getParameter("orderid");
 
       String[] comments = request.getParameterValues("comment");
       System.out.println("订单编号=" + orderId);
       System.out.println("评论的条数=" + comments.length);
       for (int i = 0; i < comments.length; i++) {
         System.out.println(comments[i]);
       }
 
       OrderInfo orderInfo = orderService.getOrderInfoById(orderId);
 
       ArrayList al = orderService.getOrderDetailById(orderId);
 
       ArrayList floweral = new ArrayList();
       for (int i = 0; i < al.size(); i++) {
         OrderItem orderItem = (OrderItem)al.get(i);
         FlowerBean flower = flowerService.getFlowerById(orderItem.getFlowerid());
         floweral.add(flower);
       }
       System.out.println("花卉的数量=" + floweral.size());
 
       if (commentService.insertComments(orderInfo, floweral, user, comments))
       {
         request.getRequestDispatcher("/WEB-INF/user/CommentOk.jsp").forward(request, response);
       }
     } else if ("gotopayview".equals(type))
     {
       String orderId = request.getParameter("id");
 
       OrderInfo orderInfo = orderService.getOrderInfoById(orderId);
       request.setAttribute("orderinfo", orderInfo);
 
       request.getRequestDispatcher("/WEB-INF/user/PayView.jsp").forward(request, response);
     } else if ("pay".equals(type))
     {
       String orderid = request.getParameter("orderid");
 
       String state = "买家已付款";
       if (orderService.updOrders(orderid, state))
         out.println("恭喜您，付款成功");
       else
         out.println("对不起，付款失败");
     }
   }
 
   public void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html;charset=utf-8");
     response.setCharacterEncoding("utf-8");
     response.setHeader("content-type", "text/html;charset=utf-8");
     request.setCharacterEncoding("utf-8");
     PrintWriter out = response.getWriter();
     doGet(request, response);
   }
 }
 