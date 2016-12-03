package com.csp595.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;

import com.csp595.beans.Coupon;
import com.csp595.utilities.*;

import com.csp595.utilities.MySqlUtil;


@WebServlet("/ValidateCouponServlet")
public class ValidateCouponServlet extends HttpServlet {
	
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String couponCode = request.getParameter("couponCode");
		String shopItemId = request.getParameter("shopItemId");
		boolean isValid = false;
		if(!couponCode.isEmpty() && couponCode != null){
			response.setContentType("text/xml");
			Coupon coupon = null;
			try {
				coupon = MySqlUtil.validateCoupon(couponCode, request);
				if( coupon != null && coupon.getIsUsed().equalsIgnoreCase("no")){
					
					MySqlUtil.UpdateCoupon(coupon);
					
//					RequestDispatcher dispatcher = request.getRequestDispatcher("admin_operations.jsp");
//					dispatcher.forward(request, response);
					RequestDispatcher disp = request.getRequestDispatcher("product_summary.jsp?fromCouponValidation="+shopItemId+"&isValid=yes&disc="+coupon.getDiscount());
					disp.forward(request, response);
//					response.sendRedirect("product_summary.jsp?fromCouponValidation="+shopItemId+"isValid=yes&disc="+coupon.get("discount"));	
					}
				else if(coupon != null && coupon.getIsUsed().equalsIgnoreCase("yes")){
					RequestDispatcher disp = request.getRequestDispatcher("product_summary.jsp?fromCouponValidation="+shopItemId+"&isValid=no&disc="+coupon.getDiscount()+"&alreadyUsed=yes");
					disp.forward(request, response);
				}else
					response.sendRedirect("product_summary.jsp?fromCouponValidation="+shopItemId+"&isValid=no&disc=0");	
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
