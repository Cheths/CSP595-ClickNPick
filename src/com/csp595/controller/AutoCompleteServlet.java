package com.csp595.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.csp595.utilities.AjaxUtility;

public class AutoCompleteServlet extends HttpServlet {
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchValue = request.getParameter("searchValue");
		String actionType = request.getParameter("action");
		StringBuffer stringBuffer = new StringBuffer();
		boolean namesAdded = false;
		if(!(searchValue.equals(""))){
			stringBuffer = AjaxUtility.readData(searchValue);
			if(stringBuffer != null && !stringBuffer.equals("")){
				namesAdded = true;
			}
			if(namesAdded){
				response.setContentType("text/xml");
				response.getWriter().write("<products>" + stringBuffer.toString() + "</products>");
			}
		}
	}


}
