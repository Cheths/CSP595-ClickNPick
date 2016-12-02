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
  /* new SaxParserProductXMLdataStore(homePath+"/webapps/A1/Products.xml"); */ %>
  
<%@include file="header.jsp" %>
<%-- <%@include file="carousel.jsp" %> --%>
<%@include file="sidebar.jsp" %>
	<div id="mainBody">
	<div class="container">
	<div class="row">
	<div class="span9">
		<img src="${pageContext.request.contextPath}/themes/images/donation.jpg"/>
		<%String tempUserName ="";
		if(session.getAttribute("userName")!=null) {
			tempUserName = (String)session.getAttribute("userName");%>
			<h4>Donate The Clothes </h4>
			<form class="form-horizontal" action="UtilityServlet" method="POST">
			<div class="control-group">
				<label class="control-label" for="inputFname1">Username <sup>*</sup></label>
				<div class="controls">
					<input type="text" disabled="disabled" style="width: 220px!important;" name="username" id="username" required="required" 
					value="<%=tempUserName%>"	placeholder="Username">
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">Organization <sup>*</sup></label>
				<div class="controls">
					<select class="span3" style="width: 230px!important;" id="organization" name="organization""
						required="required">
						<option value="American Red Cross">American Red Cross</option>
						<option value="Big Brother Big Sister Foundation">Big Brother Big Sister Foundation</option>
						<option value="Soles 4 Soles">Soles 4 Soles</option>
						<option value="Goodwill">Goodwill</option>
						<option value="The Salvation Army">The Salvation Army</option>
					</select>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="inputFname1">Number of Pieces <sup>*</sup></label>
				<div class="controls">
					<input type="number" style="width: 215px!important;" name="quantity" id="quantity" required="required"	placeholder="Quantity">
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="input_email">Pick Up location <sup>*</sup></label>
				<div class="controls">
					<textarea style="width: 220px!important;" name="pickup_location" id="pickup_location"	placeholder="Pick Up location"></textarea>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="input_email">Pick Up Date <sup>*</sup></label>
				<div class="controls">
					<input style="width: 220px!important;" type="date" name="pickup_date" id="pickup_date"	placeholder="Pick Up Date">
				</div>
			</div>

			<input type="hidden" type="text" id="insertDonations" value="insertDonations"  name="insertDonations">
			
			<div class="control-group">
			<div class="controls">
				<input class="btn btn-large btn-success" type="submit"
					value="Send Donations" />
			</div>
			</div>
		</form>
		<%}else{%>
			<h3>Please login to donate</h3>
		<%}%>				
		<img src="${pageContext.request.contextPath}/themes/images/donation1.jpg"/>
		</div>		
		</div>
	</div>
</div>
</body>
</html>
<%@include file="footer.jsp" %>