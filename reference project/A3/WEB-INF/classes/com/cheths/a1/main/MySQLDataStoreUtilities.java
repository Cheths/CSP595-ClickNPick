package com.cheths.a1.main;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.ConnectionGroupManager;
import com.mysql.jdbc.PreparedStatement;

public class MySQLDataStoreUtilities {

	static final String DB_URL = "jdbc:mysql://localhost:3306/bestdealdatabase";
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String USERTABLE = "USER";
	static final String ORDERTABLE = "USER_ORDER_INFO";
	static final String PRODUCTTABLE = "PRODUCT";
	
	static final String ROLE_CUSTOMER = "Customer";
	static final String ROLE_SALESMAN = "Salesman";
	static final String ROLE_STORE_MANAGER = "Store Manager";
	
	private static List<Product> productList = new ArrayList<Product>();
	
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

	public static void dropTableForProduct(){
		Connection connection = getConnection();
		if(connection != null){
			PreparedStatement preparedStatement = null;
			String sql = "DROP TABLE IF EXISTS PRODUCT;";
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				preparedStatement.executeUpdate();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void createTableForProduct(){
		dropTableForProduct();
		Connection connection = getConnection();
		if(connection != null){
			PreparedStatement preparedStatement = null;
			String sql = "CREATE TABLE Product ("
					+ "id VARCHAR(20) PRIMARY KEY,"
					+ "product_name VARCHAR(100),"
					+ "category VARCHAR(100),"
					+ "retailer_name VARCHAR(100),"
					+ "price INT(10),"
					+ "discount INT(10),"
					+ "image VARCHAR(100),"
					+ "description VARCHAR(255));";
			
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				preparedStatement.executeUpdate();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void insertRecordstoProductTable(){
		createTableForProduct();
		
		Connection connection = getConnection();
		if(connection != null){
			PreparedStatement preparedStatement = null;
			try {
				String sql = "INSERT INTO PRODUCT(id,category,product_name,retailer_name,price,discount,image,description) VALUES(?,?,?,?,?,?,?,?)";
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				
				Map<String, Product> productHashMap = SaxParserProductXMLdataStore.getProductHashMap();
				for(Entry<String, Product> productEntryValue: productHashMap.entrySet()){
					Product product = productEntryValue.getValue();
					
					preparedStatement.setString(1, product.getId());
					preparedStatement.setString(2, product.getCategory());
					preparedStatement.setString(3, product.getName());
					preparedStatement.setString(4, product.getRetailer());
					preparedStatement.setInt(5, product.getPrice());
					preparedStatement.setInt(6, product.getDiscount());
					preparedStatement.setString(7, product.getImage());
					preparedStatement.setString(8, product.getDescription());
					preparedStatement.addBatch();
				}
				
				preparedStatement.executeBatch();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static List<Product> loadAllProducts(){
		if(productList.isEmpty()){
			Connection connection = getConnection();
			if (connection != null) {
				String sql = "SELECT * FROM PRODUCT";
				PreparedStatement preparedStatement;
				try {
					preparedStatement = (PreparedStatement) connection.prepareStatement(sql);

					ResultSet resultSet = preparedStatement.executeQuery(sql);

					if(resultSet != null){
						try {
							while(resultSet.next()){
								String id = resultSet.getString("id");
								String productName = resultSet.getString("product_name");
								String category = resultSet.getString("category");
								String retailer_name = resultSet.getString("retailer_name");
								int price = resultSet.getInt("price");
								int discount = resultSet.getInt("discount");
								String image = resultSet.getString("image");
								String description = resultSet.getString("description");

								Product product= new Product();
								product.setId(id);
								product.setName(productName);
								product.setCategory(category);
								product.setRetailer(retailer_name);
								product.setPrice(price);
								product.setDiscount(discount);
								product.setImage(image);
								product.setDescription(description);

								productList.add(product);
							}
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return productList;
	}
	
	public static void insertQueryForUserTable(String username, String password, String role) {
		Connection connection = getConnection();
		//String currentIdCount = getCurrentLargestIdInUserTable(connection);
		if (connection != null) {
			String sql = "INSERT into "+ USERTABLE +"(name,password,role) VALUES (?,?,?)";
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				preparedStatement.setString(1, username);
				preparedStatement.setString(2, password);
				preparedStatement.setString(3, role);
				
				preparedStatement.execute();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public static int checkIfUserExists(String username, String role){
		Connection connection = getConnection();
		int result = 0;
		if(connection != null){
			String sql = "SELECT u.name FROM "+ USERTABLE +" u WHERE u.name = ? AND u.role = ?";
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				preparedStatement.setString(1, username);
				preparedStatement.setString(2, role);
				
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
	
	public static void insertQueryForOrderTable(String orderId, String username, String productName, String oDate, String dDate, String totalAmount,String shippingAddress,HttpSession session) {
		Connection connection = getConnection();
		//String currentIdCount = getCurrentLargestIdInUserTable(connection);
		if (connection != null) {
			String sql = "INSERT into "+ORDERTABLE+"(order_Id,user_name,product_id,ordered_date,shipping_date,amount,shipping_address) VALUES (?,?,?,?,?,?,?)";
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				preparedStatement.setString(1, orderId);
				preparedStatement.setString(2, username);
				preparedStatement.setString(3, productName);
				preparedStatement.setString(4, oDate);
				preparedStatement.setString(5, dDate);
				preparedStatement.setString(6, totalAmount);
				preparedStatement.setString(7, shippingAddress);

				preparedStatement.execute();
				session.removeAttribute("shoppingItemId");
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static List<Map<String, String>> fetchOrdersByUserInfo(HttpSession session){
		Connection connection = getConnection();
		String role = (String) session.getAttribute("userRole");
		String userName = (String) session.getAttribute("userName");
		List<Map<String, String>> myOrdersMapList = new ArrayList<Map<String, String>>();
		
		if(connection != null && userName != null && role != null){
			String sql;
			if (role.equals(ROLE_SALESMAN)){
				sql = "SELECT o.order_Id,o.user_name,o.product_id,o.ordered_date,o.shipping_date,o.amount,o.shipping_address FROM "+ ORDERTABLE +" o";
			} else {
				sql = "SELECT o.order_Id,o.user_name,o.product_id,o.ordered_date,o.shipping_date,o.amount,o.shipping_address FROM "+ ORDERTABLE +" o WHERE o.user_name = ?";
			}
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				if (role.equals(ROLE_CUSTOMER)){
					preparedStatement.setString(1, userName);
					//preparedStatement.setString(2, role);
				}
				ResultSet rs = preparedStatement.executeQuery();
				if(rs != null){
					prepareMyOrdersMapFromResultSet(rs, myOrdersMapList);
				}
				
				connection.close();
				return myOrdersMapList;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	private static void prepareMyOrdersMapFromResultSet(ResultSet rs, List<Map<String, String>> myOrdersMapList){
		Map<String, String> myOrdersMap;
		try {
			while(rs.next()){
				myOrdersMap = new HashMap<String, String>();
				
				String orderId = (String) rs.getObject("order_id");
				String productId = (String) rs.getObject("product_id");
				Timestamp oDate = (Timestamp) rs.getObject("ordered_date");
				Timestamp dDate = (Timestamp) rs.getObject("shipping_date");
				String amount = (String) rs.getObject("amount");
				String shippingAddress = (String) rs.getObject("shipping_address");
				
				if(orderId != null){
					myOrdersMap.put("orderId", orderId);
				}
				if(productId != null){
					myOrdersMap.put("productId", productId);
				}
				if(oDate != null){
					myOrdersMap.put("oDate", oDate.toString());
				}
				if(dDate != null){
					myOrdersMap.put("dDate", dDate.toString());
				}
				if(amount != null){
					myOrdersMap.put("amount", amount);
				}
				if(shippingAddress != null){
					myOrdersMap.put("shippingAddress", shippingAddress);
				}
				myOrdersMapList.add(myOrdersMap);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void deleteOrder(String orderId){
		Connection connection = getConnection();
		String sql;
		if(connection != null){
			sql = "DELETE FROM "+ ORDERTABLE +" WHERE order_id = ?";
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
	
	private void createNewDatabaseIfRequired(Connection connection){
		String sql = "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = ?";
		PreparedStatement preparedStatement;
		try {
			preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
			preparedStatement.setString(1, "bestdealdatabase");
			
			ResultSet rs = preparedStatement.executeQuery();
			/*if(rs.next()){
				result = 1;
			} else {
				result = 0;
			}*/
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	private static String getCurrentLargestIdInUserTable(Connection connection) {
		String sql = "SELECT MAX(id) FROM USERS";
		String id = "";
		PreparedStatement preparedStatement;
		try {
			preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
			ResultSet rs = preparedStatement.executeQuery(sql);
			if(rs.next()){
				id = rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return id;
	}
}