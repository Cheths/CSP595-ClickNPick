<!DOCTYPE html>
<%@page import="com.csp595.beans.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.csp595.beans.Product"%>
<%@ page import = "com.csp595.utilities.*" %>
<%@ page import = "com.csp595.controller.*" %>
<%@page import="java.util.Map"%>
<%@page import="com.csp595.utilities.SaxParserProductXMLdataStore"%>
<html lang="en">
<head>
<link rel="shortcut icon" href="themes/images/ico/favicon.ico">
<title>Click N Pick</title>
</head>
<body>
<%@include file="header.jsp" %>
<%-- <%@include file="carousel.jsp" %> --%>
<%-- <%@include file="sidebar.jsp" %> --%>
<%-- <%@include file="content.jsp" %> --%>
<%-- <%@include file="footer.jsp" %> --%>
<%
	HashMap<String, User> users = new HashMap<String, User>();
	users = MySqlUtil.fetchAllUsers();
%>

<table class="table table-bordered" style="width:50%;align:center;">
	<thead id="productCheckout">
		<tr>
			<th> </th>
			<th>SL No. </th>
			<th>Username</th>
			<th>First Name</th>
			<th>Last Name</th>
		</tr>
	</thead>
	<%
	int i = 0;
	for(Map.Entry<String, User> entry: users.entrySet()){
		User usr = entry.getValue(); 
		String navigationURL = " ";
		navigationURL = "index.jsp?customerSelected="+usr.getUserName();
	%>	
	<tbody>
		<tr>
			<td></td>
			<td><%= ++i %></td>
<%-- 			<td><a href = "index.jsp?customerSelected="+<%= usr.getUserName()%> > <%=usr.getUserName() %> </a></td> --%>
			<td style="text-decoration: underline;"><a style="color:#08c!important;" href =<%=navigationURL %> > <%=usr.getUserName() %> </a></td> 	
			<td><%=usr.getFirstName() %></td>
			<td><%=usr.getLastName() %></td>
		</tr>
	</tbody>		
	<%} %>
</table>

</body>
</html>