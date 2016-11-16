<!DOCTYPE html>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Enumeration"%>
<html>
<%-- <%@include file="header.jsp" %> --%>
<%--Header start --%>
<head>
    <meta charset="utf-8">
    <title>Click 'N' Pick</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
<!--Less styles -->
   <!-- Other Less css file //different less files has different color scheam
	<link rel="stylesheet/less" type="text/css" href="themes/less/simplex.less">
	<link rel="stylesheet/less" type="text/css" href="themes/less/classified.less">
	<link rel="stylesheet/less" type="text/css" href="themes/less/amelia.less">  MOVE DOWN TO activate
	-->
	<!--<link rel="stylesheet/less" type="text/css" href="themes/less/bootshop.less">
	<script src="themes/js/less.js" type="text/javascript"></script> -->
	<!-- Bootstrap style --> 
    <link id="callCss" rel="stylesheet" href="themes/bootshop/bootstrap.min.css" media="screen"/>
    <link href="themes/css/base.css" rel="stylesheet" media="screen"/>
<!-- Bootstrap style responsive -->	
	<link href="themes/css/bootstrap-responsive.min.css" rel="stylesheet"/>
	<link href="themes/css/font-awesome.css" rel="stylesheet" type="text/css">
<!-- Google-code-prettify -->	
	<link href="themes/js/google-code-prettify/prettify.css" rel="stylesheet"/>
<!-- fav and touch icons -->
    <link rel="shortcut icon" href="themes/images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="themes/images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="themes/images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="themes/images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="themes/images/ico/apple-touch-icon-57-precomposed.png">
	<style type="text/css" id="enject"></style>
  </head>
<body onload="init()">
<script type="text/javascript" src="themes/js/autoComplete.js"></script>
	<% String userName = (String) session.getAttribute("userName");
	String user = "User";
	 	if(userName != null){
	 		user = userName;
	 	}
	 %>
<div id="header">
<div class="container">
<div id="welcomeLine" class="row">
	<div class="span6">Welcome!<strong> <%=user%></strong></div>
	<div class="span6">
	<div class="pull-right">
		<a href="product_summary.html"><span class="btn btn-mini btn-primary" style="font-size: 10px;">
		<i class="icon-shopping-cart icon-white"></i> My Cart[ 3 ] </span> </a> 
	</div>
	</div>
</div>
<!-- Navbar ================================================== -->
<div id="logoArea" class="navbar">
<a id="smallScreen" data-target="#topMenu" data-toggle="collapse" class="btn btn-navbar">
	<span class="icon-bar"></span>
	<span class="icon-bar"></span>
	<span class="icon-bar"></span>
</a>
  <div class="navbar-inner">
    <a class="brand" href="index.jsp"><img src="themes/images/cnplogoImg.png" alt="Clicknpick" style="width:220px; height:40px"/></a>
		<form class="form-inline navbar-search">
		<input id="searchValue" type="search" onkeyup="autoCompleteSearch()"/>
		<div id="auto-row">
			<table id="complete-table" style="position:absolute;width:315px;"></table>
		</div>
		 <!-- <select class="srchTxt">
			<option>All</option>
			<option>CLOTHES </option>
			<option>FOOD AND BEVERAGES </option>
			<option>HEALTH & BEAUTY </option>
			<option>SPORTS & LEISURE </option>
			<option>BOOKS & ENTERTAINMENTS </option>
		</select> 
		  <button type="submit" id="submitButton" class="btn btn-primary">Go</button>--> 
		
    </form>
    <ul id="topMenu" class="nav pull-right">
	<!--  <li class=""><a href="special_offer.html">Specials Offer</a></li> -->
	 <!-- <li class=""><a href="normal.html">Delivery</a></li>
	 <li class=""><a href="contact.html">Contact</a></li> -->
	 <li style="display: -webkit-box;">
	 <%if(userName != null){
		 %><a href="LoginServlet"><span class="btn btn-large btn-success">Log Out</span></a>
	 <%} else {
		 %>
		 <a href="register.jsp"><span class="btn btn-large btn-success">Sign Up</span></a> 
		 <a href="login.jsp"><span class="btn btn-large btn-success">Login</span></a>
	 <% } %>
	 
	<div id="login" class="modal hide fade in" tabindex="-1" role="dialog" aria-labelledby="login" aria-hidden="false" >
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3>Login Block</h3>
		  </div>
		  <div class="modal-body">
			<form class="form-horizontal loginFrm">
			  <div class="control-group">								
				<input type="text" id="inputEmail" placeholder="Email">
			  </div>
			  <div class="control-group">
				<input type="password" id="inputPassword" placeholder="Password">
			  </div>
			  <div class="control-group">
				<label class="checkbox">
				<input type="checkbox"> Remember me
				</label>
			  </div>
			</form>		
			<button type="submit" class="btn btn-success">Sign in</button>
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
		  </div>
	</div>
	</li>
    </ul>
  </div>
</div>
</div>
</div>
<%--header end --%>
<%@include file="sidebar.jsp" %>
<head>
		<meta charset="UTF-8"/>
		<title>Payment Form</title>
		<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css'/>
		<link rel="stylesheet" href="themes/css/style.css"/>
</head>
<body>
	<%
	String checkoutAmount = (String) session.getAttribute("checkoutAmount");
	Enumeration<String> shippingInfoParam = request.getParameterNames();
	Map<String,String> shippingInfoMap = new HashMap<String,String>();
	while(shippingInfoParam.hasMoreElements()){
		String key = shippingInfoParam.nextElement();
		String value = request.getParameter(key);
		shippingInfoMap.put(key,value);
	}
	if(shippingInfoMap.isEmpty()){
		session.setAttribute("shippingInfoMap", shippingInfoMap);
	}
	%>
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css'/>
			<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"/>
				<div id="mainBody">
	<div class="checkoutContainer">
	<div class="row">
				<div class="span9">
					<div id="Checkout" class="inline">
						<h1>Pay Invoice</h1>
						<div class="card-row">
							<span class="visa"></span>
							<span class="mastercard"></span>
							<span class="amex"></span>
							<span class="discover"></span>
						</div>
						<form action="index.jsp" method="POST">
							<div class="form-group">
								<label for="PaymentAmount">Payment amount</label>
								<div class="amount-placeholder">
								<% if(checkoutAmount != null){ %>
									<span>$</span>
									<span><%=checkoutAmount%></span>
									<% } %>
									<!-- <span>$</span> <span>500.00</span> -->
								</div>
							</div>
							<div class="form-group">
								<label for="NameOnCard">Name on card</label>
								<input id="NameOnCard" name="name" class="form-control" type="text" maxlength="255" required="required"/>
								<input type="hidden" name="makePayment" value="true"/>
							</div>
							<div class="form-group">
								<label for="CreditCardNumber">Card number</label>
								<input id="CreditCardNumber" name="creditCardNumber" class="null card-image form-control" type="text" required="required" maxlength="16" min="1" onkeypress='return event.charCode >= 48 && event.charCode <= 57'/>
								</div>
								<div class="expiry-date-group form-group">
									<label for="ExpiryDate">Expiry date</label>
									<input id="ExpiryDate" name="expiryDate" class="form-control" type="text" placeholder="MM / YY" maxlength="7" required="required"/>
								</div>
								<div class="security-code-group form-group">
									<label for="SecurityCode">Security code</label>
									<div class="input-container">
										<input id="SecurityCode" name="securityCode" class="form-control" type="text" min="1" required="required" maxlength="3"/>
										<i id="cvc" class="fa fa-question-circle"></i>
									</div>
									<div class="cvc-preview-container two-card hide">
										<div class="amex-cvc-preview"></div>
										<div class="visa-mc-dis-cvc-preview"></div>
									</div>
								</div>
								<div class="zip-code-group form-group">
									<label for="ZIPCode">ZIP/Postal code</label>
									<div class="input-container">
										<input id="ZIPCode" name="zipCode" class="form-control" type="text" maxlength="10"/>
										<a tabindex="0" role="button" data-toggle="popover" data-trigger="focus" data-placement="left" data-content="Enter the ZIP/Postal code for your credit card billing address.">
											<i class="fa fa-question-circle">
											</i>
										</a>
									</div>
								</div>
								<button id="PayButton" class="btn btn-block btn-success submit-button" type="submit" >
									<span class="submit-button-lock"></span>
									<span class="align-middle-payment">Pay</span>
								</button>
							</form>
						</div>
					</div></div></div></div>
					<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
					<script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
					<script src="themes/js/index.js"></script>
					<%@include file="footer.jsp" %>
				</body>
</html>