 package com.gcj.controller;
 
 import com.gcj.domain.UserMessage;
 import com.gcj.domain.Users;
 import com.gcj.service.UserMessageService;
 import java.io.IOException;
 import java.io.PrintWriter;
 import java.util.ArrayList;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;
 
 public class UserMessageCl extends HttpServlet
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
     UserMessageService userMessageService = new UserMessageService();
     if ("aftersearch".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/user/userMessage.jsp").forward(request, response);
     } else if ("tj".equals(type))
     {
       String title = request.getParameter("title");
       String content = request.getParameter("content");
 
       UserMessage userMessage = new UserMessage();
       userMessage.setTitle(title);
       userMessage.setContent(content);
       userMessage.setIschecked("否");
       userMessage.setUsername(user.getUsername());
 
       if (userMessageService.insertMessage(userMessage))
         out.println("恭喜您，留言成功!我们会及时查看您的留言，谢谢");
       else
         out.println("对不起，留言失败!");
     }
     else if ("showmessage".equals(type))
     {
       String messageid = request.getParameter("no");
 
       UserMessage userMessage = userMessageService.getUserMessageById(messageid);
       ArrayList messageal = userMessageService.getOtherMessage(messageid);
       request.setAttribute("usermessage", userMessage);
       request.setAttribute("messageal", messageal);
       request.getRequestDispatcher("/WEB-INF/user/showUserMessage.jsp").forward(request, response);
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
