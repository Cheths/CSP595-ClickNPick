package com.csp595.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.csp595.utilities.MySqlUtil;

public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String role = request.getParameter("role");
		HttpSession session = request.getSession(true);

		int flagUserExists = MySqlUtil.checkIfUserExists(username, role);
		if (flagUserExists == 1) {
			session.setAttribute("userCreationStatus", "Failure");
			System.out.println("Username Already Exists!");
			response.sendRedirect("index.jsp");
		} else {
			createUserAccount(username, password, role, request, response);
		}
	}

	private void createUserAccount(String username, String password, String role, HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		MySqlUtil.insertQueryForUserTable(username, password, role);
		
		session.setAttribute("userName", username);
		session.setAttribute("userRole", role);
		session.setAttribute("userCreationStatus", "Success");
		try {
			response.sendRedirect("index.jsp");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
