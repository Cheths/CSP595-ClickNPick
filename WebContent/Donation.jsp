<!DOCTYPE html>
<%@page import="com.csp595.beans.Product"%>
<%@page import="java.util.Map"%>
<%@page import="com.csp595.utilities.SaxParserProductXMLdataStore"%>
<%@page import="java.util.Map.Entry"%>
<html lang="en">

<head>
<link rel="shortcut icon" href="themes/images/ico/favicon.ico">
<title>Click N Pick</title>
</head>


<body>
<% String homePath = System.getProperty("catalina.home").replace("\\", "/");
new SaxParserProductXMLdataStore(homePath+"/webapps/A1/Products.xml"); %>
<%@include file="header.jsp" %>
<%-- <%@include file="carousel.jsp" %> --%>
<%@include file="sidebar.jsp" %>


<% String userCreationStatus = (String) session.getAttribute("userCreationStatus"); 
		if(userCreationStatus != null){
			if(userCreationStatus.equals("Success")){%>
	 		<div>User created successfully!</div>
	 	<%} else {%>
	 		<div>Invalid Credentials!</div>
	 	<% }}
	 %>
	<div id="mainBody">
	<div class="container">
	<div class="row">
	<div class="span9">
		<% if(request.getParameter("writeReview") != null){
		%>
		<div class="alert" style="background-color: #5bb75b;">
		 <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
		 <strong>Success!</strong> Review Successfully Submitted
		</div>
		<%}else if(request.getAttribute("mongoConnectionError") != null){ %>
		<div class="alert" style="background-color: #f44336;">
		 <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
		 <strong>Failure!</strong>Unable to submit review as Mongo Db is not connected
		</div>
		<%} %>
			<img src="${pageContext.request.contextPath}/themes/images/donation.jpg"/>
		<h4>Donate The Clothes </h4>
			  <ul class="thumbnails">
			<%
				if (!productHashMap.isEmpty()) {
					for (Entry<String, Product> productEntry :productHashMap
							
							.entrySet()) {
						Product product = productEntry.getValue();
			%>
			<li class="span3">
				<div class="thumbnail">
					<a href="product_details.jsp?productId=<%=product.getId()%>"><img
						src=<%= product.getImage() %> alt="" /></a>
					<div class="caption">
						<h5><%=product.getName() %></h5>
						<h4 style="text-align: center">
							<a class="btn" href="product_summary.jsp?shoppingItemId=<%=product.getId()%>"> Donate <i class="icon-shopping-cart"></i></a> 
							<a class="btn btn-primary" href="#"><%=product.getPrice() %></a>
							<a class="btn btn-primary" href="write_product_reviews.jsp?showReviewSection=<%=product.getId()%>" style="width:130px">Write Review</a>
					<%-- 	<a class="btn btn-primary" href="read_product_reviews.jsp?readProductReview=<%=product.getId()%>"  style="width:130px">View Reviews</a>
					 --%>	
					 
					 </h4>
					</div>
				</div>
			</li>
			
			
			<%
				}
				}
			%>
		</ul>	
<img src="${pageContext.request.contextPath}/themes/images/donation1.jpg"/>
		</div>		
		</div>
	</div>
</div>

			
		<!-- === -->
</body>
</html>



<%@include file="footer.jsp" %>
</body>
</html>