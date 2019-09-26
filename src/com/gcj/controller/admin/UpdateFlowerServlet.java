 package com.gcj.controller.admin;
 
 import java.io.File;
 import java.io.IOException;
 import java.io.PrintStream;
 import java.io.PrintWriter;
 import java.util.Iterator;
 import java.util.List;
 import javax.servlet.ServletContext;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;
 import org.apache.commons.fileupload.FileItem;
 import org.apache.commons.fileupload.disk.DiskFileItemFactory;
 import org.apache.commons.fileupload.servlet.ServletFileUpload;
 
 public class UpdateFlowerServlet extends HttpServlet
 {
   public void doGet(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html;charset=utf-8");
     response.setCharacterEncoding("utf-8");
     request.setCharacterEncoding("utf-8");
     response.setHeader("content-type", "text/html;charset=utf-8");
     PrintWriter out = response.getWriter();
 
     String flowerid = request.getParameter("no");
 
     String message = "";
     int maxSize = 1048576;
     DiskFileItemFactory factory = new DiskFileItemFactory();
     ServletFileUpload upload = new ServletFileUpload(factory);
 
     String fileName = null;
     try {
       List items = upload.parseRequest(request);
       Iterator itr = items.iterator();
       while (itr.hasNext()) {
         FileItem item = (FileItem)itr.next();
         if (!item.isFormField()) {
           if ((item.getName() != null) && (!item.getName().equals(""))) {
             long upFileSize = item.getSize();
             fileName = item.getName();
             if (upFileSize > maxSize) {
               message = "您上传的文件太大，请选择不超过1M的文件";
               break;
             }
 
             File tempFile = new File(fileName);
 
             File file = new File(request.getSession().getServletContext().getRealPath("/images"), tempFile.getName());
             try
             {
               item.write(file);
 
               request.setAttribute("filename", fileName);
             } catch (Exception e) {
               e.printStackTrace();
               message = "上传文件出现错误:" + e.getMessage();
             }
           } else {
             message = "没有选择上传文件";
           }
         }
 
       }
 
     }
     catch (Exception e)
     {
       e.printStackTrace();
       message = "上传文件出现错误:" + e.getMessage();
     }
     if ("".equals(message)) {
       message = "上传文件成功";
     }
 
     System.out.println("选择的花卉是=" + fileName);
     System.out.println("id=" + flowerid);
     request.getSession().setAttribute("message", message);
     request.getSession().setAttribute("filename", fileName);
     response.sendRedirect("/FlowerShop/AdminFlowerCl?type=updphoto&no=" + flowerid);
   }
 
   public void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html");
     PrintWriter out = response.getWriter();
     doGet(request, response);
   }
 } 