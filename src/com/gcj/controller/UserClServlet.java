 package com.gcj.controller;
 
 import com.gcj.domain.Users;
 import com.gcj.service.MyCart;
 import com.gcj.service.UsersService;
 import java.io.IOException;
 import java.io.PrintStream;
 import java.io.PrintWriter;
 import javax.servlet.RequestDispatcher;
 import javax.servlet.ServletException;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;
 
 public class UserClServlet extends HttpServlet
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
     UsersService usersService = new UsersService();
     if ("logout".equals(type))
     {
       Users user = (Users)request.getSession().getAttribute("loginuser");
       if (user != null)
       {
         request.getSession().invalidate();
         request.getRequestDispatcher("/WEB-INF/user/logout.jsp").forward(request, response);
       }
       else {
         out.println("<script type='text/javascript' language='javascript'>");
         out.println("function show(){window.alert('您还没有登录，请先登录!')}");
         out.println("</script>");
         response.sendRedirect("/FlowerShop/index.jsp");
       }
     } else if ("myaccount".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/user/showUserInfo.jsp").forward(request, response);
     } else if ("gotoUpdateView".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/user/updateUserInfo.jsp").forward(request, response);
     } else if ("update".equals(type))
     {
       String userid = request.getParameter("userid");
       String username = request.getParameter("username");
       String truename = request.getParameter("truename");
       String email = request.getParameter("email");
       String phone = request.getParameter("phone");
       String address = request.getParameter("address");
       String postcode = request.getParameter("postcode");
       String sex = request.getParameter("sex");
 
       Users user = usersService.getUsersById(userid);
 
       if (username.equals(user.getUsername()))
       {
         user.setTruename(truename);
         user.setEmail(email);
         user.setPhone(phone);
         user.setAddress(address);
         user.setPostcode(postcode);
         user.setSex(sex);
         if (usersService.updUsers1(user))
         {
           request.getSession().setAttribute("loginuser", user);
           out.println("恭喜您，修改成功");
         } else {
           out.println("对不起，修改失败");
         }
       }
       else {
         user.setUsername(username);
         user.setTruename(truename);
         user.setEmail(email);
         user.setPhone(phone);
         user.setAddress(address);
         user.setPostcode(postcode);
         user.setSex(sex);
         if (usersService.updUsers2(user))
         {
           request.getSession().setAttribute("loginuser", user);
           out.println("恭喜您，修改成功");
         } else {
           out.println("对不起，修改失败");
         }
       }
     } else if ("gotoUpdPwdView".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/user/updateUserPwd.jsp").forward(request, response);
     }
     else if ("getOldPwd".equals(type))
     {
       String userid = request.getParameter("userid");
       String passwd = request.getParameter("passwd");
 
       Users user = usersService.getUsersById(userid);
       if (passwd.equals(user.getPasswd()))
       {
         out.println("原密码输入正确");
       }
       else out.println("原密码输入不正确");
     }
     else if ("updatePwd".equals(type))
     {
       String userid = request.getParameter("userid");
       String newpasswd = request.getParameter("newpasswd");
       Users user = usersService.getUsersById(userid);
       user.setPasswd(newpasswd);
       if (usersService.updUserPwd(user))
       {
         request.getSession().setAttribute("loginuser", user);
         out.println("恭喜您，修改成功");
       } else {
         out.println("对不起，修改失败");
       }
     } else if ("gotoregisterview".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/user/userRegister.jsp").forward(request, response);
     }
     else if ("register".equals(type))
     {
       String username = request.getParameter("username");
       String truename = request.getParameter("truename");
       String email = request.getParameter("email");
       String phone = request.getParameter("phone");
       String address = request.getParameter("address");
       String postcode = request.getParameter("postcode");
       String sex = request.getParameter("sex");
       String passwd = request.getParameter("passwd");
 
       Users user = new Users();
       user.setUsername(username);
       user.setTruename(truename);
       user.setEmail(email);
       user.setPhone(phone);
       user.setAddress(address);
       user.setPostcode(postcode);
       user.setSex(sex);
       user.setPasswd(passwd);
 
       if (usersService.insertUser(user))
       {
         Users loginuser = usersService.getUsersByName(user.getUsername());
 
         request.getSession().setAttribute("loginuser", loginuser);
         MyCart myCart = new MyCart();
         request.getSession().setAttribute("myCart", myCart);
         out.println("恭喜您，注册成功");
       } else {
         out.println("对不起，注册失败");
       }
     } else if ("showcontact".equals(type))
     {
       request.getRequestDispatcher("/WEB-INF/user/showContactInfo.jsp").forward(request, response);
     } else if ("showcompany".equals(type))
     {
       System.out.println("将要前往显示经营概况");
       request.getRequestDispatcher("/WEB-INF/user/showCompany.jsp").forward(request, response);
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
 