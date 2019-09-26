 package com.gcj.controller;
 
 import com.gcj.domain.Users;
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
 
 public class ShowMyCartClServlet extends HttpServlet
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
     MyCart myCart = (MyCart)request.getSession().getAttribute("myCart");
 
     Users user = (Users)request.getSession().getAttribute("loginuser");
 
     if ("clearAll".equals(type))
     {
       System.out.println("程序执行到了这里1");
       myCart.clearFlower();
 
       ArrayList al = myCart.showMyCart();
 
       System.out.println("程序执行到了这里1 al=" + al);
       request.setAttribute("mycartinfo", al);
       request.getRequestDispatcher("/WEB-INF/user/showMyCart.jsp").forward(request, response);
     } else if ("del".equals(type))
     {
       String flowerid = request.getParameter("flowerid");
       myCart.delFlower(flowerid);
 
       ArrayList al = myCart.showMyCart();
 
       request.setAttribute("mycartinfo", al);
       request.getRequestDispatcher("/WEB-INF/user/showMyCart.jsp").forward(request, response);
     } else if ("update".equals(type))
     {
       String[] flowerIds = request.getParameterValues("flowerId");
 
       String[] orderflowernums = request.getParameterValues("orderflowernums");
 
       if (flowerIds != null) {
         for (int i = 0; i < flowerIds.length; i++)
         {
           myCart.upFlower(flowerIds[i], orderflowernums[i]);
         }
       }
 
       ArrayList al = myCart.showMyCart();
 
       request.setAttribute("mycartinfo", al);
       request.getRequestDispatcher("/WEB-INF/user/showMyCart.jsp").forward(request, response);
     } else if ("gotopay".equals(type))
     {
       ArrayList al = myCart.showMyCart();
       if (al.size() == 0)
       {
         response.sendRedirect("/FlowerShop/index.jsp");
       }
       else {
         request.setAttribute("mycartinfo", al);
         System.out.println("去结算的请求");
         request.getRequestDispatcher("/WEB-INF/user/showMyOrderFlower.jsp").forward(request, response);
       }
     } else if ("myCart".equals(type))
     {
       ArrayList al = myCart.showMyCart();
 
       request.setAttribute("mycartinfo", al);
       request.getRequestDispatcher("/WEB-INF/user/showMyCart.jsp").forward(request, response);
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
 