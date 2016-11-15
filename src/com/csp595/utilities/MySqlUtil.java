package com.csp595.utilities;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.csp595.beans.Product;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

public class MySqlUtil {

	static final String DB_URL = "jdbc:mysql://localhost:3306/db_clicknpick";
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String USERTABLE = "USER";
	static final String ORDERTABLE = "ORDERS";
	static final String PRODUCTTABLE = "PRODUCT";
	
	static final String ROLE_CUSTOMER = "Customer";
	static final String ROLE_SALESMAN = "Salesman";
	static final String ROLE_STORE_MANAGER = "Store Manager";
	
	static final String P_ID_COL = "id";
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
	public static int checkIfUserExists(String username, String role){
		Connection connection = getConnection();
		int result = 0;
		if(connection != null){
			String sql = "SELECT u.username FROM "+ USERTABLE +" u WHERE u.username = ? AND u.role = ?";
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
	
	public static void insertQueryForUserTable(String username, String password, String role) {
		Connection connection = getConnection();
		if (connection != null) {
			String sql = "INSERT into "+ USERTABLE +"(username,password,role) VALUES (?,?,?)";
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				preparedStatement.setString(1, username);
				preparedStatement.setString(2, password);
				preparedStatement.setString(3, role);
				//preparedStatement.setInt(4, 11);
				
				preparedStatement.execute();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static Map<String, Product> getAllProductMap(){
		Map<String, Product> productHashMap = new HashMap<String, Product>();
		Product product;
		Connection connection = getConnection();
		if(connection != null){
			String sql = "SELECT * FROM "+PRODUCTTABLE;
			PreparedStatement preparedStatement;
			try {
				preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
				ResultSet resultSet = preparedStatement.executeQuery();
				while(resultSet.next()){
					product = new Product(resultSet.getString(P_ID_COL), resultSet.getString(P_NAME_COL), resultSet.getString(P_CAT_COL), resultSet.getInt(P_PRICE_COL), 
							resultSet.getInt(P_DISCOUNT_COL), resultSet.getString(P_MFG_COL), resultSet.getString(P_COND_COL), resultSet.getString(P_DESC_COL), resultSet.getString(P_IMAGE_COL));
					productHashMap.put(resultSet.getString(P_ID_COL), product);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return productHashMap;
	}
}
