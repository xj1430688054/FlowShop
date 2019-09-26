 package com.gcj.test;
 
 import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
 
 public class UploadFile extends HttpServlet
 {
   public void doGet(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html;charset=utf-8");
     response.setCharacterEncoding("utf-8");
     response.setHeader("content-type", "text/html;charset=utf-8");
     request.setCharacterEncoding("utf-8");
     PrintWriter out = response.getWriter();
 
     String message = "";
     int maxSize = 204800;
     DiskFileItemFactory factory = new DiskFileItemFactory();
     ServletFileUpload upload = new ServletFileUpload(factory);
     try
     {
       List items = upload.parseRequest(request);
       Iterator itr = items.iterator();
       while (itr.hasNext()) {
         FileItem item = (FileItem)itr.next();
         if (!item.isFormField()) {
           if ((item.getName() != null) && (!item.getName().equals(""))) {
             long upFileSize = item.getSize();
             String fileName = item.getName();
             if (upFileSize > maxSize) {
               message = "您上传的文件太大，请选择不超过200k的文件";
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
     request.setAttribute("message", message);
     request.getRequestDispatcher("/ResultServlet").forward(request, response);
   }
 
   public void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html");
     PrintWriter out = response.getWriter();
     doGet(request, response);
   }
 }
