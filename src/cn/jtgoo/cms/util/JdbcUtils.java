package cn.jtgoo.cms.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import cn.jtgoo.cms.domain.ReserveOrder;

public class JdbcUtils {
	
	private static String driver;
	private static String url;
	private static String username;
	private static String password;
	
	static{
		try {
			InputStream in = JdbcUtils.class.getClassLoader().getResourceAsStream("default.properties");
			Properties prop = new Properties();
			prop.load(in);
			driver = prop.getProperty("driver");
			url = prop.getProperty("url");
			username = prop.getProperty("username");
			password = prop.getProperty("password");
			Class.forName(driver);
		} catch (Exception e) {
			throw new ExceptionInInitializerError(e);
		}
	}
	
	//获取链接
	public static Connection getConnection() throws SQLException{
		Connection conn = DriverManager.getConnection(url,username,password);
		return conn;
	}
	
	/**
	 * @param name
	 * @param dataTypeDetailId
	 * @param path
	 * @param type 
	 * 1  或者其它 代表 附件表
	 * 2代表  保险附件表
	 * 3代表 订单附件资料
	 * @return
	 * @throws SQLException
	 */
	public static String updateAttment(String id,String name,String path,String type) throws SQLException {
		PreparedStatement  stm = null;
		Connection conn = getConnection();
		ResultSet rs =null;
		
		String oldPath="";
		//通过附件id 查询出路径
		String select_sql="";
		String update_sql="";
		String table="";
		if(type.equals("2"))
		{
			table = "jtgoo_baoxian_attachment";
		}
		else if(type.equals("3"))
		{
			table = "jtgoo_visaorder_attachment";
		}
		else
		{
			table = "jtgoo_attachment";
		}
		
		
		//select sql
		
		select_sql ="select path from "+table+" where id="+id;
		stm = conn.prepareStatement(select_sql);
		stm.executeQuery();
		rs=stm.getResultSet();
		while(rs.next())
        {
			oldPath=rs.getString(1);
         System.out.println(oldPath);
        }
		update_sql ="update "+table+" set name=?,path=?,uploadTime=? where id="+id;
		System.out.println(update_sql);
		stm = conn.prepareStatement(update_sql);
		stm.setString(1, name);
		stm.setString(2, path);
		stm.setString(3, NumberFormatTools.getCurrentTime());
		stm.executeUpdate();
		JdbcUtils.release(rs, stm, conn);
		return oldPath;
	}
	/**
	 * @param name
	 * @param dataTypeDetailId
	 * @param path
	 * @param type 
	 * 1  或者其它 代表 附件表
	 * 2代表  保险附件表
	 * 3代表 订单附件资料
	 * @return
	 * @throws SQLException
	 */
	public static int addAttment(String orderId,String name,String path,String type) throws SQLException {
		int id=0;
		PreparedStatement  stm = null;
	    Connection conn = getConnection();
	    ResultSet rs =null;
	    String add_sql="";
		String update_sql="";
		String table="";
	    if(type.equals("2"))
	    {
	    	table = "jtgoo_baoxian_attachment";
	    }
	    else if(type.equals("3"))
	    {
	    	table = "jtgoo_visaorder_attachment";
	    }
	    else
	    {
	    	table = "jtgoo_attachment";
	    }
	    add_sql ="insert into "+table+"(name,path,uploadTime) values(?,?,?)";
		stm = conn.prepareStatement(add_sql,Statement.RETURN_GENERATED_KEYS);
		stm.setString(1,name);
		stm.setString(2, path);
		stm.setString(3, NumberFormatTools.getCurrentTime());
		int row=stm.executeUpdate();
		  rs = stm.getGeneratedKeys ();  
		     if ( rs.next() ) {  
		        int key = rs.getInt(row);  
		        id=key;
		     }  
		 //update other table  type="3"与其它表是不同的 订单与 附件是一对一的单向关联
		     if(type.equals("3"))
		     {
		    	 update_sql ="update jtgoo_visaorder set visaorder_attchment_id=? where id="+orderId;
		    	 stm = conn.prepareStatement(update_sql);
		    	 System.out.println(update_sql);
		    	 stm.setInt(1, id);
		    	 stm.executeUpdate();
		     }
		     JdbcUtils.release(rs, stm, conn);
		     return id; 
	}
	
	
	public static int addReserveOrder(ReserveOrder order) throws SQLException {
		int id=0;
		Statement stm = null;
	    Connection conn = getConnection();
	    ResultSet rs =null; 
		String sql = "insert into jtgoo_reserve_order(number_of_people1,number_of_people2,order_price,customer_name,mobile_phone,mail,remark,city,product_name,product_id,register_time) values('"+order.getNumber_of_people1()+"','"+order.getNumber_of_people2()
		+"','"+order.getOrder_price()+"','"+order.getCustomer_name()+"','"+order.getMobile_phone()+"','"+order.getMail()+"','"+order.getRemark()
		+"','"+order.getCity()+"','"+order.getProduct_name()+"','"+order.getProduct_id()
		+"','"+NumberFormatTools.getCurrentTime()+"')";
		System.out.println(sql);
		stm = conn.prepareStatement(sql);
		int row=stm.executeUpdate(sql,Statement.RETURN_GENERATED_KEYS);
		  rs = stm.getGeneratedKeys ();  
		     if ( rs.next() ) {  
		        int key = rs.getInt(row);  
		        id=key;
		     }  
		     JdbcUtils.release(rs, stm, conn);
		     return id; 
	}
	public static void release(ResultSet rs,Statement st,Connection conn) {
		if(rs!=null){
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			rs = null;
		}
		if(st!=null){
			try {
				st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			st = null;
		}
		if(conn!=null){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			conn = null;
		}
	}
	
}
