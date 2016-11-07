<!DOCTYPE html>
<%@page import="com.cheths.a1.main.ProductHelper"%>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Best Deals</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<!-- Bootstrap style -->
<link id="callCss" rel="stylesheet"
	href="themes/bootshop/bootstrap.min.css" media="screen" />
<link href="themes/css/base.css" rel="stylesheet" media="screen" />
<!-- Bootstrap style responsive -->
<link href="themes/css/bootstrap-responsive.min.css" rel="stylesheet" />
<link href="themes/css/font-awesome.css" rel="stylesheet"
	type="text/css">
<!-- Google-code-prettify -->
<link href="themes/js/google-code-prettify/prettify.css"
	rel="stylesheet" />
<!-- fav and touch icons -->
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
	<script type="text/javascript">
		function validatePassword() {
			var password = document.forms["SignupForm"]["inputPassword"].value;
			var confirmPassword = document.forms["SignupForm"]["confirmPassword"].value;
			if (password != confirmPassword) {
				alert("Passwords doesn't match");
				return false;
			}
			return true;
		};
	</script>

	<jsp:useBean id="MySQLDataStoreUtilities"
		class="com.cheths.a1.main.MySQLDataStoreUtilities"></jsp:useBean>
	<%
		String userName = ((session.getAttribute("userName")) != null) ? ((String) session.getAttribute("userName")):request.getParameter("username");
		String role = ((session.getAttribute("userRole")) != null) ? ((String) session.getAttribute("userRole")):request.getParameter("role");
		String password = request.getParameter("password");
		String logout = request.getParameter("logout");
		String signup = request.getParameter("signup");
		int flagUserExists = MySQLDataStoreUtilities.checkIfUserExists(userName, role);
		
		String shopItemId = request.getParameter("shoppingItemId");
		
	%>

	<div id="header">
		<div class="container">
			<div id="welcomeLine" class="row">
				<%
					if ((userName != null) && (logout == null) && (flagUserExists == 1)) {
				%>
				<div class="span6">
					Welcome<strong> <%=userName%>!
					</strong>
				</div>
				<%
					} else {
				%>
				<div class="span6">
					Welcome!<strong> User</strong>
				</div>
				<%
					}
				%>
				<div class="span6">
					<div class="pull-right">
						<%
						String productIds = "";
						if(shopItemId != null){
							String existingShoppingItemIds = (String) session.getAttribute("shoppingItemId");
							productIds = shopItemId;
							String[] shoppingItemList = {};
							
							if (productIds != null) {
								if (existingShoppingItemIds != null) {
									productIds = productIds + "," + existingShoppingItemIds;
								}
								shoppingItemList = productIds.split(",");
							}
							session.setAttribute("shoppingItemId", productIds);
						}
							String shoppingItems = (String) session.getAttribute("shoppingItemId");
							int myCartItemsCount = ProductHelper.getMyCartCount(shoppingItems);
							String countString;
							if (myCartItemsCount != 0) {
								countString = "(" + myCartItemsCount + ")";
							} else {
								countString = "";
							}
						%>
						<a href="index.jsp?myCart=true"><span
							class="btn btn-mini btn-primary"><i
								class="icon-shopping-cart icon-white"></i> My Cart<%=countString%>
						</span> </a>
					</div>
				</div>
			</div>
			<!-- Navbar ================================================== -->
			<div id="logoArea" class="navbar">
				<a id="smallScreen" data-target="#topMenu" data-toggle="collapse"
					class="btn btn-navbar"> <span class="icon-bar"></span> <span
					class="icon-bar"></span> <span class="icon-bar"></span>
				</a>
				<div class="navbar-inner">
					<a class="brand" href="index.jsp"><img
						src="themes/images/logo11.png" alt="Best Deals" /></a>
					<form class="form-inline navbar-search" method="post"
						action="index.jsp">
						<input class="srchTxt" type="text" placeholder="Search" />
						<button type="submit" id="submitButton" class="btn btn-primary">Go</button>
					</form>
					<ul id="topMenu" class="nav pull-right">

						<li><a href="index.jsp?myOrders=true">My Orders</a></li>
						<%
							if (role != null) {
								if (role.equals("Store Manager")) {
						%>
						<li><a href="index.jsp?isDataAnalytics="true"">Data
								Analytics</a></li>
						<%
							}
							}
						%>
						<%
							if (signup != null) {
								MySQLDataStoreUtilities.insertQueryForUserTable(userName, password, role);
								if (flagUserExists == 0) {
									session.setAttribute("userName", userName);
									session.setAttribute("userRole", role);
									session.setAttribute("userCreated", true);
						%>
						<a href="index.jsp?logout=true"><span
							class="btn btn-large btn-success" style="margin-top: 14px;">Log
								Out</span></a>
						<%
							} else {
									session.setAttribute("userCreated", false);
								}
							} else if (logout != null) {
								session.removeAttribute("userName");
								session.removeAttribute("userRole");
								session.removeAttribute("userCreated");
								session.removeAttribute("loginError");
								session.removeAttribute("userId");
								session.removeAttribute("checkOutAmount");
								session.removeAttribute("shoppingItemId");
								session.removeAttribute("shippingInfoMap");
								session.removeAttribute("paymentInfoMap");
								session.removeAttribute("orderId");
								session.removeAttribute("reloadContent");
								session.removeAttribute("productReviewId");
						%>
						<a href="#signup" id="loginbtn" role="button" data-toggle="modal"
							style="padding-right: 0"> <span
							class="btn btn-large btn-success" style="margin-top: 14px;">Signup</span></a>
						<a href="#login" id="loginbtn" role="button" data-toggle="modal"
							style="padding-right: 0"><span
							class="btn btn-large btn-success" style="margin-top: 14px;">Login</span></a>
						<%
							} else if (flagUserExists == 1) {
								session.setAttribute("userName", userName);
								session.setAttribute("userRole", role);
						%>
						<a href="index.jsp?logout=true"><span
							class="btn btn-large btn-success" style="margin-top: 14px;">Log
								Out</span></a>
						<%
							} else {
								if ((flagUserExists == 0) && (userName != null)) {
									session.setAttribute("loginError", true);
								}
						%>

						<a href="#signup" id="loginbtn" role="button" data-toggle="modal"
							style="padding-right: 0"><span
							class="btn btn-large btn-success" style="margin-top: 14px;">Signup</span></a>
						<a href="#login" id="loginbtn" role="button" data-toggle="modal"
							style="padding-right: 0"><span
							class="btn btn-large btn-success" style="margin-top: 14px;">Login</span></a>
						<%
							}
						%>
						<div id="login" class="modal hide fade in" tabindex="-1"
							role="dialog" aria-labelledby="login" aria-hidden="false">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">X</button>
								<h3>Login</h3>
							</div>
							<div class="modal-body">
								<form id="loginForm" method="POST" action="index.jsp"
									class="form-horizontal loginFrm"">
									<div class="control-group">
										Username <input type="text" name="username" id="inputUsername"
											placeholder="Username" required>
									</div>
									<div class="control-group">
										Password <input type="password" name="password"
											id="inputPassword" placeholder="Password" required>
									</div>
									<div class="control-group" style="padding-left: 42px;">
										Role: <select name="role">
											<option value="Customer">Customer</option>
											<option value="Salesman">Salesman</option>
											<option value="Store Manager">Store Manager</option>
										</select>
									</div>
								</form>
								<button type="submit" form="loginForm" class="btn btn-success">Sign
									in</button>
								<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
							</div>
						</div>
						<div id="signup" class="modal hide fade in" tabindex="-1"
							role="dialog" aria-labelledby="login" aria-hidden="false">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">X</button>
								<h3>Signup</h3>
							</div>
							<div class="modal-body">
								<form id="SignupForm" method="POST" action="index.jsp"
									class="form-horizontal loginFrm"
									onsubmit="return validatePassword()">
									<div class="control-group" style="padding-left: 61px;">
										Username <input type="text" name="username" id="inputUsername"
											placeholder="Username" required>
									</div>
									<div class="control-group" style="padding-left: 61px;">
										Password <input type="password" name="password"
											id="inputPassword" placeholder="Password" required>
									</div>
									<div class="control-group">
										Confirm Password <input type="password" name="confirmPassword"
											id="confirmPassword" placeholder="Password" required>
									</div>
									<input type="hidden" name="signup" value="true">
									<div class="control-group" style="padding-left: 88px;">
										Role: <select name="role">
											<option value="Customer">Customer</option>
											<option value="Salesman">Salesman</option>
											<option value="Store Manager">Store Manager</option>
										</select>
									</div>
								</form>
								<button type="submit" form="SignupForm"
									formclass="btn btn-success">Sign Up</button>
								<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
							</div>
						</div>
						<!-- </li> -->
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>