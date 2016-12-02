package com.csp595.utilities;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.IOException;
import java.sql.*;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.omg.CORBA.Request;
import com.csp595.beans.Coupon;
import com.csp595.beans.Donation;
import com.csp595.beans.Order;
import com.csp595.beans.Product;
import com.csp595.beans.TrendingProduct;
import com.csp595.beans.User;
import com.csp595.utilities.Constants.Orders;
import com.mysql.jdbc.CallableStatement;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

public class MySqlUtil {

	static final String DB_URL = "jdbc:mysql://localhost:3306/db_clicknpick?autoReconnect=true&useSSL=false";
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	
	private static List<Product> productList = new ArrayList<Product>();
	private static HashMap<String, Product> productHashMap;
	
	/**
	 * Method to return a MySql Connection
	 * 
	 * @return MySql Connection
	 */
	public static Connection getConnection() {

		try {
			Class.forName(JDBC_DRIVER).newInstance();
			Connection connection = (Connection) DriverManager.getConnection(DB_URL, "root", "root");
			return connection;
		} catch (InstantiationException | IllegalAccessException | SQLException | ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		return null;
	}
	
	/**
	 * Method to check if user exists or not.
	 * 
	 * @param username
	 * @param role
	 * @return 1: Exists, 0: User doesn't exist, -1: Sql connection error 
	 */
	public static int checkIfUserExists(String username, String role,String password){
		Connection connection = getConnection();
		int result = 0;
		if(connection != null){

			String sql = "SELECT u."+Constants.User.USERNAME_COL+" FROM "+ Constants.User.USERTABLE +" u WHERE u."+Constants.User.USERNAME_COL+" = ? AND u."+Constants.User.ROLE_COL+" = ?";
			if(password != null){
				sql=sql+" AND u."+Constants.User.PWD_COL+" = ?"; 
			}
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				preparedStatement.setString(1, username);
				preparedStatement.setString(2, role);
				if(password != null){
					preparedStatement.setString(3, password);
				}

				ResultSet rs = preparedStatement.executeQuery();
				if(rs.next()){
					result = 1;
				} else {
					result = 0;
				}
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else {
			result = -1;
		}
		return result;
	}
	
	public static void insertQueryForUserTable(String title, String first_name, String last_name,String email_id,String password,String date_of_birth,String username,
			String role,String address_1,String address_2,String city,String state, String zip, String country, String phone) {
		
		Connection connection = getConnection();
		if (connection != null) {
			String sql = "INSERT into "+ Constants.User.USERTABLE +"(title,first_name,last_name,email_id,password,date_of_birth,username,role,address_1,address_2,"
					+ "city,state,zip,country,phone) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				preparedStatement.setString(1, title);
				preparedStatement.setString(2, first_name);
				preparedStatement.setString(3, last_name);
				preparedStatement.setString(4, email_id);
				preparedStatement.setString(5, password);
				preparedStatement.setString(6, date_of_birth);
				preparedStatement.setString(7, username);
				preparedStatement.setString(8, role);
				preparedStatement.setString(9, address_1);
				preparedStatement.setString(10, address_2);
				preparedStatement.setString(11, city);
				preparedStatement.setString(12, state);
				preparedStatement.setString(13, zip);
				preparedStatement.setString(14, country);
				preparedStatement.setString(15, phone);
				//preparedStatement.setInt(4, 11);
				
				preparedStatement.execute();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static HashMap<String, Product> getAllProductMap(HttpServletRequest request){
		productHashMap = new HashMap<String, Product>();
		HttpSession session = request.getSession(true);
		Product product;
		Connection connection = getConnection();
		if(connection != null){
			String sql = "";
				if(session.getAttribute("clothing_type") != null && !session.getAttribute("clothing_type").toString().isEmpty()){
					sql = "SELECT * FROM "+Constants.Product.PRODUCTTABLE+ " WHERE type = ?";
				
				}				
				else
			sql = "SELECT * FROM "+Constants.Product.PRODUCTTABLE;
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				if(session.getAttribute("clothing_type") != null){
					preparedStatement.setString(1, session.getAttribute("clothing_type").toString());
					session.removeAttribute("clothing_type");
				}
				ResultSet resultSet = preparedStatement.executeQuery();
				while(resultSet.next()){
					product = new Product(resultSet.getString(Constants.Product.ID_COL), resultSet.getString(Constants.Product.NAME_COL),resultSet.getString(Constants.Product.GEN_COL), resultSet.getString(Constants.Product.CAT_COL), 
							resultSet.getInt(Constants.Product.PRICE_COL), resultSet.getInt(Constants.Product.DISCOUNT_COL), resultSet.getString(Constants.Product.MFG_COL), resultSet.getString(Constants.Product.COND_COL), 
							resultSet.getString(Constants.Product.DESC_COL), resultSet.getString(Constants.Product.IMAGE_COL));
					productHashMap.put(resultSet.getString(Constants.Product.ID_COL), product);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return productHashMap;
	}
	
	/**
	 * Function to get ProductHashMap to match the product with auto completion listed string
	 * @return
	 */
	public static HashMap<String, Product> getProductHashMap(){
		productHashMap = new HashMap<String,Product>();
		Connection connection = getConnection();
		
		if (connection != null && productHashMap.isEmpty()) {
			String sql = "SELECT * FROM "+Constants.Product.PRODUCTTABLE+"";
			try {
				Statement statement = (Statement) connection.createStatement();
			
				ResultSet resultSet = statement.executeQuery(sql);
				while (resultSet.next()){
					Product product = new Product();
					product.setId(resultSet.getString(Constants.Product.ID_COL));
					product.setName(resultSet.getString(Constants.Product.NAME_COL));
					product.setPrice(resultSet.getDouble(Constants.Product.PRICE_COL));
					product.setImage(resultSet.getString(Constants.Product.IMAGE_COL));
					product.setGender(resultSet.getString(Constants.Product.GEN_COL));
					product.setCategory(resultSet.getString(Constants.Product.CAT_COL));
					product.setDescription(resultSet.getString(Constants.Product.DESC_COL));
					productHashMap.put(resultSet.getString(Constants.Product.ID_COL), product);
				}
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return productHashMap;
	}
	
	public static void insertQueryForOrderTable(String orderId, String productIds, String userName, Double orderAmount, String oDate, String dDate, String shipAddress1, 
			String shipAddress2, String city, String state, String country,String zipCode, String cardNo, String nameOnCard, String cvv, String cardExpDate, 
			String phone, HttpSession session) {
		
		Connection connection = getConnection();
		if (connection != null) {
			String sql = "INSERT into "+Constants.Orders.ORDERTABLE+"("+Constants.Orders.ID_COL+","+Constants.Orders.FK_PROD_ID_COL+","+Constants.Orders.FK_USER_NAME_COL+
					","+Constants.Orders.ORDER_AMT_COL+","+Constants.Orders.ORDER_DT_COL+","+Constants.Orders.EXP_DEL_DT_COL+","+Constants.Orders.SHIP_ADDR_1_COL+
					","+Constants.Orders.SHIP_ADDR_2_COL+","+Constants.Orders.CITY_COL+","+Constants.Orders.STATE_COL+","+Constants.Orders.COUNTRY_COL+
					","+Constants.Orders.ZIP_COL+","+Constants.Orders.CARD_NO_COL+","+Constants.Orders.NAME_ON_CARD_COL+","+Constants.Orders.CVV_COL+
					","+Constants.Orders.CARD_EXP_DT_COL+","+Constants.Orders.PHONE_COL+") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				preparedStatement.setString(1, orderId);
				preparedStatement.setString(2, productIds);
				preparedStatement.setString(3, userName);
				preparedStatement.setDouble(4, orderAmount);
				preparedStatement.setString(5, oDate);
				preparedStatement.setString(6, dDate);
				preparedStatement.setString(7, shipAddress1);
				preparedStatement.setString(8, shipAddress2);
				preparedStatement.setString(9, city);
				preparedStatement.setString(10, state);
				preparedStatement.setString(11, country);
				preparedStatement.setString(12, zipCode);
				preparedStatement.setString(13, cardNo);
				preparedStatement.setString(14, nameOnCard);
				preparedStatement.setString(15, cvv);
				preparedStatement.setString(16, cardExpDate);
				preparedStatement.setString(17, phone);
				
				preparedStatement.execute();
				session.removeAttribute("shoppingItemId");
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * Method to get user order list.
	 */
	public static Map<String, Order> getUserOrderList(String userName, String role){
		Connection connection = getConnection();
		Map<String, Order> orderHashMap = new HashMap<String, Order>();
		if (connection != null && userName != null) {
			String sql;
			if (role.equals(Constants.ROLE_CUSTOMER)){
				sql = "SELECT * FROM "+Constants.Orders.ORDERTABLE+" WHERE "+Constants.Orders.FK_USER_NAME_COL+" = ?";
			} else {
				sql = "SELECT * FROM "+Constants.Orders.ORDERTABLE;
			}
			try {
				PreparedStatement preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				if(role.equals(Constants.ROLE_CUSTOMER)){
					preparedStatement.setString(1, userName);
				}
				ResultSet resultSet = preparedStatement.executeQuery();
				while(resultSet.next()){
					List<Product> productList = new ArrayList<Product>();
					String[] productCsv = resultSet.getString(Constants.Orders.FK_PROD_ID_COL).split(",");
					if(productCsv != null && productCsv.length > 0){
						for(int i=0;i<productCsv.length;i++){
							Product product = productHashMap.get(productCsv[i]);
							productList.add(product);
						}
						Order order = new Order(resultSet.getString(Constants.Orders.ID_COL), resultSet.getTimestamp(Constants.Orders.ORDER_DT_COL), 
								resultSet.getTimestamp(Constants.Orders.EXP_DEL_DT_COL),resultSet.getDouble(Constants.Orders.ORDER_AMT_COL), productList);
						orderHashMap.put(resultSet.getString(Constants.Orders.ID_COL), order);
					}
				}
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return orderHashMap;
	}
	
	/**
	 * Method to delete a placed order. 
	 * @param orderId
	 */
	public static void deleteOrder(String orderId){
		Connection connection = getConnection();
		String sql;
		if(connection != null){
			sql = "DELETE FROM "+ Constants.Orders.ORDERTABLE +" WHERE "+Constants.Orders.ID_COL+" = ?";
			try {
				PreparedStatement preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				preparedStatement.setString(1, orderId);
				preparedStatement.executeUpdate();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void insertQueryForCouponTable(String couponCode, String userName, String discount) {
		Connection connection = getConnection();
		if (connection != null) {
			String sql = "INSERT into "+ Constants.Coupon.COUPONTABLE +"("+Constants.Coupon.COUPON_CODE_COL+","+Constants.Coupon.DISCOUNT_COL+","+Constants.Coupon.USER_NAME_COL+") VALUES (?,?,?)";
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				preparedStatement.setString(1, couponCode);
				preparedStatement.setString(2, discount);
				preparedStatement.setString(3, userName);
				
				preparedStatement.execute();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static Map<String, Coupon> getCouponHashMap(){
		Connection connection = getConnection();
		Map<String, Coupon> couponHashMap = new HashMap<String, Coupon>();
		if (connection != null) {
			String sql = "SELECT * FROM "+Constants.Coupon.COUPONTABLE;
			try {
				PreparedStatement preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				ResultSet resultSet = preparedStatement.executeQuery();
				while(resultSet.next()){
					String couponCode = resultSet.getString(Constants.Coupon.COUPON_CODE_COL);
					Coupon coupon = new Coupon(couponCode, resultSet.getString(Constants.Coupon.DISCOUNT_COL),
							resultSet.getString(Constants.Coupon.USER_NAME_COL));
						couponHashMap.put(couponCode, coupon);
				}
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return couponHashMap;
	}
	
	public static ArrayList<String> getUserList(){
		Connection connection = getConnection();
 		ArrayList<String> userList = new ArrayList<String>();
			String sql = "SELECT "+Constants.User.USERNAME_COL+" FROM "+Constants.User.USERTABLE+ " WHERE "+Constants.User.ROLE_COL+" = ?"; //because coupons are craeted only by admins and only for customers. So it should be customers for whom the coupons must be created and the maping should be recorded.
			try {
				PreparedStatement preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				preparedStatement.setString(1, "customer");
				ResultSet resultSet = preparedStatement.executeQuery();
				while(resultSet.next()){
					userList.add(resultSet.getString(1));
				}
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		return userList;
	}
	
	public static User getUserBasedOnMailId(String mailId){
		Connection connection = getConnection();
		User user = new User();
		if (connection != null) {
			String sql = "SELECT "+Constants.User.FIRST_NAME+","+Constants.User.PWD_COL+" FROM "+Constants.User.USERTABLE+" WHERE "+Constants.User.MAIL_ID_COL+"= ?";
			try {
				PreparedStatement preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				preparedStatement.setString(1, mailId);
				ResultSet resultSet = preparedStatement.executeQuery();
				while (resultSet.next()){
					user = new User(resultSet.getString(Constants.User.FIRST_NAME), resultSet.getString(Constants.User.PWD_COL), mailId);
				}
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		return user;
		}
		return null;
	}
	
		public static String getUserRegion(String username, String role, String password){
		String region = " ";
		Connection conn = getConnection();
		
		if(conn != null){

			String sql = "SELECT T1.REGION FROM GEOLOCATION T1 INNER JOIN USER T2 ON T2.ZIP = T1.ZIPCODE WHERE T2.USERNAME = ? AND T2.PASSWORD = ?";
			
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) conn.prepareStatement(sql);
				preparedStatement.setString(1, username);
				preparedStatement.setString(2, password);
				/*if(password != null){
					preparedStatement.setString(3, password);
				}*/

				ResultSet rs = preparedStatement.executeQuery();
				while(rs.next()){
					region = rs.getString("region");
					if(!region.isEmpty()){
						break;
					}
				}
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return region;
	}
	
	public static HashMap<String, User> fetchAllUsers(){
		Connection conn = getConnection();
		HashMap<String, User> users = null;
		if(conn != null){
			String sql = "SELECT username, first_name, last_name FROM USER WHERE role = 'Customer' ";
			PreparedStatement prep;
			
			try{
				users = new HashMap<String, User>();
				prep = (PreparedStatement) conn.prepareStatement(sql);
				ResultSet rs = prep.executeQuery();
				while(rs.next()){
					User us = new User();
					us.setUserName(rs.getString("username"));
					us.setFirstName(rs.getString("first_name"));
					us.setLastName(rs.getString("last_name"));
					users.put(rs.getString("username"), us);
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		
		if(!users.isEmpty() && users.size()>0)
			return users;
		else
			return null;
	}
	
	public static HashMap<String, String> validateCoupon(String couponcode, HttpServletRequest request) throws SQLException{
		Connection conn = getConnection();
		HttpSession session = request.getSession(true);
		
		boolean isValid = false;
		HashMap<String, String> coupon = new HashMap<String, String>(); 
		String userName = (String) session.getAttribute("userName");
		if(conn!=null){
			String sql = "SELECT * FROM coupons WHERE coupon_code = ? AND user_name = ?";
			PreparedStatement prep = (PreparedStatement) conn.prepareStatement(sql);
			try {
				prep.setString(1, couponcode);
				prep.setString(2, userName);
				ResultSet rs = prep.executeQuery();
				while(rs.next()){
					coupon.put("couponcode",rs.getString("coupon_code"));
					coupon.put("discount", rs.getString("discount"));
					coupon.put("user_name", rs.getString("user_name"));
					isValid = true;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		}
		return coupon;
	}
	
	public static void insertIntoDonations(String username,String quantity,String organization,String pickUpDate,String pickUpLocation, HttpServletResponse response ){
		Connection connection = getConnection();
		if (connection != null) {
			String sql = "INSERT into "+ Constants.Donations.DONATIONS_TABLE +"("+Constants.Donations.USERNAME+","+Constants.Donations.QUANTITY+
				","+Constants.Donations.ORGANIZATION+","+Constants.Donations.PICKUP_DATE+","+Constants.Donations.PICKUP_LOCATION+","+Constants.Donations.ID+")"
			+ " VALUES (?,?,?,?,?,?)";
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				String id ="1";
				preparedStatement.setString(1, username);
				preparedStatement.setString(2, quantity);
				preparedStatement.setString(3, organization);
				preparedStatement.setString(4, pickUpDate);
				preparedStatement.setString(5, pickUpLocation);
				preparedStatement.setString(6, id);
				preparedStatement.execute();
				connection.close();
				try {
					response.sendRedirect("index.jsp?donatedSuccessfully=true");
				} catch (IOException e) {
					e.printStackTrace();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static List<Donation> readDonations(){
		List<Donation> donationList = new ArrayList<>();
		
		Connection connection = getConnection();
		
		if (connection != null) {
			String sql = "SELECT * FROM "+Constants.Product.PRODUCTTABLE+"";
			try {
				Statement statement = (Statement) connection.createStatement();
			
				ResultSet resultSet = statement.executeQuery(sql);
				while (resultSet.next()){
					Product product = new Product();
					product.setId(resultSet.getString(Constants.Product.ID_COL));
					product.setName(resultSet.getString(Constants.Product.NAME_COL));
					product.setPrice(resultSet.getDouble(Constants.Product.PRICE_COL));
					product.setImage(resultSet.getString(Constants.Product.IMAGE_COL));
					product.setGender(resultSet.getString(Constants.Product.GEN_COL));
					product.setCategory(resultSet.getString(Constants.Product.CAT_COL));
					product.setDescription(resultSet.getString(Constants.Product.DESC_COL));
					productHashMap.put(resultSet.getString(Constants.Product.ID_COL), product);
				}
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return donationList;
	}
	
}
