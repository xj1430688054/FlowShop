 package com.gcj.service;
 
 import com.gcj.domain.FlowerTrendsList;
 import com.gcj.utils.SqlHelper;
 import java.sql.Connection;
 import java.sql.PreparedStatement;
 import java.sql.ResultSet;
 import java.sql.Statement;
 import java.util.ArrayList;
 
 public class FlowerTrendsService
 {
   private ResultSet rs = null;
   private Connection ct = null;
   private PreparedStatement ps = null;
   private Statement sm = null;
 
   public ArrayList getFlowerTrendsListByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
 
       this.ps = this.ct.prepareStatement("select * from flowernewslist order by newstime desc limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         FlowerTrendsList flowerTrendsList = new FlowerTrendsList();
         flowerTrendsList.setId(this.rs.getInt(1));
         flowerTrendsList.setTitle(this.rs.getString(2));
         flowerTrendsList.setContent(this.rs.getString(3));
         flowerTrendsList.setNewstime(this.rs.getTimestamp(4));
         flowerTrendsList.setReadtimes(this.rs.getInt(5));
         al.add(flowerTrendsList);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public int getRFlowerTrendsPageCount(int pageSize)
   {
     int pageCount = 0;
     int rowCount = 0;
     try {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select count(*) from flowernewslist ");
 
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
       String sql = "update flowernewslist set readtimes=readtimes+1 where id=?";
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
 
   public FlowerTrendsList getFlowerTrendsListById(String id)
   {
     FlowerTrendsList flowerTrendsList = new FlowerTrendsList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from flowernewslist where id= ?");
       this.ps.setString(1, id);
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next()) {
         flowerTrendsList.setId(this.rs.getInt(1));
         flowerTrendsList.setTitle(this.rs.getString(2));
         flowerTrendsList.setContent(this.rs.getString(3));
         flowerTrendsList.setNewstime(this.rs.getTimestamp(4));
         flowerTrendsList.setReadtimes(this.rs.getInt(5));
       }
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return flowerTrendsList;
   }
 
   public boolean delFlowerTrendsById(String newsid)
   {
     boolean b = true;
     String sql = "delete from flowernewslist where id=?";
     String[] parameters = { newsid };
     try {
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public boolean insertFlowerNewsList(String title, String content)
   {
     boolean b = true;
     try
     {
       String sql = "insert into flowernewslist(title,content,newstime) values(?,?,now())";
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
 
   public FlowerTrendsList getBeforeFlowerTrendsListById(String newsid)
   {
     FlowerTrendsList flowerTrendsList = new FlowerTrendsList();
     int id = Integer.parseInt(newsid);
     try
     {
       this.ct = SqlHelper.getConnection();
 
       this.ps = this.ct.prepareStatement("select * from flowernewslist where id>? order by id asc limit 1");
       this.ps.setInt(1, id);
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next()) {
         flowerTrendsList.setId(this.rs.getInt(1));
         flowerTrendsList.setTitle(this.rs.getString(2));
         flowerTrendsList.setContent(this.rs.getString(3));
         flowerTrendsList.setNewstime(this.rs.getTimestamp(4));
         flowerTrendsList.setReadtimes(this.rs.getInt(5));
       }
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return flowerTrendsList;
   }
 
   public FlowerTrendsList getNextFlowerTrendsListById(String newsid)
   {
     FlowerTrendsList flowerTrendsList = new FlowerTrendsList();
     int id = Integer.parseInt(newsid);
     try
     {
       this.ct = SqlHelper.getConnection();
 
       this.ps = this.ct.prepareStatement("select * from flowernewslist where id<? order by id desc limit 1");
       this.ps.setInt(1, id);
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next()) {
         flowerTrendsList.setId(this.rs.getInt(1));
         flowerTrendsList.setTitle(this.rs.getString(2));
         flowerTrendsList.setContent(this.rs.getString(3));
         flowerTrendsList.setNewstime(this.rs.getTimestamp(4));
         flowerTrendsList.setReadtimes(this.rs.getInt(5));
       }
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return flowerTrendsList;
   }
 }
