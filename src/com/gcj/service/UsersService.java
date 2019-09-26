 package com.gcj.service;
 
 import com.gcj.domain.Users;
 import com.gcj.utils.SqlHelper;
 import java.sql.Connection;
 import java.sql.PreparedStatement;
 import java.sql.ResultSet;
 import java.sql.SQLException;
 
 public class UsersService
 {
   private ResultSet rs = null;
   private Connection ct = null;
   private PreparedStatement ps = null;
 
   public boolean checkUser(String u, String p)
   {
     boolean b = false;
     String sql = "select * from users where username=? and passwd=?";
     String[] parameters = { u, p };
     ResultSet rs = SqlHelper.executeQuery(sql, parameters);
     try {
       if (rs.next())
         b = true;
     }
     catch (SQLException e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return b;
   }
 
   public Users getUsersByName(String u) {
     Users user = new Users();
 
     String sql = "select * from users where username=?";
     String[] parameters = { u };
     ResultSet rs = SqlHelper.executeQuery(sql, parameters);
     try
     {
       if (rs.next())
       {
         user.setUserid(rs.getInt(1));
         user.setUsername(rs.getString(2));
         user.setTruename(rs.getString(3));
         user.setSex(rs.getString(4));
         user.setPasswd(rs.getString(5));
         user.setEmail(rs.getString(6));
         user.setPhone(rs.getString(7));
         user.setAddress(rs.getString(8));
         user.setPostcode(rs.getString(9));
         user.setGrade(rs.getInt(10));
         user.setScore(rs.getInt(11));
       }
     }
     catch (SQLException e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return user;
   }
 
   public Users getUsersById(String id)
   {
     Users user = new Users();
 
     String sql = "select * from users where userid=?";
     String[] parameters = { id };
     ResultSet rs = SqlHelper.executeQuery(sql, parameters);
     try
     {
       if (rs.next())
       {
         user.setUserid(rs.getInt(1));
         user.setUsername(rs.getString(2));
         user.setTruename(rs.getString(3));
         user.setSex(rs.getString(4));
         user.setPasswd(rs.getString(5));
         user.setEmail(rs.getString(6));
         user.setPhone(rs.getString(7));
         user.setAddress(rs.getString(8));
         user.setPostcode(rs.getString(9));
         user.setGrade(rs.getInt(10));
         user.setScore(rs.getInt(11));
       }
     }
     catch (SQLException e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return user;
   }
 
   public boolean updUsers(Users user)
   {
     boolean b = true;
     try
     {
       String sql = "update users set username=? ,truename=?,sex=?,passwd=?,email=?,phone=?,address=?,postcode=?,grade=?,score=? where userid=? ";
       String[] parameters = { user.getUsername(), user.getTruename(), user.getSex(), user.getPasswd(), user.getEmail(), user.getPhone(), user.getAddress(), user.getPostcode(), ""+user.getGrade(), ""+user.getScore(), ""+user.getUserid() };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public boolean insertUser(Users user)
   {
     boolean b = true;
     try
     {
       String sql = "insert into users(username,truename,sex,passwd,email,phone,address,postcode) values(?,?,?,?,?,?,?,?)";
       String[] parameters = { user.getUsername(), user.getTruename(), user.getSex(), user.getPasswd(), user.getEmail(), user.getPhone(), user.getAddress(), user.getPostcode() };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return b;
   }
 
   public boolean updUsers1(Users user)
   {
     boolean b = true;
     try
     {
       String sql = "update users set truename=?,sex=?,email=?,phone=?,address=?,postcode=? where userid=? ";
       String[] parameters = { user.getTruename(), user.getSex(), user.getEmail(), user.getPhone(), user.getAddress(), user.getPostcode(), ""+user.getUserid() };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public boolean updUsers2(Users user)
   {
     boolean b = true;
     try
     {
       String sql = "update users set username=? ,truename=?,sex=?,email=?,phone=?,address=?,postcode=? where userid=? ";
       String[] parameters = { user.getUsername(), user.getTruename(), user.getSex(), user.getEmail(), user.getPhone(), user.getAddress(), user.getPostcode(), ""+user.getUserid() };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public boolean updUserPwd(Users user)
   {
     boolean b = true;
     try
     {
       String sql = "update users set passwd=? where userid=? ";
       String[] parameters = { user.getPasswd(), ""+user.getUserid() };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 }