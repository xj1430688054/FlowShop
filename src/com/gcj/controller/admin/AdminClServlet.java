 package com.gcj.controller.admin;
 
 import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gcj.domain.admin.Admin;
import com.gcj.service.admin.AdminService;
 
 public class AdminClServlet extends HttpServlet
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
     if ("logout".equals(type))
     {
       Admin admin = (Admin)request.getSession().getAttribute("loginadmin");
       if (admin != null)
       {
         request.getSession().invalidate();
         response.sendRedirect("/FlowerShop/AdminLoginCl?type=logout");
       }
     } else if ("manage".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/admin/index.jsp").forward(request, response);
     } else if ("goupdview".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/admin/updateAdminInfo.jsp").forward(request, response);
     } else if ("getOldPwd".equals(type))
     {
       String adminid = request.getParameter("adminid");
       String passwd = request.getParameter("passwd");
 
       Admin admin = adminService.getAdminById(adminid);
       if (passwd.equals(admin.getPasswd()))
       {
         out.println("原密码输入正确");
       }
       else out.println("原密码输入不正确");
     }
     else if ("updatePwd".equals(type))
     {
       String adminid = request.getParameter("adminid");
       String newpasswd = request.getParameter("newpasswd");
       Admin admin = adminService.getAdminById(adminid);
       admin.setPasswd(newpasswd);
       if (adminService.updAdminPwd(admin))
       {
         request.getSession().setAttribute("loginadmin", admin);
         out.println("恭喜您，修改成功");
       } else {
         out.println("对不起，修改失败");
       }
     } else if ("goinsertview".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/admin/AddAdmin.jsp").forward(request, response);
     } else if ("checkname".equals(type))
     {
       String adminname = request.getParameter("adminname");
       if ((adminname != null) && (!adminname.equals(""))) {
         Admin admin = adminService.getAdminByName(adminname);
         if (admin.getName() != null)
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
     else if ("addAdmin".equals(type))
     {
       String adminname = request.getParameter("adminname");
       String newpasswd = request.getParameter("newpasswd");
 
       Admin admin = new Admin();
       admin.setName(adminname);
       admin.setPasswd(newpasswd);
       admin.setGrade("普通管理员");
 
       if (adminService.insertAdmin(admin))
       {
         out.println("恭喜您，添加成功");
       }
       else out.println("对不起，添加失败");
     }
     else if ("showAllAdmin".equals(type))
     {
       System.out.println("程序执行到了这里了①==========");
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=admin");
     } else if ("del".equals(type))
     {
       String id = request.getParameter("adminid");
       if (adminService.delAdmin(id))
         out.println("恭喜您，删除成功");
       else
         out.println("对不起，删除失败");
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