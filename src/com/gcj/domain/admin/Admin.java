 package com.gcj.domain.admin;
 
 public class Admin
 {
   private int id;
   private String name;
   private String passwd;
   private String grade;
 
   public String getName()
   {
     return this.name;
   }
   public void setName(String name) {
     this.name = name;
   }
   public String getPasswd() {
     return this.passwd;
   }
   public void setPasswd(String passwd) {
     this.passwd = passwd;
   }
   public int getId() {
     return this.id;
   }
   public void setId(int id) {
     this.id = id;
   }
   public String getGrade() {
     return this.grade;
   }
   public void setGrade(String grade) {
     this.grade = grade;
   }
 } 