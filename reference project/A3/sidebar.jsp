<%@page import="com.cheths.a1.main.Product"%>
<!DOCTYPE html">
<html lang="en">
<head>
<meta charset="utf-8">
<title>Best Deals</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link id="callCss" rel="stylesheet"
	href="themes/bootshop/bootstrap.min.css" media="screen" />
<link href="themes/css/base.css" rel="stylesheet" media="screen" />
<link href="themes/css/bootstrap-responsive.min.css" rel="stylesheet" />
<link href="themes/css/font-awesome.css" rel="stylesheet"
	type="text/css">
<link href="themes/js/google-code-prettify/prettify.css"
	rel="stylesheet" />
<link rel="shortcut icon" href="themes/images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="themes/images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="themes/images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="themes/images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="themes/images/ico/apple-touch-icon-57-precomposed.png">
<style type="text/css" id="enject"></style>
</head>
<body>
	<div id="sidebar" class="span3">
		<ul id="sideManu" class="nav nav-tabs nav-stacked"
			style="height: 750px">
			<li class="subMenu open">Category</li>
			<%@page import="java.util.*" %>
			
			<%
			 List<String> tempProductList = new ArrayList<String>();
			 //List<Product> productList = SaxParserProductXMLdataStore.getProductList();
			 for (Product product : productList) {
					String productCategory = product.getCategory();
					if (!tempProductList.contains(productCategory)) {
						tempProductList.add(product.getCategory());
			%>
			<li><a class="active" href="index.jsp?category=<%=productCategory %>"><i class="icon-chevron-right"></i><%=productCategory %></a></li>
			<% } } %>
			<div class="thumbnail">
				<ul id="css3menu1" class="topmenu">
					<li class="switch"><label onclick="" for="css3menu-switcher"></label>
					</li>
					<li class="toplast" style="padding-bottom: 30px;"><img
						src="themes/images/trending now1.png" alt="" style="width: 13%">
						<a href="index.jsp?trendingNow=true"
						style="height: 50px; line-height: 50px; padding-left: 10px">Trending
							Now</a></li>
				</ul>
				<img src="themes/images/payment_methods.png"
					title="Bootshop Payment Methods" alt="Payments Methods"></img>
				<div class="caption">
					<h5>Payment Methods</h5>
				</div>
			</div>
		</ul>
	</div>
</body>
</html>