 package com.gcj.controller.admin;
 
 import com.gcj.domain.admin.Admin;
 import com.gcj.service.admin.AdminService;
 import java.io.IOException;
 import java.io.PrintStream;
 import java.io.PrintWriter;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;
 
 public class AdminLoginCl extends HttpServlet
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
     if ("login".equals(type))
     {
       String username = request.getParameter("adminname");
       String pwd = request.getParameter("passwd");
       if (adminService.checkAdmin(username, pwd))
       {
         System.out.println("验证成功");
 
         Admin admin = adminService.getAdminByName(username);
         request.getSession().setAttribute("loginadmin", admin);
 
         request.getRequestDispatcher("/WEB-INF/admin/index.jsp").forward(request, response);
       }
       else
       {
         response.sendRedirect("/FlowerShop/AdminLoginCl?type=errinfo");
       }
     } else if ("errinfo".equals(type))
     {
       String err = "用户名或密码错误";
       request.setAttribute("err", err);
       request.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(request, response);
     } else if ("logout".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(request, response);
     }
   }
 
   public void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
   	   response.setContentType("text/html;charset=utf-8");
     response.setCharacterEncoding("utf-8");
     request.setCharacterEncoding("utf-8");
     response.setHeader("content-type", "text/html;charset=utf-8");
     //response.setContentType("text/html");
     PrintWriter out = response.getWriter();
     doGet(request, response);
   }
 } 