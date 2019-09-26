 package com.gcj.controller;
 
 import com.gcj.domain.FlowerBean;
 import com.gcj.domain.RestoreFlower;
 import com.gcj.domain.Users;
 import com.gcj.service.FlowerService;
 import java.io.IOException;
 import java.io.PrintStream;
 import java.io.PrintWriter;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;
 
 public class RestoreFlowerCl extends HttpServlet
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
 
     Users user = (Users)request.getSession().getAttribute("loginuser");
     if ("restore".equals(type))
     {
       String flowerid = request.getParameter("flowerid");
       System.out.println("第一步得到的id=" + flowerid);
 
       request.getSession().setAttribute("restoreflowerid", flowerid);
       if (user != null)
       {
         System.out.println("第二步用户已登录，调转到另一个控制器");
         response.sendRedirect("/FlowerShop/RestoreFlowerCl?type=restoreflower");
       } else {
         out.println("您还没有登录,立即登录?");
       }
     } else if ("gorestore".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/user/restoreLogin.jsp").forward(request, response);
     } else if ("restoreflower".equals(type))
     {
       String flowerid = (String)request.getSession().getAttribute("restoreflowerid");
       System.out.println("第三步id=" + flowerid);
       FlowerBean flower = flowerService.getFlowerById(Integer.parseInt(flowerid));
 
       RestoreFlower restoreFlower = flowerService.getRestoreFlowerInfoById(flowerid);
       if (flowerService.getRestoreFlowerInfo(flowerid, ""+user.getUserid())) {
         request.getSession().removeAttribute("restoreflowerid");
         out.println("您已经收藏过该花卉!");
       }
       else if (flowerService.restoreFlower(flower, user)) {
         request.getSession().removeAttribute("restoreflowerid");
         out.println("恭喜您,收藏成功!");
       } else {
         request.getSession().removeAttribute("restoreflowerid");
         out.println("对不起,收藏失败");
       }
     }
     else if ("restore_afterlogin".equals(type))
     {
       String flowerid = (String)request.getSession().getAttribute("restoreflowerid");
 
       FlowerBean flower = flowerService.getFlowerById(Integer.parseInt(flowerid));
 
       RestoreFlower restoreFlower = flowerService.getRestoreFlowerInfoById(flowerid);
       if (flowerService.getRestoreFlowerInfo(flowerid, ""+user.getUserid())) {
         out.println("<script type='text/javascript' language='javascript'>");
         out.println("window.alert('您已经收藏过该花卉!')");
 
         out.println("window.open('/FlowerShop/index.jsp','_self')");
         out.println("</script>");
       }
       else if (flowerService.restoreFlower(flower, user)) {
         out.println("<script type='text/javascript' language='javascript'>");
         out.println("window.alert('恭喜您,收藏成功!')");
 
         out.println("window.open('/FlowerShop/index.jsp','_self')");
         out.println("</script>");
       }
       else {
         out.println("<script type='text/javascript' language='javascript'>");
         out.println("window.alert('对不起，收藏失败!')");
 
         out.println("window.open('/FlowerShop/index.jsp','_self')");
         out.println("</script>");
       }
     }
     else if ("goshowmyrestore".equals(type))
     {
       String pageNow = request.getParameter("pageNow");
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/user/showRestoreFlower.jsp").forward(request, response);
     }
     else if ("del".equals(type))
     {
       String flowerid = request.getParameter("flowerid");
 
       if (flowerService.delRestoreFlower(flowerid, ""+user.getUserid()))
       {
         out.println("恭喜您，删除成功!");
       }
       else out.println("对不起，删除失败");
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
