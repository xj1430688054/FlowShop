 package com.gcj.controller.admin;
 
 import com.gcj.domain.CancelOrder;
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
 
 public class AdminOrderCl extends HttpServlet
 {
   public void doGet(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html;charset=utf-8");
     response.setCharacterEncoding("utf-8");
     request.setCharacterEncoding("utf-8");
     response.setHeader("content-type", "text/html;charset=utf-8");
     PrintWriter out = response.getWriter();
 
     String type = request.getParameter("type");
     OrderService orderService = new OrderService();
     FlowerService flowerService = new FlowerService();
     if ("manage".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/admin/index.jsp").forward(request, response);
     } else if ("showAllOrders".equals(type))
     {
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=orders");
     } else if ("orderDetail".equals(type))
     {
       String orderId = request.getParameter("id");
       System.out.println("管理员要查看的订单号=" + orderId);
 
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
       System.out.println("orderitem有" + al.size() + "条");
       System.out.println("订单取消的时间=" + cancelOrder.getCanceltime());
 
       request.setAttribute("orderinfo", orderInfo);
       request.setAttribute("floweral", floweral);
       request.setAttribute("al", al);
       request.setAttribute("cancelorder", cancelOrder);
       request.getRequestDispatcher("/WEB-INF/admin/OrderDetail.jsp").forward(request, response);
     } else if ("gotoupdview".equals(type))
     {
       String orderId = request.getParameter("id");
 
       System.out.println("管理员要查看的订单号=" + orderId);
 
       OrderInfo orderInfo = orderService.getOrderInfoById(orderId);
 
       ArrayList al = orderService.getOrderDetailById(orderId);
 
       ArrayList floweral = new ArrayList();
       for (int i = 0; i < al.size(); i++) {
         OrderItem orderItem = (OrderItem)al.get(i);
         FlowerBean flower = flowerService.getFlowerById(orderItem.getFlowerid());
         floweral.add(flower);
       }
 
       CancelOrder cancelOrder = orderService.getCancelOrderById(orderId);
 
       request.setAttribute("orderinfo", orderInfo);
       request.setAttribute("floweral", floweral);
       request.setAttribute("al", al);
       request.setAttribute("cancelorder", cancelOrder);
       request.getRequestDispatcher("/WEB-INF/admin/updateOrderInfo.jsp").forward(request, response);
     } else if ("updorder".equals(type))
     {
       String orderid = request.getParameter("no");
       String ftype = request.getParameter("ftype");
 
       String state = ftype;
 
       if ("交易成功".equals(ftype))
       {
         OrderInfo orderInfo = orderService.getOrderInfoById(orderid);
 
         ArrayList al = orderService.getOrderDetailById(orderid);
 
         ArrayList floweral = new ArrayList();
         for (int i = 0; i < al.size(); i++) {
           OrderItem orderItem = (OrderItem)al.get(i);
           FlowerBean flower = flowerService.getFlowerById(orderItem.getFlowerid());
           floweral.add(flower);
         }
 
         flowerService.updateFlowerNumsByOrsersItem(al, floweral);
       }
 
       if (orderService.updOrders(orderid, state))
         out.println("恭喜您,修改成功!");
       else
         out.println("对不起,修改失败!");
     }
     else if ("selectorder".equals(type))
     {
       String orderid = request.getParameter("orderid");
 
       OrderInfo orderInfo = orderService.getOrderInfoById(orderid);
       request.setAttribute("orderinfo", orderInfo);
       request.getRequestDispatcher("/WEB-INF/admin/showSelectOrder.jsp").forward(request, response);
     } else if ("getallgoingorder".equals(type))
     {
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=allgoingorders");
     } else if ("getallfinishorder".equals(type))
     {
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=allfinishorders");
     } else if ("showcancelOrders".equals(type))
     {
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=cancelorders");
     }
   }
 
   public void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html;charset=utf-8");
     response.setCharacterEncoding("utf-8");
     request.setCharacterEncoding("utf-8");
     response.setHeader("content-type", "text/html;charset=utf-8");
     PrintWriter out = response.getWriter();
     doGet(request, response);
   }
 }
 