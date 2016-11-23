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
		}
		response.sendRedirect("product_summary.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String makePayment = request.getParameter("makePayment");
		if(makePayment != null){
			generateOrderAndCompleteTransaction(request, response, session);
		}else if (request.getParameter("writeReview") != null) {
			insertReviewIntoMongoDB(request, response, session);
		}
	}

	private void generateOrderAndCompleteTransaction(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
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

		Map<String, String> shippingInfoMap = (Map<String, String>) session.getAttribute("shippingInfoMap");
		if (shippingInfoMap != null) {
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

		MySqlUtil.insertQueryForOrderTable(orderId, shoppingItemIds, userName, Double.parseDouble(checkOutAmount),
				orderedDate, expectedDeliveryDate, shippingAddress, "shipAddress2", city, state, country, zipCode,
				cardNo, nameOnCard, cvv, cardExpDate, phone, session);

		//sendMail();
		request.setAttribute("shoppingItemIds", shoppingItemIds);
		request.setAttribute("orderedDate", orderedDate);
		request.setAttribute("expectedDeliveryDate", expectedDeliveryDate);
		request.setAttribute("orderId", orderId);
		RequestDispatcher dispatcher = request.getRequestDispatcher("order_summary.jsp");
		dispatcher.forward(request, response);

	}

	private void sendMail() {
		String toAddress = "cheths6242@gmail.com";
		String fromAddress = "admin@ClickNPick.com";
		String host = "mail.google.com";
		String userName = "cheths6242@gmail.com";
		String password = "xxxxxxxx";
		
		Properties properties = System.getProperties();
		/*properties.setProperty("mail.smtp.host", host);
		properties.put("mail.smtp.starttls.enable", "true");
		properties.setProperty("mail.smtp.auth", "true");
		properties.put("mail.smtp.port", "587");*/
		
		properties.put("mail.smtp.host", "smtp.mail.com");
		properties.put("mail.smtp.socketFactory.port", "465");
		properties.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		properties.put("mail.smtp.auth", "false");
		properties.put("mail.smtp.port", "465");
		
		Session session = Session.getDefaultInstance(properties, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication(null,null);
			}
		});
		
		MimeMessage message = new MimeMessage(session);
		try {
			message.setFrom(new InternetAddress(fromAddress));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(toAddress));
			message.setSubject("Test Mail");
			message.setText("This is a Test mail");
			
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
