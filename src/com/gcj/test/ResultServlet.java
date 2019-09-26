package com.gcj.test;
 
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
 public class ResultServlet extends HttpServlet
 {
   public void doGet(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html;charset=utf-8");
     request.setCharacterEncoding("utf-8");
     response.setCharacterEncoding("utf-8");
     PrintWriter out = response.getWriter();
 
     String message = (String)request.getAttribute("message");
     String filename = (String)request.getAttribute("filename");
     out.println("filename=" + filename);
     out.println("<img src='images/" + filename + "'>");
     out.println("<br/>message=" + message);
   }
 
   public void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html");
     PrintWriter out = response.getWriter();
     doGet(request, response);
   }
}
