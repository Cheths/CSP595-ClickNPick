<!DOCTYPE html>
<%@page import="com.csp595.beans.Product"%>
<%@page import="java.util.Map"%>
<%@page import="com.csp595.utilities.SaxParserProductXMLdataStore"%>
<html lang="en">
<head>
<link rel="shortcut icon" href="themes/images/ico/favicon.ico">
<title>Click N Pick</title>
</head>
<body>
<% String homePath = System.getProperty("catalina.home").replace("\\", "/");
new SaxParserProductXMLdataStore(homePath+"/webapps/A1/Products.xml"); %>
<%@include file="header.jsp" %>
<%@include file="carousel.jsp" %>
<%@include file="sidebar.jsp" %>
<%@include file="content.jsp" %>
<%@include file="footer.jsp" %>
</body>
</html>