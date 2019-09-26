 package com.gcj.controller;
 
 import com.gcj.domain.FlowerTrendsList;
 import com.gcj.service.FlowerTrendsService;
 import java.io.IOException;
 import java.io.PrintWriter;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 
 public class ShowFlowerTrendsCl extends HttpServlet
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
     FlowerTrendsService flowerTrendsService = new FlowerTrendsService();
 
     if ("showflowernews".equals(type))
     {
       String pageNow = request.getParameter("pageNow");
 
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/user/showFlowerTrends.jsp").forward(request, response);
     }
     else if ("nr".equals(type))
     {
       String id = request.getParameter("no");
 
       FlowerTrendsList flowerTrendsList = flowerTrendsService.getFlowerTrendsListById(id);
 
       FlowerTrendsList flowerTrendsList_before = flowerTrendsService.getBeforeFlowerTrendsListById(id);
 
       FlowerTrendsList flowerTrendsList_next = flowerTrendsService.getNextFlowerTrendsListById(id);
 
       request.setAttribute("trends", flowerTrendsList);
       request.setAttribute("trends_before", flowerTrendsList_before);
       request.setAttribute("trends_next", flowerTrendsList_next);
       request.getRequestDispatcher("/WEB-INF/user/showSingleFlowerTrends.jsp").forward(request, response);
     }
     else if ("addtimes".equals(type))
     {
       String newsid = request.getParameter("id");
 
       if (flowerTrendsService.addReadTimes(newsid))
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
 