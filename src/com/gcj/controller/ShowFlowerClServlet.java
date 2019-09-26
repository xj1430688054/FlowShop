 package com.gcj.controller;
 
 import com.gcj.domain.FlowerBean;
 import com.gcj.domain.FlowerInfo;
 import com.gcj.domain.FlowerIntro;
 import com.gcj.service.CommentService;
 import com.gcj.service.FlowerService;
 import com.gcj.service.OrderItemService;
 import java.io.IOException;
 import java.io.PrintStream;
 import java.io.PrintWriter;
 import java.util.ArrayList;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 
 public class ShowFlowerClServlet extends HttpServlet
 {
   String lowprice = "";
   String highprice = "";
 
   public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
     response.setContentType("text/html;charset=utf-8");
     response.setCharacterEncoding("utf-8");
     request.setCharacterEncoding("utf-8");
     response.setHeader("content-type", "text/html;charset=utf-8");
     PrintWriter out = response.getWriter();
 
     String type = request.getParameter("type");
 
     CommentService commentService = new CommentService();
     OrderItemService orderItemService = new OrderItemService();
 
     if ("showDetail".equals(type))
     {
       String id = request.getParameter("id");
 
       FlowerService flowerService = new FlowerService();
 
       FlowerBean flowerBean = flowerService.getFlowerById(Integer.parseInt(id));
 
       FlowerInfo flowerInfo = flowerService.getFlowerInfoById(id);
 
       ArrayList al = flowerService.getSimilarFlower(flowerBean);
 
       ArrayList commental = commentService.getAllFlowerCommentById(id);
 
       int flowernum = orderItemService.getTradeOkFlowerById(id);
 
       FlowerIntro flowerIntro = flowerService.getFlowerIntroByType(flowerBean);
 
       request.setAttribute("flowerinfo", flowerBean);
       request.setAttribute("flower_info", flowerInfo);
       request.setAttribute("similar_flower", al);
       request.setAttribute("commental", commental);
       request.setAttribute("flowernum", Integer.valueOf(flowernum));
       request.setAttribute("flowerintro", flowerIntro);
       request.getRequestDispatcher("/WEB-INF/user/showDetail.jsp").forward(request, response);
     } else if ("fenye".equals(type))
     {
       String pageNow = request.getParameter("pageNow");
 
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/user/index.jsp").forward(request, response);
     } else if ("selectflower".equals(type))
     {
       String keyword = request.getParameter("key");
       String flowertype = request.getParameter("ftype");
 
       System.out.println("关键字=" + keyword);
       System.out.println("花卉类型=" + flowertype);
 
       FlowerService flowerService = new FlowerService();
       ArrayList keywordal = flowerService.getKeyWordFlower(keyword, flowertype);
 
       ArrayList samefloweral = flowerService.getSameTypeFlower(flowertype);
 
       request.setAttribute("keywordal", keywordal);
       request.setAttribute("samefloweral", samefloweral);
       request.getRequestDispatcher("/WEB-INF/user/searchFlower.jsp").forward(request, response);
     } else if ("bh".equals(type))
     {
       response.sendRedirect("/FlowerShop/ShowFlowerClServlet?type=goshowflower&flowertype=bh");
     }
     else if ("goshowflower".equals(type)) {
       String flowertype = request.getParameter("flowertype");
       response.sendRedirect("/FlowerShop/ShowFlowerClServlet?type=showflowerbytype&flowertype=" + flowertype);
     } else if ("showflowerbytype".equals(type)) {
       String flowertype = request.getParameter("flowertype");
       String realflowertype = null;
       if ("bh".equals(flowertype))
         realflowertype = "百合";
       else if ("rs".equals(flowertype))
         realflowertype = "玫瑰";
       else if ("lh".equals(flowertype))
         realflowertype = "兰花";
       else if ("fzj".equals(flowertype))
         realflowertype = "非洲菊";
       else if ("knx".equals(flowertype)) {
         realflowertype = "康乃馨";
       }
 
       String ftype = null;
       if (realflowertype != null)
         ftype = realflowertype;
       else {
         ftype = request.getParameter("ftype");
       }
       System.out.println("真的花卉类型=" + realflowertype);
       System.out.println("接收到的花卉类型=" + flowertype);
 
       String pageNow = request.getParameter("pageNow");
       request.setAttribute("realflowertype", ftype);
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/user/showEachTypeFlower.jsp").forward(request, response);
     } else if ("rs".equals(type))
     {
       response.sendRedirect("/FlowerShop/ShowFlowerClServlet?type=goshowflower&flowertype=rs");
     }
     else if ("lh".equals(type))
     {
       response.sendRedirect("/FlowerShop/ShowFlowerClServlet?type=goshowflower&flowertype=lh");
     }
     else if ("fzj".equals(type))
     {
       response.sendRedirect("/FlowerShop/ShowFlowerClServlet?type=goshowflower&flowertype=fzj");
     }
     else if ("knx".equals(type))
     {
       response.sendRedirect("/FlowerShop/ShowFlowerClServlet?type=goshowflower&flowertype=knx");
     }
     else if ("searchflower".equals(type))
     {
       String Lowprice = request.getParameter("lowprice");
       String Highprice = request.getParameter("highprice");
 
       if ((Lowprice != null) && (Highprice != null)) {
         this.lowprice = Lowprice;
         this.highprice = Highprice;
       }
 
       System.out.println("最低价=" + this.lowprice + "最高价=" + this.highprice);
 
       request.setAttribute("low", this.lowprice);
       request.setAttribute("high", this.highprice);
       String pageNow = request.getParameter("pageNow");
       request.setAttribute("pageNow", pageNow);
       request.getRequestDispatcher("/WEB-INF/user/ShowFlowerByPrice.jsp").forward(request, response);
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
 