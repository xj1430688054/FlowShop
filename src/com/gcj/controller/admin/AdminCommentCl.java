 package com.gcj.controller.admin;
 
 import com.gcj.domain.Comment;
 import com.gcj.service.CommentService;
 import java.io.IOException;
 import java.io.PrintStream;
 import java.io.PrintWriter;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 
 public class AdminCommentCl extends HttpServlet
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
     CommentService commentService = new CommentService();
 
     if ("showcomment".equals(type))
     {
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=comment");
     } else if ("zhuijia".equals(type))
     {
       String orderid = request.getParameter("orderid");
       String flowerid = request.getParameter("flowerid");
       System.out.println("订单编号=" + orderid);
       System.out.println("花卉编号=" + flowerid);
 
       Comment comment = commentService.getCommentByOrderFlowerid(orderid, flowerid);
       request.setAttribute("comment", comment);
 
       request.getRequestDispatcher("/WEB-INF/admin/updateComment.jsp").forward(request, response);
     } else if ("upd".equals(type))
     {
       String orderid = request.getParameter("orderid");
       String flowerid = request.getParameter("flowerid");
       String content = request.getParameter("content");
       System.out.println("接收到的订单编号=" + orderid);
       System.out.println("接收到的花卉编号=" + flowerid);
       System.out.println("接收到的评论内容=" + content);
 
       if (commentService.updComment(content, orderid, flowerid))
         out.println("恭喜您，追加评论成功!");
       else
         out.println("对不起，追加评论失败!");
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