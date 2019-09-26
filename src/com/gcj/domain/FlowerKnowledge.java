 package com.gcj.domain;
 
 import java.sql.Timestamp;
 
 public class FlowerKnowledge
 {
   private int id;
   private String title;
   private String content;
   private Timestamp publishtime;
   private int readtimes;
 
   public int getId()
   {
     return this.id;
   }
   public void setId(int id) {
     this.id = id;
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
   public Timestamp getPublishtime() {
     return this.publishtime;
   }
   public void setPublishtime(Timestamp publishtime) {
     this.publishtime = publishtime;
   }
   public int getReadtimes() {
     return this.readtimes;
   }
   public void setReadtimes(int readtimes) {
     this.readtimes = readtimes;
   }
 } 