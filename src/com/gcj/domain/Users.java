 package com.gcj.domain;
 
 public class Users
 {
   private int userid;
   private String username;
   private String truename;
   private String sex;
   private String passwd;
   private String email;
   private String phone;
   private String address;
   private String postcode;
   private int grade;
   private int score;
 
   public Users(int userid, String username, String truename, String sex, String passwd, String email, String phone, String address, String postcode, int grade, int score)
   {
     this.userid = userid;
     this.username = username;
     this.truename = truename;
     this.sex = sex;
     this.passwd = passwd;
     this.email = email;
     this.phone = phone;
     this.address = address;
     this.postcode = postcode;
     this.grade = grade;
     this.score = score;
   }
 
   public Users()
   {
   }
 
   public int getUserid()
   {
     return this.userid;
   }
   public void setUserid(int userid) {
     this.userid = userid;
   }
   public String getUsername() {
     return this.username;
   }
   public void setUsername(String username) {
     this.username = username;
   }
   public String getTruename() {
     return this.truename;
   }
   public void setTruename(String truename) {
     this.truename = truename;
   }
   public String getSex() {
     return this.sex;
   }
   public void setSex(String sex) {
     this.sex = sex;
   }
   public String getPasswd() {
     return this.passwd;
   }
   public void setPasswd(String passwd) {
     this.passwd = passwd;
   }
   public String getEmail() {
     return this.email;
   }
   public void setEmail(String email) {
     this.email = email;
   }
   public String getPhone() {
     return this.phone;
   }
   public void setPhone(String phone) {
     this.phone = phone;
   }
   public String getAddress() {
     return this.address;
   }
   public void setAddress(String address) {
     this.address = address;
   }
   public String getPostcode() {
     return this.postcode;
   }
   public void setPostcode(String postcode) {
     this.postcode = postcode;
   }
   public int getGrade() {
     return this.grade;
   }
   public void setGrade(int grade) {
     this.grade = grade;
   }
   public int getScore() {
     return this.score;
   }
   public void setScore(int score) {
     this.score = score;
   }
 }
 