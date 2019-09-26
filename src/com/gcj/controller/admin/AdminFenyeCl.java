 package com.gcj.controller.admin;
 
 import com.gcj.domain.Order;
 import com.gcj.domain.OrderInfo;
 import com.gcj.service.CommentService;
 import com.gcj.service.FlowerKnowledgeService;
 import com.gcj.service.FlowerService;
 import com.gcj.service.FlowerTrendsService;
 import com.gcj.service.OrderItemService;
 import com.gcj.service.OrderService;
 import com.gcj.service.UserMessageService;
 import com.gcj.service.admin.AdminService;
 import java.io.IOException;
 import java.io.PrintStream;
 import java.io.PrintWriter;
 import java.util.ArrayList;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 
 public class AdminFenyeCl extends HttpServlet
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
 
     AdminService adminService = new AdminService();
     FlowerService flowerService = new FlowerService();
     OrderService orderService = new OrderService();
     UserMessageService userMessageService = new UserMessageService();
     OrderItemService orderItemService = new OrderItemService();
     CommentService commentService = new CommentService();
     FlowerTrendsService flowerTrendsService = new FlowerTrendsService();
 
     FlowerKnowledgeService flowerKnowledgeService = new FlowerKnowledgeService();
 
     if ("admin".equals(type))
     {
       int pageNow = 1;
       int pageSize = 4;
 
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
       ArrayList al = adminService.getAdminsByPage(pageSize, pageNow);
 
       int pageCount = adminService.getPageCount(pageSize);
 
       request.setAttribute("admininfo", al);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllAdmin.jsp").forward(request, response);
     } else if ("users".equals(type))
     {
       int pageNow = 1;
       int pageSize = 4;
 
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
       ArrayList al = adminService.getUsersByPage(pageSize, pageNow);
 
       int pageCount = adminService.getPageCount1(pageSize);
 
       request.setAttribute("usersinfo", al);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllUsers.jsp").forward(request, response);
     } else if ("flowers".equals(type))
     {
       int pageNow = 1;
       int pageSize = 6;
 
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
       ArrayList al = flowerService.getFlowersByPage(pageSize, pageNow);
 
       int pageCount = flowerService.getPageCount(pageSize);
 
       request.setAttribute("flowersinfo", al);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllFlowers.jsp").forward(request, response);
     } else if ("orders".equals(type))
     {
       int pageNow = 1;
       int pageSize = 6;
 
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
 
       ArrayList al = orderService.getOrdersByPage(pageSize, pageNow);
       ArrayList orderInfoal = new ArrayList();
       for (int i = 0; i < al.size(); i++) {
         Order order = (Order)al.get(i);
         OrderInfo orderInfo = orderService.getOrderInfoById(""+order.getId());
         orderInfoal.add(orderInfo);
       }
 
       int pageCount = orderService.getPageCount(pageSize);
 
       request.setAttribute("orderinfoal", orderInfoal);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllOrders.jsp").forward(request, response);
     } else if ("allgoingorders".equals(type))
     {
       int pageNow = 1;
       int pageSize = 6;
 
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
 
       ArrayList al = orderService.getgoingOrdersByPage(pageSize, pageNow);
       ArrayList orderInfoal = new ArrayList();
       for (int i = 0; i < al.size(); i++) {
         Order order = (Order)al.get(i);
         OrderInfo orderInfo = orderService.getOrderInfoById(""+order.getId());
         orderInfoal.add(orderInfo);
       }
 
       int pageCount = orderService.getGoingPageCount(pageSize);
 
       request.setAttribute("orderinfoal", orderInfoal);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllGoingOrders.jsp").forward(request, response);
     } else if ("allfinishorders".equals(type))
     {
       int pageNow = 1;
       int pageSize = 6;
 
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
 
       ArrayList al = orderService.getfinishOrdersByPage(pageSize, pageNow);
       ArrayList orderInfoal = new ArrayList();
       for (int i = 0; i < al.size(); i++) {
         Order order = (Order)al.get(i);
         OrderInfo orderInfo = orderService.getOrderInfoById(""+order.getId());
         orderInfoal.add(orderInfo);
       }
 
       int pageCount = orderService.getFinishPageCount(pageSize);
 
       request.setAttribute("orderinfoal", orderInfoal);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllFinishOrders.jsp").forward(request, response);
     } else if ("cancelorders".equals(type))
     {
       int pageNow = 1;
       int pageSize = 6;
 
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
 
       ArrayList al = orderService.getcancelOrdersByPage(pageSize, pageNow);
 
       int pageCount = orderService.getCancelPageCount(pageSize);
 
       request.setAttribute("cancelal", al);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllCancelOrders.jsp").forward(request, response);
     } else if ("message".equals(type))
     {
       int pageNow = 1;
       int pageSize = 4;
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
       ArrayList al = userMessageService.getMessagesByPage(pageSize, pageNow);
 
       int pageCount = userMessageService.getPageCount(pageSize);
 
       System.out.println("al的长度=" + al.size());
 
       request.setAttribute("message", al);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllMessages.jsp").forward(request, response);
     } else if ("reservedflowers".equals(type))
     {
       int pageNow = 1;
       int pageSize = 6;
 
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
 
       ArrayList allreservedfloweral = orderItemService.getAllReservedFlowerByPage(pageSize, pageNow);
 
       int pageCount = orderItemService.getAllReservedFlower().size() % pageSize == 0 ? orderItemService.getAllReservedFlower().size() / pageSize : orderItemService.getAllReservedFlower().size() / pageSize + 1;
       System.out.println("共有的页数=" + pageCount);
 
       request.setAttribute("allreservedfloweral", allreservedfloweral);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllReservedFlower.jsp").forward(request, response);
     } else if ("getallsameflower".equals(type))
     {
       int pageNow = 1;
       int pageSize = 6;
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
 
       ArrayList allsamefloweral = orderItemService.getOrderedFlowerByPage(pageSize, pageNow);
 
       int pageCount = orderItemService.getAllOrderedFlower().size() % pageSize == 0 ? orderItemService.getAllOrderedFlower().size() / pageSize : orderItemService.getAllOrderedFlower().size() / pageSize + 1;
       System.out.println("共有的页数=" + pageCount);
 
       request.setAttribute("allsamefloweral", allsamefloweral);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllCountFlower.jsp").forward(request, response);
     } else if ("okflowers".equals(type))
     {
       int pageNow = 1;
       int pageSize = 6;
 
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
 
       ArrayList okfloweral = orderItemService.getFinishFlowerByPage(pageSize, pageNow);
 
       int pageCount = orderItemService.getAllFinishFlower().size() % pageSize == 0 ? orderItemService.getAllFinishFlower().size() / pageSize : orderItemService.getAllFinishFlower().size() / pageSize + 1;
       System.out.println("共有的页数=" + pageCount);
 
       request.setAttribute("okfloweral", okfloweral);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllFinishFlower.jsp").forward(request, response);
     } else if ("comment".equals(type))
     {
       int pageNow = 1;
       int pageSize = 4;
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
       ArrayList al = commentService.getCommentByPage(pageSize, pageNow);
 
       int pageCount = commentService.getPageCount(pageSize);
 
       System.out.println("al的长度=" + al.size());
 
       request.setAttribute("comment", al);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllComment.jsp").forward(request, response);
     } else if ("flowertrends".equals(type))
     {
       int pageNow = 1;
       int pageSize = 6;
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
       ArrayList al = flowerTrendsService.getFlowerTrendsListByPage(pageSize, pageNow);
 
       int pageCount = flowerTrendsService.getRFlowerTrendsPageCount(pageSize);
 
       request.setAttribute("trends", al);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllFlowerTrends.jsp").forward(request, response);
     } else if ("flowerknowledge".equals(type))
     {
       int pageNow = 1;
       int pageSize = 6;
       String spageNow = request.getParameter("pageNow");
       if (spageNow != null) {
         pageNow = Integer.parseInt(spageNow);
       }
       ArrayList al = flowerKnowledgeService.getFlowerKnowledgeByPage(pageSize, pageNow);
 
       int pageCount = flowerKnowledgeService.getFlowerKnowledgePageCount(pageSize);
 
       request.setAttribute("knowledges", al);
       request.setAttribute("pagecount", pageCount);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/admin/showAllFlowerKnowledge.jsp").forward(request, response);
     }
   }
 
   public void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html");
     PrintWriter out = response.getWriter();
     doGet(request, response);
   }
 } 