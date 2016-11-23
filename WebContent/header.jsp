<!DOCTYPE html>
<%@page import="com.csp595.beans.Product"%>
<%@page import="java.util.Map"%>
<%@page import="com.csp595.utilities.SaxParserProductXMLdataStore"%>
<html lang="en">
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
	
	<!-- Style -->
	<style>
	.alert {
	    padding: 20px;
	    color: white;
	}
	
	.closebtn {
	    margin-left: 15px;
	    color: white;
	    font-weight: bold;
	    float: right;
	    font-size: 22px;
	    line-height: 20px;
	    cursor: pointer;
	    transition: 0.3s;
	}
	
	.closebtn:hover {
	    color: black;
	}
	</style>
  </head>
<body onload="init()">
<script type="text/javascript" src="themes/js/autoComplete.js"></script>
<% Map<String, Product> productHashMap = SaxParserProductXMLdataStore.getProductHashMap(); %>
	<% 
		String userName = (String) session.getAttribute("userName");
	    String userRole = (String) session.getAttribute("userRole");
		//String myCartShoppingItemId = (String)session.getAttribute("shoppingItemId");
		String user = "User";
		int myCartCount = 0;
		if(userName != null){
			user = userName;
		}
	 	
	 	String shoppingItemId = request.getParameter("shoppingItemId");
		String sessionShoppingItemId = (String) session.getAttribute("shoppingItemId");
		String existingShoppingItemId = (sessionShoppingItemId == null)?"":sessionShoppingItemId;
		String[] csvProductIds = new String[100];
		if(existingShoppingItemId != null && userName != null){
			if(shoppingItemId != null){
				existingShoppingItemId += ","+shoppingItemId;
				if(existingShoppingItemId.startsWith(",")){
					existingShoppingItemId = existingShoppingItemId.substring(1);
				}
				session.setAttribute("shoppingItemId", existingShoppingItemId);
			}
			if(!existingShoppingItemId.equals("")){
				csvProductIds = existingShoppingItemId.split(",");
		 		myCartCount = csvProductIds.length;
			}
		}
	 %>
<div id="header">
<div class="container">
<div id="welcomeLine" class="row">
	<div class="span6">Welcome!<strong> <%=user%></strong></div>
	<div class="span6">
	<div class="pull-right">
		<a href="product_summary.jsp?myCart=true"><span class="btn btn-mini btn-primary"><i class="icon-shopping-cart icon-white"></i> 
		<%if(myCartCount != 0){%>
			My Cart[<%=myCartCount %>]
		<%} else {%>
		My Cart
		<%} %>
		</span> </a> 
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
		<button type="submit" id="submitButton" class="btn btn-primary">Go</button>
		<div id="auto-row">
			<table id="complete-table" style="position:absolute;width:220px;"></table>
		</div>
		 <!-- <select class="srchTxt">
			<option>All</option>
			<option>CLOTHES </option>
			<option>FOOD AND BEVERAGES </option>
			<option>HEALTH & BEAUTY </option>
			<option>SPORTS & LEISURE </option>
			<option>BOOKS & ENTERTAINMENTS </option>
		</select> --> 
    </form>
    <ul id="topMenu" class="nav pull-right">
	<!--  <li class=""><a href="special_offer.html">Specials Offer</a></li> -->
	 <!-- <li class=""><a href="normal.html">Delivery</a></li>
	 <li class=""><a href="contact.html">Contact</a></li> -->
	 <li style="display: -webkit-box;">
	 <%if(userName != null){
		 if(userRole.equals("Store Manager")){%>
			 <a href="admin_operations.jsp"><span class="btn btn-large btn-success">Admin</span></a>
	 	<%} %>
		 <a href="deal_matches.jsp"><span class="btn btn-large btn-success">Deal Matcher</span></a>
		 <a href="history_orders.jsp"><span class="btn btn-large btn-success">My Orders</span></a>
		 <a href="LoginServlet"><span class="btn btn-large btn-success">Log Out</span></a>
	 <%} else {
		 %>
		 <a href="login.jsp"><span class="btn btn-large btn-success">My Orders</span></a>
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
<!-- Header End====================================================================== -->
</body>
</html>