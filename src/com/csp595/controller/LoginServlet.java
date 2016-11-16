package com.csp595.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.csp595.utilities.MySqlUtil;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.removeAttribute("userName");
		session.removeAttribute("userRole");
		session.removeAttribute("userCreationStatus");
		session.removeAttribute("sqlError");
		session.removeAttribute("loginError");
		response.sendRedirect("index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String role = request.getParameter("role");
		String password =  request.getParameter("password");
		HttpSession session = request.getSession(true);
		
		int flagUserExists = MySqlUtil.checkIfUserExists(username, role,password);
		if (flagUserExists == 1) {
			session.setAttribute("userName", username);
			session.setAttribute("userRole", role);
			response.sendRedirect("index.jsp");
		} else if (flagUserExists == -1){
			session.setAttribute("sqlError", "true");
			response.sendRedirect(request.getHeader("Referer"));
		} else {
			session.setAttribute("loginError", "true");
			response.sendRedirect(request.getHeader("Referer"));
		}
	}

}
