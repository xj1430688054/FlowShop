 package com.gcj.controller;
 
 import com.gcj.domain.FlowerBean;
 import com.gcj.domain.OrderInfo;
 import com.gcj.domain.OrderItem;
 import com.gcj.service.FlowerService;
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
 
 public class ReserveOkCl extends HttpServlet
 {
   public void doGet(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html;charset=utf-8");
     response.setCharacterEncoding("utf-8");
     response.setHeader("content-type", "text/html;charset=utf-8");
     request.setCharacterEncoding("utf-8");
     PrintWriter out = response.getWriter();
 
     response.setHeader("Cache-Control", "no store");
     response.setHeader("Pragma", "no store");
     response.setDateHeader("Expires", 0L);
 
     OrderService orderService = new OrderService();
     FlowerService flowerService = new FlowerService();
 
     String orderId = request.getParameter("no");
     System.out.println("接收到的id=" + orderId);
 
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
     request.getRequestDispatcher("/WEB-INF/user/ReserveOk.jsp").forward(request, response);
   }
 
   public void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html");
     PrintWriter out = response.getWriter();
     doGet(request, response);
   }
 } 