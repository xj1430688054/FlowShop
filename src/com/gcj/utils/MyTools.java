 package com.gcj.utils;
 
 public class MyTools
 {
   public static String getNewString(String str)
   {
     String newstring = "";
     try {
       newstring = new String(str.getBytes("iso8859-1"), "utf-8");
     } catch (Exception e) {
       e.printStackTrace();
     }
 
     return newstring;
   }
 }
