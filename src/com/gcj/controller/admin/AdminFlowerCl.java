 package com.gcj.controller.admin;
 
 import com.gcj.domain.FlowerBean;
 import com.gcj.domain.FlowerInfo;
 import com.gcj.domain.FlowerKnowledge;
 import com.gcj.domain.FlowerTrendsList;
 import com.gcj.service.FlowerKnowledgeService;
 import com.gcj.service.FlowerService;
 import com.gcj.service.FlowerTrendsService;
 import com.gcj.service.OrderItemService;
 import com.gcj.service.admin.AdminService;
 import java.io.IOException;
 import java.io.PrintStream;
 import java.io.PrintWriter;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;
 
 public class AdminFlowerCl extends HttpServlet
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
     FlowerService flowerService = new FlowerService();
     AdminService adminService = new AdminService();
     OrderItemService orderItemService = new OrderItemService();
 
     FlowerTrendsService flowerTrendsService = new FlowerTrendsService();
     FlowerKnowledgeService flowerKnowledgeService = new FlowerKnowledgeService();
     if ("manage".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/admin/index.jsp").forward(request, response);
     } else if ("showAllFlower".equals(type))
     {
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=flowers");
     } else if ("flowerDetail".equals(type))
     {
       String flowerid = request.getParameter("id");
 
       FlowerBean flower = flowerService.getFlowerById(Integer.parseInt(flowerid));
       request.setAttribute("flowerdetail", flower);
       request.getRequestDispatcher("/WEB-INF/admin/flowerDetail.jsp").forward(request, response);
     } else if ("selectflower".equals(type))
     {
       String flowername = request.getParameter("flowername");
 
       FlowerBean flowerBean = flowerService.getFlowerByName(flowername);
       request.setAttribute("selectFlower", flowerBean);
       request.getRequestDispatcher("/WEB-INF/admin/showSelectFlower.jsp").forward(request, response);
     } else if ("gotoupdview".equals(type))
     {
       String flowerid = request.getParameter("id");
 
       FlowerBean flower = flowerService.getFlowerById(Integer.parseInt(flowerid));
       request.setAttribute("flower_info", flower);
 
       request.getRequestDispatcher("/WEB-INF/admin/updateFlowerInfo.jsp").forward(request, response);
     } else if ("updflower".equals(type))
     {
       System.out.println("运行到这里了=======");
       String price = request.getParameter("price");
       String marketprice = request.getParameter("marketprice");
       String nums = request.getParameter("nums");
       String startsale = request.getParameter("startsale");
       String field = request.getParameter("field");
       String intro = request.getParameter("intro");
       String id = request.getParameter("id");
 
       FlowerBean flower = flowerService.getFlowerById(Integer.parseInt(id));
 
       flower.setFlowerprice(Double.parseDouble(price));
       flower.setMarketprice(Double.parseDouble(marketprice));
       flower.setFlowernum(Integer.parseInt(nums));
       flower.setStartsale(Integer.parseInt(startsale));
       flower.setFlowerfield(field);
       flower.setFlowerintro(intro);
 
       if (flowerService.updFlower(flower))
         out.println("恭喜您，修改成功");
       else
         out.println("对不起，修改失败");
     }
     else if ("updphoto".equals(type))
     {
       String message = (String)request.getSession().getAttribute("message");
       String filename = (String)request.getSession().getAttribute("filename");
       String flowerid = request.getParameter("no");
       System.out.println("message=" + message);
       System.out.println("图片名=" + filename);
       System.out.println("编号=" + flowerid);
 
       request.getSession().removeAttribute("message");
       request.getSession().removeAttribute("filename");
 
       request.setAttribute("message", message);
 
       FlowerBean flower = flowerService.getFlowerById(Integer.parseInt(flowerid));
 
       flowerService.updFlowerPhoto(filename, flowerid);
 
       request.setAttribute("flower_info", flower);
       request.getRequestDispatcher("/WEB-INF/admin/updateFlowerInfo.jsp").forward(request, response);
     }
     else if ("goinsertflowerview".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/admin/AddFlower.jsp").forward(request, response);
     } else if ("addflower".equals(type))
     {
       String price = request.getParameter("price");
       String marketprice = request.getParameter("marketprice");
       String nums = request.getParameter("nums");
       String startsale = request.getParameter("startsale");
       String field = request.getParameter("field");
       String intro = request.getParameter("intro");
       String flowername = request.getParameter("flowername");
       String unit = request.getParameter("unit");
       String flowertype = request.getParameter("flowertype");
 
       FlowerBean flower = new FlowerBean();
       flower.setFlowername(flowername);
       flower.setFlowerprice(Double.parseDouble(price));
       flower.setMarketprice(Double.parseDouble(marketprice));
       flower.setFlowernum(Integer.parseInt(nums));
       flower.setStartsale(Integer.parseInt(startsale));
       flower.setFlowerfield(field);
       flower.setFlowerintro(intro);
       flower.setFlowerunit(unit);
       flower.setFlowertype(flowertype);
       flower.setPhoto("nopic.jpg");
       if (flowerService.insertFlower(flower))
       {
         out.println("恭喜，添加成功");
       }
       else
         out.println("对不起，添加失败");
     }
     else if ("reservedflower".equals(type))
     {
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=reservedflowers");
     }
     else if ("getallsameflower".equals(type))
     {
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=getallsameflower");
     } else if ("ok".equals(type))
     {
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=okflowers");
     } else if ("flowerinfo".equals(type))
     {
       String flowerid = request.getParameter("no");
 
       FlowerBean flower = flowerService.getFlowerById(Integer.parseInt(flowerid));
 
       FlowerInfo flowerInfo = flowerService.getFlowerInfoById(flowerid);
       if (flowerInfo.getType() == null)
       {
         String info = "附加信息暂无,等待添加";
         request.setAttribute("info", info);
       }
       request.setAttribute("flower_info", flower);
       request.setAttribute("flowerinfo", flowerInfo);
       request.getRequestDispatcher("/WEB-INF/admin/showExtraFlowerInfo.jsp").forward(request, response);
     } else if ("extrainfo".equals(type))
     {
       String flowertype = request.getParameter("flowertype");
       String grade = request.getParameter("grade");
       String color = request.getParameter("color");
       String useway = request.getParameter("useway");
       String spe = request.getParameter("spe");
       String fes = request.getParameter("fes");
       String id = request.getParameter("id");
 
       FlowerInfo flowerInfo = new FlowerInfo();
       flowerInfo.setId(Integer.parseInt(id));
       flowerInfo.setType(flowertype);
       flowerInfo.setGrade(grade);
       flowerInfo.setColor(color);
       flowerInfo.setUseway(useway);
       flowerInfo.setSpecification(spe);
       flowerInfo.setUsefestival(fes);
 
       if (flowerService.insertFlowerInfo(flowerInfo))
         out.println("恭喜您，添加成功");
       else {
         out.println("对不起，添加失败");
       }
     }
     else if ("updextrainfo".equals(type))
     {
       String flowertype = request.getParameter("flowertype");
       String grade = request.getParameter("grade");
       String color = request.getParameter("color");
       String useway = request.getParameter("useway");
       String spe = request.getParameter("spe");
       String fes = request.getParameter("fes");
       String id = request.getParameter("id");
 
       FlowerInfo flowerInfo = new FlowerInfo();
       flowerInfo.setId(Integer.parseInt(id));
       flowerInfo.setType(flowertype);
       flowerInfo.setGrade(grade);
       flowerInfo.setColor(color);
       flowerInfo.setUseway(useway);
       flowerInfo.setSpecification(spe);
       flowerInfo.setUsefestival(fes);
 
       if (flowerService.updateFlowerInfo(flowerInfo))
         out.println("恭喜您，修改成功");
       else {
         out.println("对不起，修改失败");
       }
     }
     else if ("del".equals(type))
     {
       String flowerid = request.getParameter("flowerid");
       if (flowerService.delFlower(flowerid))
       {
         out.println("恭喜您，删除成功");
       }
       else out.println("对不起，删除失败");
     }
     else if ("showFlowerTrends".equals(type))
     {
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=flowertrends");
     } else if ("delflowernews".equals(type))
     {
       String id = request.getParameter("no");
 
       if (flowerTrendsService.delFlowerTrendsById(id))
         out.println("恭喜您，删除成功");
       else
         out.println("对不起，删除失败");
     }
     else if ("selectflowernews".equals(type))
     {
       String id = request.getParameter("no");
 
       FlowerTrendsList flowerTrendsList = flowerTrendsService.getFlowerTrendsListById(id);
       request.setAttribute("trends", flowerTrendsList);
       request.getRequestDispatcher("/WEB-INF/admin/showSelectFlowerNews.jsp").forward(request, response);
     } else if ("addnews".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/admin/addFlowerNews.jsp").forward(request, response);
     } else if ("tj".equals(type))
     {
       String title = request.getParameter("title");
       String content = request.getParameter("content");
       System.out.println(title);
       System.out.println(content);
 
       if (flowerTrendsService.insertFlowerNewsList(title, content))
         out.println("恭喜您，添加成功");
       else
         out.println("对不起，添加失败");
     }
     else if ("showFlowerKnowledge".equals(type))
     {
       response.sendRedirect("/FlowerShop/AdminFenyeCl?type=flowerknowledge");
     } else if ("delflowerknowledge".equals(type))
     {
       String id = request.getParameter("no");
 
       if (flowerKnowledgeService.delFlowerKnowledgeById(id))
         out.println("恭喜您，删除成功");
       else
         out.println("对不起，删除失败");
     }
     else if ("selectflowerknowledge".equals(type))
     {
       String id = request.getParameter("no");
 
       FlowerKnowledge flowerKnowledge = flowerKnowledgeService.getFlowerKnowledgeById(id);
       request.setAttribute("knowledges", flowerKnowledge);
       request.getRequestDispatcher("/WEB-INF/admin/showSelectFlowerKnowledge.jsp").forward(request, response);
     } else if ("addKnowledge".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/admin/addFlowerKnowledge.jsp").forward(request, response);
     } else if ("tjknow".equals(type))
     {
       String title = request.getParameter("title");
       String content = request.getParameter("content");
       System.out.println(title);
       System.out.println(content);
 
       if (flowerKnowledgeService.insertFlowerKnowledge(title, content))
         out.println("恭喜您，添加成功");
       else
         out.println("对不起，添加失败");
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