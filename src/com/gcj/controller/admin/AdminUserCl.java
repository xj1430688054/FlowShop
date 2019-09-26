 package com.gcj.controller.admin;
 
 import com.gcj.domain.Users;
 import com.gcj.service.UsersService;
 import com.gcj.service.admin.AdminService;
 import java.io.IOException;
 import java.io.PrintWriter;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 
 public class AdminUserCl extends HttpServlet
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
 
     UsersService usersService = new UsersService();
     AdminService adminService = new AdminService();
     if ("showAllAdmin".equals(type))
     {
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=users");
     } else if ("userDetail".equals(type))
     {
       String userid = request.getParameter("id");
 
       Users user = usersService.getUsersById(userid);
       request.setAttribute("userdetail", user);
       request.getRequestDispatcher("/WEB-INF/admin/showUserDetail.jsp").forward(request, response);
     } else if ("del".equals(type))
     {
       String id = request.getParameter("userid");
       if (adminService.delUser(id))
         out.println("恭喜您，删除成功");
       else
         out.println("对不起，删除失败");
     }
     else if ("selectuser".equals(type))
     {
       String username = request.getParameter("username");
 
       Users user = usersService.getUsersByName(username);
       request.setAttribute("selectUser", user);
       request.getRequestDispatcher("/WEB-INF/admin/showSelectUser.jsp").forward(request, response);
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