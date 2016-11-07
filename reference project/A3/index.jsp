<!DOCTYPE html>
<%@page import="com.cheths.a1.main.SaxParserProductXMLdataStore"%>
<html>
<head>
<link rel="shortcut icon" href="themes/images/ico/favicon.ico">
<title>Best Deals</title>
</head>
<body>
<%	String homePath = System.getProperty("catalina.home").replace("\\", "/");
new SaxParserProductXMLdataStore(homePath+"/webapps/A3/Products.xml");
List<Product> productList = SaxParserProductXMLdataStore.getProductList(); %>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<%@include file="content.jsp" %>
<%@include file="footer.jsp" %>
</body>
</html>