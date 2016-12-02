package com.csp595.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.csp595.utilities.MongoUtil;
import com.csp595.utilities.MySqlUtil;
import com.csp595.utilities.ProductHelper;
import com.mongodb.MongoTimeoutException;



public class UtilityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String shoppingItemIds = (String) session.getAttribute("shoppingItemId");
		String removeItem = request.getParameter("removeItem");
		String couponCode = request.getParameter("couponCode");
		
		if(removeItem != null){
			List<String> shoppingItemIdsList = new ArrayList<>(Arrays.asList(shoppingItemIds.split(",")));
			List<String> tempshoppingItemIdsList = shoppingItemIdsList;
			for (String tempShoppingItemId : tempshoppingItemIdsList) {
				if(tempShoppingItemId.equals(removeItem)){
					shoppingItemIdsList.remove(tempShoppingItemId);
					break;
				}
			}
			if(shoppingItemIdsList != null){
				String str = shoppingItemIdsList.toString();
				session.setAttribute("shoppingItemId", str.substring(1, str.length()-1));
			}
			response.sendRedirect("product_summary.jsp");
		} else if(couponCode != null){
			MySqlUtil.insertQueryForCouponTable(request.getParameter("couponCode"), request.getParameter("userBase"), request.getParameter("discount"));
			request.setAttribute("addCouponSuccess", true);
			RequestDispatcher dispatcher = request.getRequestDispatcher("admin_operations.jsp");
			dispatcher.forward(request, response);
		}
		//response.sendRedirect("index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String makePayment = request.getParameter("makePayment");
		if(makePayment != null){
			generateOrderAndCompleteTransaction(request, response, session);
		}else if (request.getParameter("writeReview") != null) {
			insertReviewIntoMongoDB(request, response, session);
		}else if(request.getParameter("insertDonations") != null){
			insertIntoDonationsTable(request,response,session);
		}
	}

	private void insertIntoDonationsTable(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		MySqlUtil.insertIntoDonations((String)session.getAttribute("userName"), request.getParameter("quantity"), request.getParameter("organization"),
				request.getParameter("pickup_date"), request.getParameter("pickup_location"),response);
	}

	private void generateOrderAndCompleteTransaction(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
		String orderId = "";
		String shippingAddress = null;
		String city = null;
		String state = null;
		String zipCode = null;
		String country = null;
		String phone = null;
		String mailId = null;

		String cardNo = request.getParameter("cardNumber");
		String nameOnCard = request.getParameter("name");
		String cardExpDate = request.getParameter("expiryDate");
		String cvv = request.getParameter("cvv");

		String shoppingItemIds = (String) session.getAttribute("shoppingItemId");
		String checkOutAmount = (String) session.getAttribute("checkoutAmount");
		String orderedDate = ProductHelper.getOrderedDate();
		String expectedDeliveryDate = ProductHelper.getExpectedDeliveryDate();
		String userName =  " ";
		if(session.getAttribute("customerSelected")!=null){
			//for salesman
			userName = (String) session.getAttribute("customerSelected");
			session.removeAttribute("customerSelected");
		}
			
		else
			userName = (String) session.getAttribute("userName");
		

		Map<String, String> shippingInfoMap = (Map<String, String>) session.getAttribute("shippingInfoMap");
		if (shippingInfoMap != null) {
			shippingAddress = shippingInfoMap.get("address");
			city = shippingInfoMap.get("city");
			state = shippingInfoMap.get("state");
			zipCode = shippingInfoMap.get("postcode");
			country = shippingInfoMap.get("country");
			phone = shippingInfoMap.get("phone");
			mailId = shippingInfoMap.get("emailId");
		}

		try {
			orderId = ProductHelper.generateProductOrderId(Calendar.getInstance().getTime());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		MySqlUtil.insertQueryForOrderTable(orderId, shoppingItemIds, userName, Double.parseDouble(checkOutAmount),
				orderedDate, expectedDeliveryDate, shippingAddress, "shipAddress2", city, state, country, zipCode,
				cardNo, nameOnCard, cvv, cardExpDate, phone, session);

		StringBuilder mailBody = new StringBuilder();
		mailBody.append("Order Summary:\n");
		mailBody.append("Ordered date - "+orderedDate+"\n");
		mailBody.append("Expected Delivery date - "+expectedDeliveryDate+"\n");
		mailBody.append("Order Amount - $"+checkOutAmount+"\t");
		
		ProductHelper.sendOrderConfirmationMail(mailId, orderId, mailBody.toString());
		request.setAttribute("shoppingItemIds", shoppingItemIds);
		request.setAttribute("orderedDate", orderedDate);
		request.setAttribute("expectedDeliveryDate", expectedDeliveryDate);
		request.setAttribute("orderId", orderId);
		RequestDispatcher dispatcher = request.getRequestDispatcher("order_summary.jsp");
		dispatcher.forward(request, response);

	}

	private void sendOrderConfirmationMail(String mailId, String orderId, String mailBody) {
		String fromAddress = "clicknpickapp@gmail.com";
		String host = "smtp.gmail.com";
		String password = "Qwerty@12";
		
		Properties properties = System.getProperties();
		
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.socketFactory.port", "465");
		properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.port", "465");
		
		Session session = Session.getDefaultInstance(properties, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication(fromAddress, password);
			}
		});
		
		
		MimeMessage message = new MimeMessage(session);
		try {
			message.setFrom(new InternetAddress("system@ClickNPick.com"));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(mailId));
			message.setSubject("Order Placed Successfully #"+orderId+"");
			message.setText(mailBody);
			
			Transport.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	private void insertReviewIntoMongoDB(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws ServletException, IOException ,MongoTimeoutException{
		try {
			MongoUtil.insertProductReview(request.getParameter("manufacturerName"),
					request.getParameter("productCategory"), request.getParameter("productName"),
					request.getParameter("productId"), request.getParameter("productPrice"),
					request.getParameter("retailerCity"), request.getParameter("retailerName"),
					request.getParameter("retailerState"), request.getParameter("retailerZip"),
					request.getParameter("reviewRating"), request.getParameter("reviewDate"),
					request.getParameter("reviewText"), request.getParameter("userAge"),
					(String) session.getAttribute("userName"), request.getParameter("userGender"),
					request.getParameter("userOccupation"));
			request.getRequestDispatcher("index.jsp").forward(request, response);
		} catch (MongoTimeoutException e) {
			request.setAttribute("mongoConnectionError", "true");
			request.getRequestDispatcher("index.jsp").forward(request, response);
			e.printStackTrace();
		} catch (Exception e){
			request.setAttribute("mongoConnectionError", "true");
			request.getRequestDispatcher("index.jsp").forward(request, response);
			e.printStackTrace();
		}
	}

}
