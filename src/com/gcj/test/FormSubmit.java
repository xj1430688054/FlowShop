 package com.gcj.test;
 
 import java.io.IOException;
 import java.io.PrintWriter;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 
 public class FormSubmit extends HttpServlet
 {
   public void doGet(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html;charset=utf-8");
     response.setCharacterEncoding("utf-8");
     response.setHeader("content-type", "text/html;charset=utf-8");
     request.setCharacterEncoding("utf-8");
     PrintWriter out = response.getWriter();
     out.println("<form action='/FlowerShop/UploadFile' method='post' enctype='multipart/form-data'>");
     out.println("请选择花卉缩略图:<input type='file' name='picture'/><br/>");
 
     out.println("注意:图片大小不要超过200k<br>");
     out.println("<input type='submit' value='提交'/>");
 
     out.println("</form>");
   }
 
   public void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html");
     PrintWriter out = response.getWriter();
     doGet(request, response);
   }
 }
