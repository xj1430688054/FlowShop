 package com.gcj.controller;
 
 import com.gcj.domain.FlowerBean;
 import com.gcj.domain.Users;
 import com.gcj.service.FlowerService;
 import com.gcj.service.MyCart;
 import java.io.IOException;
 import java.io.PrintWriter;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;
 
 public class ReserveClServlet extends HttpServlet
 {
   public void doGet(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html;charset=utf-8");
     response.setCharacterEncoding("utf-8");
     request.setCharacterEncoding("utf-8");
     response.setHeader("content-type", "text/html;charset=utf-8");
     PrintWriter out = response.getWriter();
 
     FlowerService flowerService = new FlowerService();
 
     String type = request.getParameter("type");
 
     MyCart myCart = (MyCart)request.getSession().getAttribute("myCart");
 
     Users user = (Users)request.getSession().getAttribute("loginuser");
     FlowerBean flower = new FlowerBean();
 
     if ("reserve".equals(type))
     {
       String flowerid = request.getParameter("flowerid");
       String reserve_num = request.getParameter("reserve_num");
 
       flower = flowerService.getFlowerById(Integer.parseInt(flowerid));
       flower.setReservenums(Integer.parseInt(reserve_num));
 
       if (user != null)
       {
         request.getSession().setAttribute("reserve_flower", flower);
 
         request.getRequestDispatcher("/WEB-INF/user/showReservationInfo.jsp").forward(request, response);
       }
       else
       {
         request.getSession().setAttribute("reserve_flower", flower);
 
         request.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(request, response);
       }
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