 package com.gcj.controller.admin;
 
 import com.gcj.domain.UserMessage;
 import com.gcj.service.UserMessageService;
 import java.io.IOException;
 import java.io.PrintStream;
 import java.io.PrintWriter;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 
 public class AdminMessageCl extends HttpServlet
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
     UserMessageService userMessageService = new UserMessageService();
 
     if ("message".equals(type))
     {
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=message");
     } else if ("upd".equals(type))
     {
       String messageid = request.getParameter("no");
       System.out.println("留言编号=" + messageid);
 
       if (userMessageService.updMessage(messageid))
         out.println("恭喜您，审核成功");
       else
         out.println("对不起，审核失败");
     }
     else if ("selectmessage".equals(type))
     {
       String messageid = request.getParameter("no");
       System.out.println("要查询的留言=" + messageid);
 
       UserMessage userMessage = userMessageService.getUserMessageById(messageid);
 
       request.setAttribute("selectmessage", userMessage);
       request.getRequestDispatcher("/WEB-INF/admin/showSelectMessage.jsp").forward(request, response);
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