 package com.gcj.utils;
 
 import java.awt.Color;
 import java.awt.Font;
 import java.awt.Graphics;
 import java.awt.image.BufferedImage;
 import java.io.IOException;
 import java.io.PrintWriter;
 import java.util.Random;
 import javax.imageio.ImageIO;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;
 
 public class CreateCode extends HttpServlet
 {
   public void doGet(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setDateHeader("Expires", -1L);
     response.setHeader("Cache-Control", "no-cache");
     response.setHeader("Pragma", "no-cache");
 
     response.setHeader("Content-Type", "image/jpeg");
 
     BufferedImage image = new BufferedImage(60, 30, 1);
 
     Graphics g = image.getGraphics();
 
     g.setColor(Color.blue);
     g.fillRect(0, 0, 60, 30);
 
     g.setColor(Color.WHITE);
     g.setFont(new Font(null, 1, 20));
 
     String num = makeNum();
 
     request.getSession().setAttribute("checkcode", num);
     g.drawString(num, 0, 20);
 
     ImageIO.write(image, "jpg", response.getOutputStream());
   }
 
   public String makeNum()
   {
     Random r = new Random();
     String num = ""+r.nextInt(9999);
     StringBuffer sb = new StringBuffer();
     for (int i = 0; i < 4 - num.length(); i++) {
       sb.append("0");
     }
     num = sb.toString() + num;
     return num;
   }
 
   public void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     response.setContentType("text/html");
     PrintWriter out = response.getWriter();
     doGet(request, response);
   }
 }
