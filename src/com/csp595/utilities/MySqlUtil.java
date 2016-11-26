package com.csp595.utilities;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.csp595.beans.Coupon;
import com.csp595.beans.Order;
import com.csp595.beans.Product;
import com.csp595.utilities.Constants.Orders;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

public class MySqlUtil {

	static final String DB_URL = "jdbc:mysql://localhost:3306/db_clicknpick";
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String USERTABLE = "USER";
	static final String ORDERTABLE = "ORDERS";
	static final String PRODUCTTABLE = "PRODUCT";
	static final String COUPONTABLE = "COUPONS";
	
	static final String ROLE_CUSTOMER = "Customer";
	static final String ROLE_SALESMAN = "Salesman";
	static final String ROLE_STORE_MANAGER = "Store Manager";
	
	static final String P_ID_COL = "id";
	static final String P_GEN_COL = "gender";
	static final String P_CAT_COL = "category";
	static final String P_DESC_COL = "description";
	static final String P_TYPE_COL = "type";
	static final String P_NAME_COL = "name";
	static final String P_COND_COL = "condition";
	static final String P_MFG_COL = "manufacturer";
	static final String P_IMAGE_COL = "image";
	static final String P_DISCOUNT_COL = "discount";
	static final String P_PRICE_COL = "price";
	
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

			String sql = "SELECT u.username FROM "+ USERTABLE +" u WHERE u.username = ? AND u.role = ?";
			if(password != null){
				sql=sql+" AND u.password = ?"; 
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
			String sql = "INSERT into "+ USERTABLE +"(title,first_name,last_name,email_id,password,date_of_birth,username,role,address_1,address_2,"
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
	
	public static Map<String, Product> getAllProductMap(){
		productHashMap = new HashMap<String, Product>();
		Product product;
		Connection connection = getConnection();
		if(connection != null){
			String sql = "SELECT * FROM "+PRODUCTTABLE;
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				ResultSet resultSet = preparedStatement.executeQuery();
				while(resultSet.next()){
					product = new Product(resultSet.getString(P_ID_COL), resultSet.getString(P_NAME_COL),resultSet.getString(P_GEN_COL), resultSet.getString(P_CAT_COL), resultSet.getInt(P_PRICE_COL), 
							resultSet.getInt(P_DISCOUNT_COL), resultSet.getString(P_MFG_COL), resultSet.getString(P_COND_COL), resultSet.getString(P_DESC_COL), resultSet.getString(P_IMAGE_COL));
					productHashMap.put(resultSet.getString(P_ID_COL), product);
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
			String sql = "SELECT * FROM PRODUCT";
			try {
				Statement statement = (Statement) connection.createStatement();
			
				ResultSet resultSet = statement.executeQuery(sql);
				while (resultSet.next()){
					Product product = new Product();
					product.setId(resultSet.getString("id"));
					product.setName(resultSet.getString("name"));
					product.setPrice(resultSet.getDouble("price"));
					product.setImage(resultSet.getString("image"));
					product.setGender(resultSet.getString("gender"));
					product.setCategory(resultSet.getString("category"));
					product.setDescription(resultSet.getString("description"));
					productHashMap.put(resultSet.getString("id"), product);
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
			String sql = "INSERT into "+ORDERTABLE+"("+Constants.Orders.ID_COL+","+Constants.Orders.FK_PROD_ID_COL+","+Constants.Orders.FK_USER_NAME_COL+
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
			if (role.equals(ROLE_CUSTOMER)){
				sql = "SELECT * FROM "+ORDERTABLE+" WHERE "+Constants.Orders.FK_USER_NAME_COL+" = ?";
			} else {
				sql = "SELECT * FROM "+ORDERTABLE;
			}
			try {
				PreparedStatement preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				if(role.equals(ROLE_CUSTOMER)){
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
			sql = "DELETE FROM "+ ORDERTABLE +" WHERE "+Constants.Orders.ID_COL+" = ?";
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
			String sql = "INSERT into "+ COUPONTABLE +"(coupon_code,discount,user_name) VALUES (?,?,?)";
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
			String sql = "SELECT * FROM "+COUPONTABLE;
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
			String sql = "SELECT "+Constants.User.USERNAME_COL+" FROM "+USERTABLE;
			try {
				PreparedStatement preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
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
}
