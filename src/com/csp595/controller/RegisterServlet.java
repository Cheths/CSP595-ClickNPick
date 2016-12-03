package com.csp595.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.csp595.utilities.MySqlUtil;

/*
 * Register Servlet to handle registering new user functionalities. 
 */
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	String isSalesman = " ";
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		isSalesman = request.getParameter("salesman") != null && !request.getParameter("salesman").isEmpty() ? "yes" : " ";
		String role = request.getParameter("role");
		HttpSession session = request.getSession(true);

		int flagUserExists = MySqlUtil.checkIfUserExists(username, role,null);
		if (flagUserExists == 1) {
			session.setAttribute("userCreationStatus", "Failure");
			System.out.println("Username Already Exists!");
			response.sendRedirect("register.jsp");
		} else {
			createUserAccount(username, password, role, request, response);
		}
	}

	private void createUserAccount(String username, String password, String role, HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		MySqlUtil.insertQueryForUserTable(request.getParameter("title"),request.getParameter("first_name"),request.getParameter("last_name"),request.getParameter("email_id"),
				password,request.getParameter("date_of_birth"),username,role,request.getParameter("address_1"),request.getParameter("address_2"),
				request.getParameter("city"),request.getParameter("state"),request.getParameter("zip"),	request.getParameter("country"),request.getParameter("phone"));
		if(isSalesman.isEmpty() && !isSalesman.equals("yes")){
			session.setAttribute("userName", username);
			session.setAttribute("userRole", role);			
		}
		session.setAttribute("userCreationStatus", "Success");
		try {
			response.sendRedirect("index.jsp");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
