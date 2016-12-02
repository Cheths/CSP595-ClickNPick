<!DOCTYPE html>
<%@page import="com.csp595.utilities.PrepareXmlFile"%>
<%@page import="com.csp595.beans.Product"%>
<%@page import="java.util.Map"%>
<%@page import="com.csp595.utilities.SaxParserProductXMLdataStore"%>
<html lang="en">
<head>
<link rel="shortcut icon" href="themes/images/ico/favicon.ico">
<title>Click N Pick</title>
</head>
<body>
<% 
//PrepareXmlFile.prepareXmlFile();//Don't uncomment it.
if(request.getParameter("customerSelected") != null ){
	session.setAttribute("customerSelected", request.getParameter("customerSelected"));
}
String homePath = System.getProperty("catalina.home").replace("\\", "/");
new SaxParserProductXMLdataStore(homePath+"/webapps/CSP595-ClicknPick/Scripts/Products.xml", request,session); %>
<%@include file="header.jsp" %>
<%@include file="carousel.jsp" %>
<% if(session.getAttribute("userRole") != null && session.getAttribute("userRole").toString().equalsIgnoreCase("Salesman")){
%>
<!-- 	<a href="register.jsp"><span class="btn btn-large btn-success">Create User</span></a> -->
<!-- 	<a href="salesman_operations.jsp"><span class="btn btn-large btn-success">Create Order</span></a> -->
<%}else{ %>
<%@include file="sidebar.jsp" %>
<%@include file="content.jsp" %>
<%}%>
<%
if(session.getAttribute("customerSelected") != null){
%>
	<%@include file="sidebar.jsp" %>
	<%@include file="content.jsp" %>
<% }%>
<%@include file="footer.jsp" %>
</body>
</html>