package com.csp595.utilities;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.csp595.beans.Product;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

public class MySqlUtil {

	static final String DB_URL = "jdbc:mysql://localhost:3306/db_clicknpick";
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String USERTABLE = "USER";
	static final String ORDERTABLE = "USER_ORDER_INFO";
	static final String PRODUCTTABLE = "PRODUCT";
	
	static final String ROLE_CUSTOMER = "Customer";
	static final String ROLE_SALESMAN = "Salesman";
	static final String ROLE_STORE_MANAGER = "Store Manager";
	
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
}
