 package com.gcj.controller;
 
 import com.gcj.domain.FlowerBean;
 import com.gcj.domain.Users;
 import com.gcj.service.FlowerService;
 import com.gcj.service.MyCart;
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
 
 public class PutIntoCartClServlet extends HttpServlet
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
 
     Users user = (Users)request.getSession().getAttribute("loginuser");
     MyCart myCart = (MyCart)request.getSession().getAttribute("myCart");
 
     FlowerService flowerService = new FlowerService();
     if ("putintocart".equals(type))
     {
       String flowerid = request.getParameter("flowerid");
       String reserve_num = request.getParameter("reserve_num");
       System.out.println("(1)PutIntoCartClServlet控制器中接收的reserve_num=" + reserve_num);
 
       FlowerBean flower = flowerService.getFlowerById(Integer.parseInt(flowerid));
       flower.setReservenums(Integer.parseInt(reserve_num));
       System.out.println("(2)PutIntoCartClServlet控制器中接收的reserve_num=" + flower.getReservenums());
 
       if (user != null)
       {
         myCart.addFlower(flowerid, reserve_num);
         ArrayList al = myCart.showMyCart();
         request.setAttribute("mycartinfo", al);
 
         request.getRequestDispatcher("/WEB-INF/user/showMyCart.jsp").forward(request, response);
       }
       else
       {
         System.out.println("(3)PutIntoCartClServlet控制器中接收的reserve_num=" + flower.getReservenums());
         request.setAttribute("putintocart_flower", flower);
         request.getRequestDispatcher("/WEB-INF/user/userlogin1.jsp").forward(request, response);
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