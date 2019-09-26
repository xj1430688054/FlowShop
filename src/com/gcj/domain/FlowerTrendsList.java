 package com.gcj.domain;
 
 import java.sql.Timestamp;
 
 public class FlowerTrendsList
 {
   private int id;
   private String title;
   private String content;
   private Timestamp newstime;
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
   public Timestamp getNewstime() {
     return this.newstime;
   }
   public void setNewstime(Timestamp newstime) {
     this.newstime = newstime;
   }
   public int getReadtimes() {
     return this.readtimes;
   }
   public void setReadtimes(int readtimes) {
     this.readtimes = readtimes;
   }
 } 