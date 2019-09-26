 package com.gcj.service;
 
 import com.gcj.domain.FlowerBean;
 import com.gcj.domain.FlowerInfo;
 import com.gcj.domain.FlowerIntro;
 import com.gcj.domain.OrderItem;
 import com.gcj.domain.RestoreFlower;
 import com.gcj.domain.Users;
 import com.gcj.utils.SqlHelper;
 import java.io.PrintStream;
 import java.sql.Connection;
 import java.sql.PreparedStatement;
 import java.sql.ResultSet;
 import java.sql.SQLException;
 import java.sql.Statement;
 import java.util.ArrayList;
 
 public class FlowerService
 {
   private ResultSet rs = null;
   private Connection ct = null;
   private PreparedStatement ps = null;
   private Statement sm = null;
 
   public int getRestorePageCount(int pageSize, String userid)
   {
     int pageCount = 0;
     int rowCount = 0;
     try {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select count(*) from restoreflower where userid=?");
       this.ps.setString(1, userid);
 
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
 
   public ArrayList getFlowersByPage(int pageSize, int pageNow)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from flower limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         FlowerBean flower = new FlowerBean();
         flower.setFlowerid(this.rs.getInt(1));
         flower.setFlowername(this.rs.getString(2));
         flower.setFlowerintro(this.rs.getString(3));
         flower.setFlowerprice(this.rs.getDouble(4));
         flower.setFlowernum(this.rs.getInt(5));
         flower.setPhoto(this.rs.getString(6));
         flower.setFlowertype(this.rs.getString(7));
         flower.setMarketprice(this.rs.getDouble(8));
         flower.setStartsale(this.rs.getInt(9));
         flower.setFlowerunit(this.rs.getString(10));
         flower.setFlowerfield(this.rs.getString(11));
         al.add(flower);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public FlowerBean getFlowerById(int id)
   {
     FlowerBean flowerBean = new FlowerBean();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from flower where flowerid= ?");
				this.ps.setInt(1, id);
				ps.setInt(1, id);
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next()) {
         flowerBean.setFlowerid(this.rs.getInt(1));
         flowerBean.setFlowername(this.rs.getString(2));
         flowerBean.setFlowerintro(this.rs.getString(3));
         flowerBean.setFlowerprice(this.rs.getDouble(4));
         flowerBean.setFlowernum(this.rs.getInt(5));
         flowerBean.setPhoto(this.rs.getString(6));
         flowerBean.setFlowertype(this.rs.getString(7));
         flowerBean.setMarketprice(this.rs.getDouble(8));
         flowerBean.setStartsale(this.rs.getInt(9));
         flowerBean.setFlowerunit(this.rs.getString(10));
         flowerBean.setFlowerfield(this.rs.getString(11));
       }
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return flowerBean;
   }
 
   public FlowerBean getFlowerByName(String flowername)
   {
     FlowerBean flowerBean = new FlowerBean();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from flower where flowername= ?");
       this.ps.setString(1, flowername);
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next()) {
         flowerBean.setFlowerid(this.rs.getInt(1));
         flowerBean.setFlowername(this.rs.getString(2));
         flowerBean.setFlowerintro(this.rs.getString(3));
         flowerBean.setFlowerprice(this.rs.getDouble(4));
         flowerBean.setFlowernum(this.rs.getInt(5));
         flowerBean.setPhoto(this.rs.getString(6));
         flowerBean.setFlowertype(this.rs.getString(7));
         flowerBean.setMarketprice(this.rs.getDouble(8));
         flowerBean.setStartsale(this.rs.getInt(9));
         flowerBean.setFlowerunit(this.rs.getString(10));
         flowerBean.setFlowerfield(this.rs.getString(11));
       }
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return flowerBean;
   }
 
   public int getNumsById(FlowerBean flower)
   {
     int num = 0;
     num = flower.getReservenums();
     return num;
   }
 
   public double getSinglePrice(FlowerBean flower)
   {
     double price = 0.0D;
     price = flower.getFlowerprice() * flower.getReservenums();
     double trueprice = Math.round(price * 100000.0D) / 100000.0D;
     return trueprice;
   }
 
   public double getSingleFlowerPrice(FlowerBean flower, String nums) {
     double price = 0.0D;
     price = flower.getFlowerprice() * Integer.parseInt(nums);
     double trueprice = Math.round(price * 100000.0D) / 100000.0D;
     return trueprice;
   }
 
   public double getSaveMoney(FlowerBean flower)
   {
     double price = 0.0D;
     price = (flower.getMarketprice() - flower.getFlowerprice()) * flower.getReservenums();
     double trueprice = Math.round(price * 100000.0D) / 100000.0D;
     return trueprice;
   }
 
   public double getSaveSingleMoney(FlowerBean flower, MyCart myCart)
   {
     double price = 0.0D;
 
     int nums = Integer.parseInt(myCart.getFlowerNumById(""+flower.getFlowerid()));
     price = (flower.getMarketprice() - flower.getFlowerprice()) * nums;
     double trueprice = Math.round(price * 100000.0D) / 100000.0D;
     return trueprice;
   }
 
   public double getSingleFlowerPrice(FlowerBean flower, MyCart myCart) {
     double price = 0.0D;
 
     int nums = Integer.parseInt(myCart.getFlowerNumById(""+flower.getFlowerid()));
     price = flower.getFlowerprice() * nums;
     double trueprice = Math.round(price * 100000.0D) / 100000.0D;
     return trueprice;
   }
 
   public boolean updFlower(FlowerBean flower)
   {
     boolean b = true;
     try
     {
       String sql = "update flower set flowerprice=?,marketprice=?,flowernum=?,startsale=?,flowerfield=?,flowerintro=? where flowerid=?";
       String[] parameters = { ""+flower.getFlowerprice(), ""+flower.getMarketprice(), ""+flower.getFlowernum(), ""+flower.getStartsale(), flower.getFlowerfield(), flower.getFlowerintro(), ""+flower.getFlowerid() };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public boolean updFlowerPhoto(String photo, String id)
   {
     boolean b = true;
     try
     {
       String sql = "update flower set photo=? where flowerid=?";
       String[] parameters = { photo, id };
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return b;
   }
 
   public boolean insertFlower(FlowerBean flower)
   {
     boolean b = true;
     try
     {
       String sql = "insert into flower(flowername,flowerintro,flowerprice,flowernum,photo,flowertype,marketprice,startsale,flowerunit,flowerfield) values(?,?,?,?,?,?,?,?,?,?)";
       String[] parameters = { flower.getFlowername(), flower.getFlowerintro(), ""+flower.getFlowerprice(), ""+flower.getFlowernum(), flower.getPhoto(), flower.getFlowertype(), ""+flower.getMarketprice(), ""+flower.getStartsale(), flower.getFlowerunit(), flower.getFlowerfield() };
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
 
   public boolean insertFlowerInfo(FlowerInfo flowerinfo)
   {
     boolean b = true;
     try
     {
       String sql = "insert into flowerinfo values(?,?,?,?,?,?,?)";
       String[] parameters = { ""+flowerinfo.getId(), flowerinfo.getType(), flowerinfo.getGrade(), flowerinfo.getColor(), flowerinfo.getUseway(), flowerinfo.getSpecification(), flowerinfo.getUsefestival() };
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
 
   public boolean updateFlowerInfo(FlowerInfo flowerinfo)
   {
     boolean b = true;
     try
     {
       String sql = "update flowerinfo set type=?,grade=?,color=?,useway=?,specification=?,usefestival=? where id=?";
       String[] parameters = { flowerinfo.getType(), flowerinfo.getGrade(), flowerinfo.getColor(), flowerinfo.getUseway(), flowerinfo.getSpecification(), flowerinfo.getUsefestival(), ""+flowerinfo.getId() };
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
 
   public FlowerInfo getFlowerInfoById(String id)
   {
     FlowerInfo flowerInfo = new FlowerInfo();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from flowerinfo where id= ?");
       this.ps.setString(1, id);
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next()) {
         flowerInfo.setId(this.rs.getInt(1));
         flowerInfo.setType(this.rs.getString(2));
         flowerInfo.setGrade(this.rs.getString(3));
         flowerInfo.setColor(this.rs.getString(4));
         flowerInfo.setUseway(this.rs.getString(5));
         flowerInfo.setSpecification(this.rs.getString(6));
         flowerInfo.setUsefestival(this.rs.getString(7));
       }
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return flowerInfo;
   }
 
   public ArrayList getCollectFlower(String userid) {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
 
       this.ps = this.ct.prepareStatement("");
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         FlowerBean flower = new FlowerBean();
         flower.setFlowerid(this.rs.getInt(1));
         flower.setFlowername(this.rs.getString(2));
         flower.setFlowerintro(this.rs.getString(3));
         flower.setFlowerprice(this.rs.getDouble(4));
         flower.setFlowernum(this.rs.getInt(5));
         flower.setPhoto(this.rs.getString(6));
         flower.setFlowertype(this.rs.getString(7));
         flower.setMarketprice(this.rs.getDouble(8));
         flower.setStartsale(this.rs.getInt(9));
         flower.setFlowerunit(this.rs.getString(10));
         flower.setFlowerfield(this.rs.getString(11));
         al.add(flower);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public boolean restoreFlower(FlowerBean flower, Users user)
   {
     boolean b = true;
     try
     {
       String sql = "insert into restoreflower(userid,flowerid,flowername,photo,flowerprice,marketprice,restoretime) values(?,?,?,?,?,?,now())";
       String[] parameters = { ""+user.getUserid(), ""+flower.getFlowerid(), flower.getFlowername(), flower.getPhoto(), ""+flower.getFlowerprice(), ""+flower.getMarketprice() };
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
 
   public RestoreFlower getRestoreFlowerInfoById(String id)
   {
     RestoreFlower restoreFlower = new RestoreFlower();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from restoreflower where flowerid=?");
       this.ps.setString(1, id);
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next()) {
         restoreFlower.setId(this.rs.getInt(1));
         restoreFlower.setUserid(this.rs.getInt(2));
         restoreFlower.setFlowerid(this.rs.getInt(3));
         restoreFlower.setFlowername(this.rs.getString(4));
         restoreFlower.setPhoto(this.rs.getString(5));
         restoreFlower.setFlowerprice(this.rs.getDouble(6));
         restoreFlower.setMarketprice(this.rs.getDouble(7));
         restoreFlower.setRestoretime(this.rs.getDate(8));
       }
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return restoreFlower;
   }
 
   public boolean getRestoreFlowerInfo(String flowerid, String userid)
   {
     boolean b = false;
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from restoreflower where flowerid=? and userid=?");
       this.ps.setString(1, flowerid);
       this.ps.setString(2, userid);
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next())
         b = true;
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return b;
   }
 
   public ArrayList getAllRestoreFlower(String userid)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from restoreflower where userid=?");
       this.ps.setString(1, userid);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         RestoreFlower flower = new RestoreFlower();
 
         flower.setId(this.rs.getInt(1));
         flower.setUserid(this.rs.getInt(2));
         flower.setFlowerid(this.rs.getInt(3));
         flower.setFlowername(this.rs.getString(4));
         flower.setPhoto(this.rs.getString(5));
         flower.setFlowerprice(this.rs.getDouble(6));
         flower.setMarketprice(this.rs.getDouble(7));
         flower.setRestoretime(this.rs.getDate(8));
         al.add(flower);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public int getPageCount(int pageSize)
   {
     int pageCount = 0;
     int rowCount = 0;
     try {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select count(*) from flower");
 
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
 
   public ArrayList getRestoreFlowersByPage(int pageSize, int pageNow, String userid)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from restoreflower where userid=? limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.ps.setString(1, userid);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         RestoreFlower flower = new RestoreFlower();
 
         flower.setId(this.rs.getInt(1));
         flower.setUserid(this.rs.getInt(2));
         flower.setFlowerid(this.rs.getInt(3));
         flower.setFlowername(this.rs.getString(4));
         flower.setPhoto(this.rs.getString(5));
         flower.setFlowerprice(this.rs.getDouble(6));
         flower.setMarketprice(this.rs.getDouble(7));
         flower.setRestoretime(this.rs.getDate(8));
         al.add(flower);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public boolean delRestoreFlower(String flowerid, String userid)
   {
     boolean b = true;
     String sql = "delete from restoreflower where flowerid=? and userid=?";
     String[] parameters = { flowerid, userid };
     try {
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
     }
     return b;
   }
 
   public boolean delFlower(String flowerid)
   {
     boolean b = true;
     String sql = "delete from flower where flowerid=?";
     String[] parameters = { flowerid };
     try {
       SqlHelper.executeUpdate(sql, parameters);
     } catch (Exception e) {
       b = false;
     }
     return b;
   }
 
   public ArrayList getSimilarFlower(FlowerBean similarflower)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from flower where flowertype=? and flowerid !=?");
       this.ps.setString(1, similarflower.getFlowertype());
       this.ps.setInt(2, similarflower.getFlowerid());
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         FlowerBean flower = new FlowerBean();
         flower.setFlowerid(this.rs.getInt(1));
         flower.setFlowername(this.rs.getString(2));
         flower.setFlowerintro(this.rs.getString(3));
         flower.setFlowerprice(this.rs.getDouble(4));
         flower.setFlowernum(this.rs.getInt(5));
         flower.setPhoto(this.rs.getString(6));
         flower.setFlowertype(this.rs.getString(7));
         flower.setMarketprice(this.rs.getDouble(8));
         flower.setStartsale(this.rs.getInt(9));
         flower.setFlowerunit(this.rs.getString(10));
         flower.setFlowerfield(this.rs.getString(11));
         al.add(flower);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public ArrayList getSameTypeFlower(String type)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from flower where flowertype=?");
       this.ps.setString(1, type);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         FlowerBean flower = new FlowerBean();
         flower.setFlowerid(this.rs.getInt(1));
         flower.setFlowername(this.rs.getString(2));
         flower.setFlowerintro(this.rs.getString(3));
         flower.setFlowerprice(this.rs.getDouble(4));
         flower.setFlowernum(this.rs.getInt(5));
         flower.setPhoto(this.rs.getString(6));
         flower.setFlowertype(this.rs.getString(7));
         flower.setMarketprice(this.rs.getDouble(8));
         flower.setStartsale(this.rs.getInt(9));
         flower.setFlowerunit(this.rs.getString(10));
         flower.setFlowerfield(this.rs.getString(11));
         al.add(flower);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public ArrayList getKeyWordFlower(String keyword, String flowertype)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
 
       String sql = "select * from flower where flowername like '%" + keyword + "%' and flowertype=?";
       this.ps = this.ct.prepareStatement(sql);
       this.ps.setString(1, flowertype);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         FlowerBean flower = new FlowerBean();
         flower.setFlowerid(this.rs.getInt(1));
         flower.setFlowername(this.rs.getString(2));
         flower.setFlowerintro(this.rs.getString(3));
         flower.setFlowerprice(this.rs.getDouble(4));
         flower.setFlowernum(this.rs.getInt(5));
         flower.setPhoto(this.rs.getString(6));
         flower.setFlowertype(this.rs.getString(7));
         flower.setMarketprice(this.rs.getDouble(8));
         flower.setStartsale(this.rs.getInt(9));
         flower.setFlowerunit(this.rs.getString(10));
         flower.setFlowerfield(this.rs.getString(11));
         al.add(flower);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public ArrayList getSameTypeFlowersByPage(int pageSize, int pageNow, String flowertype)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from flower where flowertype=? limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.ps.setString(1, flowertype);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         FlowerBean flower = new FlowerBean();
         flower.setFlowerid(this.rs.getInt(1));
         flower.setFlowername(this.rs.getString(2));
         flower.setFlowerintro(this.rs.getString(3));
         flower.setFlowerprice(this.rs.getDouble(4));
         flower.setFlowernum(this.rs.getInt(5));
         flower.setPhoto(this.rs.getString(6));
         flower.setFlowertype(this.rs.getString(7));
         flower.setMarketprice(this.rs.getDouble(8));
         flower.setStartsale(this.rs.getInt(9));
         flower.setFlowerunit(this.rs.getString(10));
         flower.setFlowerfield(this.rs.getString(11));
         al.add(flower);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public int getSameFlowerPageCount(int pageSize, String flowertype)
   {
     int pageCount = 0;
     int rowCount = 0;
     try {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select count(*) from flower where flowertype=?");
 
       this.ps.setString(1, flowertype);
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
 
   public ArrayList getFlowersByPriceAndPage(int pageSize, int pageNow, String lowprice, String highprice)
   {
     ArrayList al = new ArrayList();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from flower where flowerprice between " + lowprice + " and " + highprice + " order by flowerprice limit " + (pageNow - 1) * pageSize + "," + pageSize);
       this.rs = this.ps.executeQuery();
       while (this.rs.next()) {
         FlowerBean flower = new FlowerBean();
         flower.setFlowerid(this.rs.getInt(1));
         flower.setFlowername(this.rs.getString(2));
         flower.setFlowerintro(this.rs.getString(3));
         flower.setFlowerprice(this.rs.getDouble(4));
         flower.setFlowernum(this.rs.getInt(5));
         flower.setPhoto(this.rs.getString(6));
         flower.setFlowertype(this.rs.getString(7));
         flower.setMarketprice(this.rs.getDouble(8));
         flower.setStartsale(this.rs.getInt(9));
         flower.setFlowerunit(this.rs.getString(10));
         flower.setFlowerfield(this.rs.getString(11));
         al.add(flower);
       }
     } catch (Exception e) {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
     return al;
   }
 
   public int getFlowerByPricePageCount(int pageSize, String lowprice, String highprice)
   {
     int pageCount = 0;
     int rowCount = 0;
     try {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select count(*) from flower where flowerprice between " + lowprice + " and " + highprice);
 
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
 
   public FlowerIntro getFlowerIntroByType(FlowerBean flower)
   {
     FlowerIntro flowerIntro = new FlowerIntro();
     try
     {
       this.ct = SqlHelper.getConnection();
       this.ps = this.ct.prepareStatement("select * from flower_intro where flowertype= ?");
       this.ps.setString(1, flower.getFlowertype());
       this.rs = this.ps.executeQuery();
 
       if (this.rs.next()) {
         flowerIntro.setId(this.rs.getInt(1));
         flowerIntro.setFlowertype(this.rs.getString(2));
         flowerIntro.setFlowerintro(this.rs.getString(3));
       }
     }
     catch (Exception e)
     {
       e.printStackTrace();
     } finally {
       SqlHelper.close(this.rs, SqlHelper.getPs(), SqlHelper.getCt());
     }
 
     return flowerIntro;
   }
 
   public boolean updateFlowerNumsByOrsersItem(ArrayList ordersitemal, ArrayList floweral)
   {
     boolean b = true;
     try {
       this.ct = SqlHelper.getConnection();
 
       Statement sm = this.ct.createStatement();
       for (int i = 0; i < ordersitemal.size(); i++) {
         FlowerBean flower = (FlowerBean)floweral.get(i);
 
         OrderItem orderitem = (OrderItem)ordersitemal.get(i);
 
         int reservenum = orderitem.getFlowernum();
         int id = flower.getFlowerid();
         System.out.println("预订量=" + reservenum + "id=" + id + "库存量=" + flower.getFlowernum());
         System.out.println("update flower set flowernum=flowernum-" + reservenum + " where flowerid=" + id);
 
         sm.addBatch("update flower set flowernum=flowernum-" + reservenum + " where flowerid=" + id);
       }
 
       sm.executeBatch();
     }
     catch (Exception e)
     {
       b = false;
       e.printStackTrace();
 
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e1) {
           e1.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e2) {
           e2.printStackTrace();
         }
       }
       if (this.ct != null)
         try {
           this.ct.close();
         }
         catch (SQLException e3) {
           e3.printStackTrace();
         }
     }
     finally
     {
       if (this.rs != null) {
         try {
           this.rs.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ps != null) {
         try {
           this.ps.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
       if (this.ct != null) {
         try {
           this.ct.close();
         }
         catch (SQLException e) {
           e.printStackTrace();
         }
       }
 
     }
 
     return b;
   }
 }
