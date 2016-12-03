<!DOCTYPE html>
<%@page import="com.csp595.utilities.SaxParserProductXMLdataStore"%>
<%@page import="java.util.Map"%>
<%@page import="com.csp595.beans.Product"%>
<%@page import="java.util.Map.Entry"%>
<html lang="en">
<head>
<link rel="shortcut icon" href="themes/images/ico/favicon.ico">
<title>Click N Pick</title>
</head>
<body>
	<%
		String homePath = System.getProperty("catalina.home").replace("\\", "/");
	new SaxParserProductXMLdataStore(homePath+"/webapps/CSP595-ClicknPick/Scripts/Products.xml", request,session); %>
	<%@include file="header.jsp"%>
	<%-- <%@include file="carousel.jsp" %> --%>
	<%@include file="sidebar.jsp"%>
	<div id="mainBody">
		<div class="container">
			<div class="row">
				<div class="span9">
					<%
						String gender = request.getParameter("gender");
						String category = request.getParameter("category");
					%>



					<ul class="thumbnails">
						<%
							if (!productHashMap.isEmpty()) {
								for (Entry<String, Product> productEntry : productHashMap.entrySet()) {
									Product product = productEntry.getValue();
									if (product.getGender().equals(gender) && product.getCategory().equals(category)) {
						%>
						<li class="span3">
							<div class="thumbnail">
								<a href="product_details.jsp?productId=<%=product.getId()%>">
									<img src="themes/images/products/new/<%=product.getImage()%>"
									alt="" />
								</a>
								<div class="caption">
									<h4>
										<center>
											<B><%=product.getName()%></B>
										</center>
									</h4>
									<h5><%=product.getDescription()%></h5>
									<h4 style="text-align: center">
										<%
											if (userName != null) {
										%>
										<a class="btn"
											href="product_summary.jsp?shoppingItemId=<%=product.getId()%>">
											Add to <i class="icon-shopping-cart"></i>
										</a>
										<%
											} else {
										%>
										<a class="btn" href="login.jsp"> Add to <i
											class="icon-shopping-cart"></i></a>
										<%
											}
										%>
										<a class="btn btn-primary" href="#"><%=product.getPrice()%></a>
										<a class="btn btn-primary"
											href="write_product_reviews.jsp?showReviewSection=<%=product.getId()%>"
											style="width: 130px">Write Review</a> <a
											class="btn btn-primary"
											href="read_product_reviews.jsp?readProductReview=<%=product.getId()%>"
											style="width: 130px">View Reviews</a>
									</h4>
								</div>
							</div>
						</li>
						<%
							}
								}
							}
						%>
					</ul>





				</div>
			</div>
		</div>
	</div>




	<%@include file="footer.jsp"%>
</body>
</html>