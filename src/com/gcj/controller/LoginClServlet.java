 package com.gcj.controller;
 
 import com.gcj.domain.FlowerBean;
 import com.gcj.domain.Users;
 import com.gcj.service.MyCart;
 import com.gcj.service.UsersService;
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
 
 public class LoginClServlet extends HttpServlet
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
 
     Users user1 = (Users)request.getSession().getAttribute("loginuser");
 
     String checkCode = (String)request.getSession().getAttribute("checkcode");
     UsersService usersService = new UsersService();
 
     if ("gotoLoginView".equals(type))
     {
       if (user1 != null)
       {
         response.sendRedirect("/FlowerShop/index.jsp");
       }
       else
       {
         request.getRequestDispatcher("/WEB-INF/user/userlogin.jsp").forward(request, response);
       }
     }
     else if ("login".equals(type))
     {
       String username = request.getParameter("username");
       String pwd = request.getParameter("pwd");
       String checkcode1 = request.getParameter("checkcode");
       System.out.println("checkcode1=" + checkcode1);
       System.out.println("生成的验证码=" + checkCode);
 
       FlowerBean flowerBean = (FlowerBean)request.getSession().getAttribute("reserve_flower");
       if (checkcode1.equals(checkCode)) {
         if (usersService.checkUser(username, pwd))
         {
           System.out.println("验证成功");
 
           Users user = usersService.getUsersByName(username);
           request.getSession().setAttribute("loginuser", user);
 
           MyCart myCart = new MyCart();
 
           request.getSession().setAttribute("myCart", myCart);
 
           request.getRequestDispatcher("/WEB-INF/user/showReservationInfo.jsp").forward(request, response);
         }
         else
         {
           String err = "用户名或密码错误";
           request.setAttribute("err", err);
           request.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(request, response);
         }
       }
       else {
         String err = "验证码错误";
         request.setAttribute("err", err);
         request.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(request, response);
       }
     } else if ("userlogin".equals(type))
     {
       String username = request.getParameter("username");
       String pwd = request.getParameter("pwd");
       String checkcode2 = request.getParameter("checkcode");
       if (checkcode2.equals(checkCode)) {
         if (usersService.checkUser(username, pwd))
         {
           Users user = usersService.getUsersByName(username);
           request.getSession().setAttribute("loginuser", user);
 
           MyCart myCart = new MyCart();
           request.getSession().setAttribute("myCart", myCart);
 
           response.sendRedirect("/FlowerShop/index.jsp");
         }
         else
         {
           String err = "用户名或密码错误";
           request.setAttribute("err", err);
           request.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(request, response);
         }
       } else {
         String err = "验证码错误";
         request.setAttribute("err", err);
         request.getRequestDispatcher("/WEB-INF/user/userlogin.jsp").forward(request, response);
       }
     } else if ("userlogin1".equals(type))
     {
       String username = request.getParameter("username");
       String pwd = request.getParameter("pwd");
       String checkcode3 = request.getParameter("checkcode");
 
       FlowerBean flower = (FlowerBean)request.getSession().getAttribute("putintocart_flower");
       System.out.println("LoginClServlet中接收到的flower的数量reserve_num=" + flower.getReservenums());
       if (checkcode3.equals(checkCode)) {
         if (usersService.checkUser(username, pwd))
         {
           Users user = usersService.getUsersByName(username);
           request.getSession().setAttribute("loginuser", user);
 
           System.out.println("======nums=" + flower.getReservenums());
           MyCart myCart = new MyCart();
           myCart.addFlower(""+flower.getFlowerid(), ""+flower.getReservenums());
           request.getSession().setAttribute("myCart", myCart);
           ArrayList al = myCart.showMyCart();
           request.setAttribute("mycartinfo", al);
 
           request.getRequestDispatcher("/WEB-INF/user/showMyCart.jsp").forward(request, response);
         }
         else
         {
           String err = "用户名或密码错误";
           request.setAttribute("err", err);
           request.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(request, response);
         }
       } else {
         String err = "验证码错误";
         request.setAttribute("err", err);
         request.getRequestDispatcher("/WEB-INF/user/userlogin.jsp").forward(request, response);
       }
     } else if ("restore".equals(type))
     {
       String username = request.getParameter("username");
       String pwd = request.getParameter("pwd");
       String checkcode3 = request.getParameter("checkcode");
 
       if (checkcode3.equals(checkCode)) {
         if (usersService.checkUser(username, pwd))
         {
           Users user = usersService.getUsersByName(username);
           request.getSession().setAttribute("loginuser", user);
 
           MyCart myCart = new MyCart();
 
           request.getSession().setAttribute("myCart", myCart);
 
           response.sendRedirect("/FlowerShop/RestoreFlowerCl?type=restore_afterlogin");
         }
         else
         {
           String err = "用户名或密码错误";
           request.setAttribute("err", err);
           request.getRequestDispatcher("/WEB-INF/user/restoreLogin.jsp").forward(request, response);
         }
       } else {
         String err = "验证码错误";
         request.setAttribute("err", err);
         request.getRequestDispatcher("/WEB-INF/user/restoreLogin.jsp").forward(request, response);
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