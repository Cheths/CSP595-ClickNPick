<!DOCTYPE html>
<%@page import="java.util.List"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="com.csp595.utilities.MySqlUtil"%>
<%@page import="com.csp595.beans.Order"%>
<html>
<body>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<% String deleteOrderId = request.getParameter("hdnOrderId");
if(deleteOrderId != null){
	MySqlUtil.deleteOrder(deleteOrderId);
}
Map<String, Order> orderHashMap = MySqlUtil.getUserOrderList(userName, userRole);%>
<div id="mainBody">
	<div class="container">
		<div class="row">
			<div class="span9">
				<ul class="breadcrumb">
					<li>
						<a href="index.jsp">Home</a>
						<span class="divider">/</span>
					</li>
					<li class="active">SHOPPING CART</li>
				</ul>
				<% if(deleteOrderId != null){%>
					<div class="alert" style="background-color: #5bb75b;">
					 <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
		 			 <strong>Success!</strong> Order removed Successfully.
					</div>
				<%}%>
				<h3>						SHOPPING CART </h3>
				<hr class="soft">
					<table class="table table-bordered">
						<thead id="productCheckout">
							<tr>
								<th>Order No.</th>
								<th>Product</th>
								<th>Ordered date</th>
								<th>Delivery Date</th>
								<th>Amount</th>
								<th>Cancel Order</th>
							</tr>
						</thead>
						<tbody>
						<% if(!orderHashMap.isEmpty()){
							for(Entry<String, Order> orderObj : orderHashMap.entrySet()){
								Order order = orderObj.getValue();
								List<Product> orderedProductList= order.getProductList();
								String productNameCsv = "";
								for(Product product: orderedProductList){
									productNameCsv += ", "+product.getName();
								}
								productNameCsv = productNameCsv.replaceFirst(", ", "");
								%>
							<tr>
							<td><%= order.getOrderId() %></td>
							<td><%= productNameCsv %></td>
							<td><%= order.getOrderDate() %></td>
							<td><%= order.getExpectedDeliveryDate() %></td>
							<td><%= order.getOrderAmount() %></td>
							<td>
								<div class="input-append">
									<form action="history_orders.jsp" method="GET">
										<div class="input-append" style="padding-left: 36px;">
											<input type="hidden" value=<%= order.getOrderId() %> name="hdnOrderId">
												<button class="btn btn-danger" type="submit"> <i class="icon-remove icon-white"></i>
												</button>
											</div>
										</form>
									</div>
								</td>
							</tr>
					<%	} } else {%>
						<tr>
						<td colspan="6"> No Orders Found </td>
						</tr>
					<%}%>
								
							</tbody>
						</table> 					
						<a href="UtilityServlet" class="btn btn-large"> <i class="icon-arrow-left"></i> Continue Shopping </a> 					
					</div>
				</div>
			</div>
		</div>

<%@include file="footer.jsp" %>
</body>
</html>