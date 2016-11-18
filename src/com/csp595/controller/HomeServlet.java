package com.csp595.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.csp595.utilities.MySqlUtil;
import com.csp595.utilities.ProductHelper;
import com.csp595.utilities.SaxParserProductXMLdataStore;


public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public HomeServlet() {
    	String homePath = System.getProperty("catalina.home").replace("\\", "/");
		new SaxParserProductXMLdataStore(homePath+"/webapps/A1/Products.xml");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String makePayment = request.getParameter("makePayment");
		HttpSession session = request.getSession();
		if(makePayment != null){
			String orderId = "";
			String shippingAddress = null;
			String city = null;
			String state = null;
			String zipCode = null;
			String country = null;
			String phone = null;

			String cardNo = request.getParameter("cardNumber");
			String nameOnCard = request.getParameter("name");
			String cardExpDate = request.getParameter("expiryDate");
			String cvv = request.getParameter("cvv");

			String shoppingItemIds = (String) session.getAttribute("shoppingItemId");
			String checkOutAmount = (String) session.getAttribute("checkoutAmount");
			String orderedDate = ProductHelper.getOrderedDate();
			String expectedDeliveryDate = ProductHelper.getExpectedDeliveryDate();
			String userName = (String) session.getAttribute("userName");

			Map<String,String> shippingInfoMap = (Map<String,String>) session.getAttribute("shippingInfoMap");
			if(shippingInfoMap != null){
				shippingAddress = shippingInfoMap.get("address");
				city = shippingInfoMap.get("city");
				state = shippingInfoMap.get("state");
				zipCode = shippingInfoMap.get("postcode");
				country = shippingInfoMap.get("country");
				phone = shippingInfoMap.get("phone");
			}

			try {
				orderId = ProductHelper.generateProductOrderId(Calendar.getInstance().getTime());
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}

			MySqlUtil.insertQueryForOrderTable(orderId, shoppingItemIds, userName, Double.parseDouble(checkOutAmount), orderedDate, expectedDeliveryDate, shippingAddress, "shipAddress2", city,
					state, country, zipCode, cardNo, nameOnCard, cvv, cardExpDate, phone, session);


			request.setAttribute("shoppingItemIds", shoppingItemIds);
			request.setAttribute("orderedDate", orderedDate);
			request.setAttribute("expectedDeliveryDate", expectedDeliveryDate);
			request.setAttribute("orderId", orderId);
			RequestDispatcher dispatcher = request.getRequestDispatcher("order_summary.jsp");
			dispatcher.forward(request, response);

		}
	}

}
