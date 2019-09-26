 package com.gcj.controller;
 
 import com.gcj.domain.FlowerKnowledge;
 import com.gcj.service.FlowerKnowledgeService;
 import java.io.IOException;
 import java.io.PrintWriter;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 
 public class ShowFlowerKnowledgeCl extends HttpServlet
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
     FlowerKnowledgeService flowerKnowledgeService = new FlowerKnowledgeService();
 
     if ("showflowerknowledge".equals(type))
     {
       String pageNow = request.getParameter("pageNow");
 
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/user/showFlowerKnowledge.jsp").forward(request, response);
     }
     else if ("nr".equals(type))
     {
       String id = request.getParameter("no");
 
       FlowerKnowledge flowerKnowledge = flowerKnowledgeService.getFlowerKnowledgeById(id);
 
       FlowerKnowledge flowerKnowledge_before = flowerKnowledgeService.getBeforeFlowerKnowledgeById(id);
 
       FlowerKnowledge flowerKnowledge_next = flowerKnowledgeService.getNextFlowerKnowledgeById(id);
 
       request.setAttribute("knowledges", flowerKnowledge);
       request.setAttribute("knowledge_before", flowerKnowledge_before);
       request.setAttribute("knowledge_next", flowerKnowledge_next);
       request.getRequestDispatcher("/WEB-INF/user/showSingleFlowerKnowledge.jsp").forward(request, response);
     }
     else if ("addtimes".equals(type))
     {
       String newsid = request.getParameter("id");
 
       if (flowerKnowledgeService.addReadTimes(newsid))
       {
         out.println("恭喜您，修改成功");
       }
       else out.println("对不起，修改失败");
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
 