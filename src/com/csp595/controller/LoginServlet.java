package com.csp595.controller;

import java.io.IOException;
import java.util.Calendar;

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
		session.removeAttribute("shoppingItemId");
		session.removeAttribute("totalAmount");
		session.removeAttribute("shippingInfoMap");
		session.removeAttribute("loginError");
		session.removeAttribute("userRegion");
		response.sendRedirect("index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String role = request.getParameter("role");
		String password =  request.getParameter("password");
		HttpSession session = request.getSession(true);
		
		int flagUserExists = MySqlUtil.checkIfUserExists(username, role,password);
		//gets the user region based on his/her registration details
		String userRegion = MySqlUtil.getUserRegion(username, role, password);
		if (flagUserExists == 1) {
			session.setAttribute("userName", username);
			session.setAttribute("userRole", role);
			session.setAttribute("userRegion", userRegion);
			String season = getSeason();//predicts the season based on the current month
			String clothingType = " ";
			clothingType = getRegionBasedClothingType(userRegion, season);//suggests the type of clothing basd on the region and season
			session.setAttribute("clothing_type", clothingType);
			response.sendRedirect("index.jsp");
		} else if (flagUserExists == -1){
			session.setAttribute("sqlError", "true");
			response.sendRedirect(request.getHeader("Referer"));
		} else {
			session.setAttribute("loginError", "true");
			response.sendRedirect("login.jsp");
		}
	}
	
	private String getSeason(){
		Calendar currentTime = Calendar.getInstance();
		
		int month = Calendar.getInstance().get(Calendar.MONTH); 
		if(month>=0 && month<4)
			return "Spring";
		else if(month>=4 && month<8)
			return "Summer";
		else if(month>=9 && month<=11)
			return "Fall or Winter";
		return "";
	}

	private String getRegionBasedClothingType(String userRegion, String season){
		String clothingType = " ";
		switch(userRegion){
		case "North":
				if(season.equalsIgnoreCase("Summer"))
				{
					clothingType = "Light linens";
				}
				else if(season.equalsIgnoreCase("Spring"))
				{
					clothingType = "Light linens";
				}
				else if(season.equalsIgnoreCase("Fall or Winter"))
				{
					clothingType = "Heavy and warm. Fully covered.";
				}
			break;
		case "South":
			if(season.equalsIgnoreCase("Summer"))
			{
				clothingType = "Light linens";
			}
			else if(season.equalsIgnoreCase("Spring"))
			{
				clothingType = "Light and transparent";
			}
			else if(season.equalsIgnoreCase("Fall or Winter"))
			{
				clothingType = "Warm clothing";
			}
			break;
		case "East":
			if(season.equalsIgnoreCase("Summer"))
			{
				clothingType = "Summer clothes";
			}
			else if(season.equalsIgnoreCase("Spring"))
			{
				clothingType = "Light linens";
			}
			else if(season.equalsIgnoreCase("Fall or Winter"))
			{
				clothingType = "Heavy and warm";
			}
			break;
		case "West":
			if(season.equalsIgnoreCase("Summer"))
			{
				clothingType = "Light linens";
			}
			else if(season.equalsIgnoreCase("Spring"))
			{
				clothingType = "Light linens";
			}
			else if(season.equalsIgnoreCase("Fall or Winter"))
			{
				clothingType = "Heavy and warm";
			}
			break;
		case "NorthEast":
			if(season.equalsIgnoreCase("Summer"))
			{
				clothingType = "Thick summer";
			}
			else if(season.equalsIgnoreCase("Spring"))
			{
				clothingType = "Light full body covers";
			}
			else if(season.equalsIgnoreCase("Fall or Winter"))
			{
				clothingType = "Thich and snow wear";
			}
			break;
		case "NorthWest":
			if(season.equalsIgnoreCase("Summer"))
			{
				clothingType = "Light linens";
			}
			else if(season.equalsIgnoreCase("Spring"))
			{
				clothingType = "Light linens";
			}
			else if(season.equalsIgnoreCase("Fall or Winter"))
			{
				clothingType = "Heavy and warm";
			}
			break;
		case "SouthEast":
			if(season.equalsIgnoreCase("Summer"))
			{
				clothingType = "Light linens";
			}
			else if(season.equalsIgnoreCase("Spring"))
			{
				clothingType = "Light sporty";
			}
			else if(season.equalsIgnoreCase("Fall or Winter"))
			{
				clothingType = "Heavy and warm";
			}
			break;
		case "SouthWest":
			if(season.equalsIgnoreCase("Summer"))
			{
				clothingType = "Light linens";
			}
			else if(season.equalsIgnoreCase("Spring"))
			{
				clothingType = "Light linens";
			}
			else if(season.equalsIgnoreCase("Fall or Winter"))
			{
				clothingType = "Light linens";
			}
			break;
		default:
			clothingType = "Tropical";
			break;
	}
		return clothingType;
	}
}