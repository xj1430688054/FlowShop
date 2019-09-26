 package com.gcj.controller;
 
 import com.gcj.domain.Users;
 import com.gcj.service.UsersService;
 import java.io.IOException;
 import java.io.PrintWriter;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 
 public class CheckNameServlet extends HttpServlet
 {
   public void doGet(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html;charset=utf-8");
     response.setCharacterEncoding("utf-8");
     request.setCharacterEncoding("utf-8");
     response.setHeader("content-type", "text/html;charset=utf-8");
     PrintWriter out = response.getWriter();
 
     String username = request.getParameter("uname1");
     System.out.println("username=" + username);
 
     UsersService usersService = new UsersService();
 
     if ((username != null) && (!username.equals(""))) {
       Users user = usersService.getUsersByName(username);
       if (user.getUsername() != null)
       {
         out.print("该用户名已经存在");
       }
       else out.print("该用户名可以使用");
     }
     else
     {
       out.println("用户名不能为空");
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