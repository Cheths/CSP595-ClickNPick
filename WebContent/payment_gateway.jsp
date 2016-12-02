<!DOCTYPE html>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Enumeration"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<html>
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
	if(!shippingInfoMap.isEmpty()){
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
						<form action="UtilityServlet" method="POST">
							<div class="form-group">
								<label for="PaymentAmount">Payment amount</label>
								<div class="amount-placeholder">
								<% if(checkoutAmount != null){ %>
									<span>$</span>
									<span><%=checkoutAmount%></span>
									<% } %>
								</div>
							</div>
							<div class="form-group">
								<label for="NameOnCard">Name on card</label>
								<input id="NameOnCard" name="name" class="form-control" type="text" maxlength="255" required="required"/>
								<input type="hidden" name="makePayment" value="true"/>
							</div>
							<div class="form-group">
								<label for="CreditCardNumber">Card number</label>
								<input id="CreditCardNumber" name="cardNumber" class="null card-image form-control" type="text" required="required" maxlength="16" min="1" onkeypress='return event.charCode >= 48 && event.charCode <= 57'/>
								</div>
								<div class="expiry-date-group form-group">
									<label for="ExpiryDate">Expiry date</label>
									<input id="ExpiryDate" name="expiryDate" class="form-control" type="text" placeholder="MM / YY" maxlength="7" required="required"/>
								</div>
								<div class="security-code-group form-group">
									<label for="SecurityCode">Security code</label>
									<div class="input-container">
										<input id="SecurityCode" name="cvv" class="form-control" type="text" min="1" required="required" maxlength="3"/>
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
									<span class="align-middle-payment">Pay $<%=checkoutAmount%></span>
								</button>
							</form>
						</div>
					</div></div></div></div>
					<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
					<script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
					<script src="themes/js/index.js"></script>
				</body>
</html>
<%@include file="footer.jsp" %>