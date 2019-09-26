 package com.gcj.domain;
 
 public class ExtraInfo
 {
   private String extrainfo;
   private String paymode;
   private String sendaddress;
   private String ispayed;
 
   public String getExtrainfo()
   {
     return this.extrainfo;
   }
   public void setExtrainfo(String extrainfo) {
     this.extrainfo = extrainfo;
   }
   public String getPaymode() {
     return this.paymode;
   }
   public void setPaymode(String paymode) {
     this.paymode = paymode;
   }
   public String getSendaddress() {
     return this.sendaddress;
   }
   public void setSendaddress(String sendaddress) {
     this.sendaddress = sendaddress;
   }
   public String getIspayed() {
     return this.ispayed;
   }
   public void setIspayed(String ispayed) {
     this.ispayed = ispayed;
   }
 }
 