package com.gcj.utils;

import java.io.FileInputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

public class SqlHelper
{
  private static final String DRIVER = "org.gjt.mm.mysql.Driver";
  private static final String URL = "jdbc:mysql://localhost:3306/SunDance";
  private static final String USERNAME = "root";
  private static final String PASSWORD = "root";
  private static Connection ct = null;

  private static PreparedStatement ps = null;
  private static ResultSet rs = null;
  private static CallableStatement cs = null;

  private static Properties pp = null;

  private static FileInputStream fis = null;

  static
  {
    try
    {
       Class.forName("org.gjt.mm.mysql.Driver");
    }
    catch (ClassNotFoundException e) {
       e.printStackTrace();
    }
  }

  public static CallableStatement getCs()
  {
     return cs;
  }

  public static Connection getCt()
  {
     return ct;
  }
  public static PreparedStatement getPs() {
     return ps;
  }
  public static ResultSet getRs() {
     return rs;
  }

  public static Connection getConnection()
  {
    try
    {
       ct = DriverManager.getConnection("jdbc:mysql://localhost:3306/SunDance", "root", "root");
    }
    catch (SQLException e) {
       e.printStackTrace();
    }
    return ct;
  }

  public static CallableStatement callPro2(String sql, String[] inparameters, Integer[] outparameters)
  {
    try
    {
       ct = getConnection();
       cs = ct.prepareCall(sql);
       if (inparameters != null) {
         for (int i = 0; i < inparameters.length; i++) {
           cs.setObject(i + 1, inparameters[i]);
        }
      }

       if (outparameters != null) {
         for (int i = 0; i < outparameters.length; i++) {
           cs.registerOutParameter(inparameters.length + 1 + i, outparameters[i].intValue());
        }
      }
       cs.execute();
    }
    catch (Exception e) {
       e.printStackTrace();
       throw new RuntimeException(e.getMessage());
    }

     return cs;
  }

  public static void callPro1(String sql, String[] parameters)
  {
    try
    {
       ct = getConnection();
       cs = ct.prepareCall(sql);

       if (parameters != null) {
         for (int i = 0; i < parameters.length; i++) {
           cs.setObject(i + 1, parameters[i]);
        }
      }

       cs.execute();
    }
    catch (Exception e) {
       e.printStackTrace();
       throw new RuntimeException(e.getMessage());
    } finally {
       close(rs, cs, ct);
    }
  }

  public static ArrayList executeQuery3(String sql, String[] parms)
  {
     PreparedStatement pstmt = null;
     Connection conn = null;
     ResultSet rs = null;
    try {
       conn = getConnection();
       pstmt = conn.prepareStatement(sql);

       if ((parms != null) && (!parms.equals(""))) {
         for (int i = 0; i < parms.length; i++) {
           pstmt.setString(i + 1, parms[i]);
        }
      }

       rs = pstmt.executeQuery();

       ArrayList al = new ArrayList();
       ResultSetMetaData rsmd = rs.getMetaData();
       int column = rsmd.getColumnCount();
       while (rs.next()) {
         Object[] ob = new Object[column];
         for (int i = 1; i <= column; i++) {
           ob[(i - 1)] = rs.getObject(i);
        }
         al.add(ob);
      }
       ArrayList localArrayList1 = al;
      return localArrayList1;
    } catch (Exception e) {
       e.printStackTrace();
       throw new RuntimeException("executeSqlResult方法出错:" + e.getMessage());
    } finally {
       close(rs, pstmt, conn);
     }
  }

  public static ResultSet executeQuery(String sql, String[] parameters)
  {
    try {
       ct = getConnection();
       ps = ct.prepareStatement(sql);
       if ((parameters != null) && (!parameters.equals(""))) {
         for (int i = 0; i < parameters.length; i++) {
           ps.setString(i + 1, parameters[i]);
        }
      }
       rs = ps.executeQuery();
    } catch (Exception e) {
       e.printStackTrace();
       throw new RuntimeException(e.getMessage());
    }

     return rs;
  }

  public static void executeUpdate2(String[] sql, String[][] parameters)
  {
    try
    {
       ct = getConnection();

       ct.setAutoCommit(false);

       for (int i = 0; i < sql.length; i++) {
         if (parameters[i] != null) {
           ps = ct.prepareStatement(sql[i]);
           for (int j = 0; j < parameters[i].length; j++) {
             ps.setString(j + 1, parameters[i][j]);
          }
           ps.executeUpdate();
        }
      }

       ct.commit();
    } catch (Exception e) {
       e.printStackTrace();
      try
      {
         ct.rollback();
      }
      catch (SQLException e1) {
         e1.printStackTrace();
      }
       throw new RuntimeException(e.getMessage());
    }
    finally {
       close(rs, ps, ct);
    }
  }

  public static void executeUpdate(String sql, String[] parameters)
  {
    try
    {
       ct = getConnection();
       ps = ct.prepareStatement(sql);

       if (parameters != null)
      {
         for (int i = 0; i < parameters.length; i++) {
           ps.setString(i + 1, parameters[i]);
        }
      }

       ps.executeUpdate();
    } catch (Exception e) {
       e.printStackTrace();

       throw new RuntimeException(e.getMessage());
    }
    finally
    {
       close(rs, ps, ct);
    }
  }

  public static void close(ResultSet rs, Statement ps, Connection ct) {
     if (rs != null) {
      try {
         rs.close();
      }
      catch (SQLException e) {
         e.printStackTrace();
      }
    }

     if (ps != null) {
      try {
         ps.close();
      }
      catch (SQLException e) {
         e.printStackTrace();
      }
    }
     if (ct != null)
      try {
         ct.close();
      }
      catch (SQLException e) {
         e.printStackTrace();
      }
  }
}