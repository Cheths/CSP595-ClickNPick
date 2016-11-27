<!DOCTYPE html>
<%@page import="com.csp595.utilities.SaxParserProductXMLdataStore"%>
<%@page import="com.csp595.beans.Product"%>
<%@page import="java.util.Map"%>
<html lang="en">
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<body>
<% 
	String shippingAddress = "";
	String orderId = (String) request.getAttribute("orderId");
	String orderedDate = (String) request.getAttribute("orderedDate");
	String expectedDeliveryDate = (String) request.getAttribute("expectedDeliveryDate");
	String checkoutAmount = (String) session.getAttribute("checkoutAmount");
	Map<String,String> shippingInfoMap = (Map<String,String>) session.getAttribute("shippingInfoMap");
		if(shippingInfoMap != null){
			shippingAddress = shippingInfoMap.get("address") +", "+ shippingInfoMap.get("city") +", "+ shippingInfoMap.get("state") +" - "+ shippingInfoMap.get("postcode");
		}
		shoppingItemId = (String)request.getAttribute("shoppingItemIds");
		String[] shoppingItemIdArray = new String[100];
		if(shoppingItemId != null){
			shoppingItemIdArray = shoppingItemId.split(",");
	}%>
	<div id="mainBody">
		<div class="container">
			<div class="row">
				<div class="span9">
				<%if(orderId!= null && !orderId.equals("")){%>
					<div class="alert" style="background-color: #5bb75b;">
					 <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
		 			 <strong>Success!</strong> Order created Successfully.
					</div>
				<% }%>
					<ul class="breadcrumb">
						<li><a href="index.html">Home</a> <span class="divider">/</span></li>
						<li class="active">Order Summary</li>
					</ul>
					<h3>Order Summary</h3>
					<hr class="soft" />

					<div id="orderInfo">
						<h4>Ship To:</h4>
						<p><%=shippingAddress %><p />
						Order no: <strong style="color: blue;"><%=orderId %></strong>
						<br>Ordered Date: <strong><%=orderedDate %></strong> <br>Estimated
						Delivery Date: <strong><%=expectedDeliveryDate %></strong>
					</div>
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>Product</th>
								<th>Model</th>
								<th>Quantity</th>
								<th>Price</th>
							</tr>
						</thead>
						<tbody>
						<% for (int i=0; i<shoppingItemIdArray.length;i++){
								Product product = productHashMap.get(shoppingItemIdArray[i]);
								if(product != null){%>
							<tr>
							<td><img width="60" src="themes/images/products/new/<%= product.getImage()%>" alt=""></td>
							<td><%=product.getName() %></td>
							<td>1</td>
							<td><%=product.getPrice() %></td>
						</tr>
						<%} }%>
							<tr>
								<td colspan="3" style="text-align: right"><strong>TOTAL PRICE =</strong></td>
								<td class="label label-important" style="display: block"><strong><%=checkoutAmount %></strong></td>
							</tr>
						</tbody>
					</table>

					<a href="index.jsp" class="btn btn-large"><i class="icon-arrow-left"></i> Continue Shopping </a>
				</div>
			</div>
		</div>
	</div>
	<!-- MainBody End ============================= -->
<%@include file="footer.jsp" %>
</body>
</html>