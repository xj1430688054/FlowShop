 package com.gcj.service;
 
 import com.gcj.domain.FlowerKnowledge;
 import com.gcj.utils.SqlHelper;
 import java.sql.Connection;
 import java.sql.PreparedStatement;
 import java.sql.ResultSet;
 import java.sql.Statement;
 import java.util.ArrayList;
 
 public class FlowerKnowledgeService
 {
   private ResultSet rs = null;
   private Connection ct = null;
   private PreparedStatement ps = null;
   private Statement sm = null;
 
   public ArrayList getFlowerKnowledgeByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
 
       this.ps = this.ct.prepareStatement("select * from flowerknowledge order by publishtime desc limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         FlowerKnowledge flowerKnowledge = new FlowerKnowledge();
         flowerKnowledge.setId(this.rs.getInt(1));
         flowerKnowledge.setTitle(this.rs.getString(2));
         flowerKnowledge.setContent(this.rs.getString(3));
         flowerKnowledge.setPublishtime(this.rs.getTimestamp(4));
         flowerKnowledge.setReadtimes(this.rs.getInt(5));
         al.add(flowerKnowledge);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public int getFlowerKnowledgePageCount(int pageSize)
   {
     int pageCount = 0;
     int rowCount = 0;
     try {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select count(*) from flowerknowledge ");
 
       this.rs = this.ps.executeQuery();
       if (this.rs.next()) {
         rowCount = this.rs.getInt(1);
       }
       if (rowCount % pageSize == 0)
         pageCount = rowCount / pageSize;
       else
         pageCount = rowCount / pageSize + 1;
     }
     catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return pageCount;
   }
 
   public boolean addReadTimes(String id) {
     boolean b = true;
     try
     {
       String sql = "update flowerknowledge set readtimes=readtimes+1 where id=?";
       String[] parameters = { id };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public FlowerKnowledge getFlowerKnowledgeById(String id)
   {
     FlowerKnowledge flowerKnowledge = new FlowerKnowledge();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from flowerknowledge where id= ?");
       this.ps.setString(1, id);
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next()) {
         flowerKnowledge.setId(this.rs.getInt(1));
         flowerKnowledge.setTitle(this.rs.getString(2));
         flowerKnowledge.setContent(this.rs.getString(3));
         flowerKnowledge.setPublishtime(this.rs.getTimestamp(4));
         flowerKnowledge.setReadtimes(this.rs.getInt(5));
       }
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return flowerKnowledge;
   }
 
   public boolean delFlowerKnowledgeById(String id)
   {
     boolean b = true;
     String sql = "delete from flowerknowledge where id=?";
     String[] parameters = { id };
     try {
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public boolean insertFlowerKnowledge(String title, String content)
   {
     boolean b = true;
     try
     {
       String sql = "insert into flowerknowledge(title,content,publishtime) values(?,?,now())";
       String[] parameters = { title, content };
       SqlHelper.executeUpdate(sql, parameters);
     }
     catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return b;
   }
 
   public FlowerKnowledge getBeforeFlowerKnowledgeById(String newsid)
   {
     FlowerKnowledge flowerKnowledge = new FlowerKnowledge();
     int id = Integer.parseInt(newsid);
     try
     {
       this.ct = SqlHelper.getConnection();
 
       this.ps = this.ct.prepareStatement("select * from flowerknowledge where id>? order by id asc limit 1");
       this.ps.setInt(1, id);
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next()) {
         flowerKnowledge.setId(this.rs.getInt(1));
         flowerKnowledge.setTitle(this.rs.getString(2));
         flowerKnowledge.setContent(this.rs.getString(3));
         flowerKnowledge.setPublishtime(this.rs.getTimestamp(4));
         flowerKnowledge.setReadtimes(this.rs.getInt(5));
       }
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return flowerKnowledge;
   }
 
   public FlowerKnowledge getNextFlowerKnowledgeById(String newsid)
   {
     FlowerKnowledge flowerKnowledge = new FlowerKnowledge();
     int id = Integer.parseInt(newsid);
     try
     {
       this.ct = SqlHelper.getConnection();
 
       this.ps = this.ct.prepareStatement("select * from flowerKnowledge where id<? order by id desc limit 1");
       this.ps.setInt(1, id);
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next()) {
         flowerKnowledge.setId(this.rs.getInt(1));
         flowerKnowledge.setTitle(this.rs.getString(2));
         flowerKnowledge.setContent(this.rs.getString(3));
         flowerKnowledge.setPublishtime(this.rs.getTimestamp(4));
         flowerKnowledge.setReadtimes(this.rs.getInt(5));
       }
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return flowerKnowledge;
   }
 }