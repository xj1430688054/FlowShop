 package com.gcj.domain;
 
 import java.sql.Date;
 
 public class UserMessage
 {
   private int id;
   private String username;
   private Date messagetime;
   private String title;
   private String content;
   private String ischecked;
 
   public int getId()
   {
     return this.id;
   }
   public void setId(int id) {
     this.id = id;
   }
   public String getUsername() {
     return this.username;
   }
   public void setUsername(String username) {
     this.username = username;
   }
   public Date getMessagetime() {
     return this.messagetime;
   }
   public void setMessagetime(Date messagetime) {
     this.messagetime = messagetime;
   }
   public String getTitle() {
     return this.title;
   }
   public void setTitle(String title) {
     this.title = title;
   }
   public String getContent() {
     return this.content;
   }
   public void setContent(String content) {
     this.content = content;
   }
   public String getIschecked() {
     return this.ischecked;
   }
   public void setIschecked(String ischecked) {
     this.ischecked = ischecked;
   }
 }
 