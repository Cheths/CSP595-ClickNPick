<!DOCTYPE html>
<%@page import="javax.sql.rowset.serial.SerialArray"%>
<%@page import="java.util.Map"%>
<%@page import="com.csp595.utilities.SaxParserProductXMLdataStore"%>
<%@page import="com.csp595.beans.Product"%>
<html lang="en">
<body>
	<%@include file="header.jsp"%>
	<%@include file="sidebar.jsp"%>
	<script type="text/javascript">
		function addQty() {
			document.getElementById("appendedInputButtons");
		};
		function removeItem() {
			alert("inside Remove fn");
		};
	</script>
	<!-- Header End====================================================================== -->
	<%
		final int tax = 15;
		shoppingItemId = (String) session.getAttribute("shoppingItemId");
	%>
	<div id="mainBody">
		<div class="container">
			<div class="row">

				<div class="span9">
					<ul class="breadcrumb">
						<li><a href="index.jsp">Home</a> <span class="divider">/</span></li>
						<li class="active">SHOPPING CART</li>
					</ul>

					<%
						double checkoutAmount = 0;
						if ((shoppingItemId != null) && !(shoppingItemId.equals(""))) {
					%>
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>Product</th>
								<th>Description</th>
								<th>Quantity/Update</th>
								<th>Price</th>
								<th>Discount</th>
								<!-- <th>Tax</th> -->
								<th>Total</th>
							</tr>
						</thead>
						<tbody>
							<%
								double totalPrice = 0;
									double totalDiscount = 0;
									double totalTax = 0;
									String myCart = request.getParameter("myCart");

									if (myCart != null) {
										csvProductIds = shoppingItemId.split(",");
									}
									for (int i = 0; i < csvProductIds.length; i++) {
										Product product = productHashMap.get(csvProductIds[i]);
										if (product != null) {
											double price = product.getPrice();
											totalPrice += price;
											double discount = product.getDiscount();
											totalDiscount += discount;
											double individualProductTotal = price - discount;
											checkoutAmount += individualProductTotal;
							%>
							<tr>
								<td><img width="60" src="themes/images/products/new/<%= product.getImage() %>"
									alt="" /></td>
								<td><%=product.getName()%><br />Color : black, Material :
									metal</td>
								<td>
									<div class="input-append">
										<input class="span1" style="max-width: 34px" placeholder="1" id="appendedInputButtons" size="16" type="text">
										<a href="UtilityServlet?removeItem=<%=product.getId()%>" class="btn btn-danger" ><i class="icon-remove icon-white"></i></a>
										<!-- <button class="btn btn-danger" type="button">
											<i class="icon-remove icon-white"></i>
										</button> -->
									</div>
								</td>
								<td>$<%=product.getPrice()%></td>
								<td>$<%=product.getDiscount()%></td>
								<%-- <td>$<%=tax%></td> --%>
								<td>$<%=individualProductTotal%></td>
							</tr>
							<%
								}
									}
									totalTax = checkoutAmount * (0.05);
									checkoutAmount = Math.floor(checkoutAmount + totalTax);
							%>

							<tr>
								<td colspan="6" style="text-align: right">Total Price:</td>
								<td>$<%=totalPrice%></td>
							</tr>
							<tr>
								<td colspan="6" style="text-align: right">Total Discount:</td>
								<td>$<%=totalDiscount%></td>
							</tr>
							<tr>
								<td colspan="6" style="text-align: right">Total Tax:</td>
								<td>5%</td>
							</tr>
							<tr>
								<td colspan="6" style="text-align: right"><strong>TOTAL
										($<%=totalPrice%> - $<%=totalDiscount%> + $<%=totalTax%>) =
								</strong></td>
								<td class="label label-important" style="display: block"><strong>
										$<%=checkoutAmount%>
								</strong></td>
							</tr>
						</tbody>
					</table>

					<table class="table table-bordered">
						<tbody>
							<tr>
								<td>
									<form class="form-horizontal">
										<div class="control-group">
											<label class="control-label"><strong>
													VOUCHERS CODE: </strong> </label>
											<div class="controls">
												<input type="text" name="couponCode" class="input-medium" placeholder="CODE">
												<button type="submit" class="btn">ADD</button>
											</div>
										</div>
									</form>
								</td>
							</tr>

						</tbody>
					</table>
					<%
						} else {
					%>
					<div>No Items in Cart</div>
					<%
						}
					%>

					<a href="index.jsp" class="btn btn-large"><i class="icon-arrow-left"></i> Continue Shopping </a> 
					<% if (shoppingItemId != null) {%>
						<a href="shipping_info.jsp?checkoutAmount=<%=checkoutAmount%>" class="btn btn-large pull-right">Next <i class="icon-arrow-right"></i></a>
					<% } %>
				</div>
			</div>
		</div>
	</div>
	</div>
	<!-- MainBody End ============================= -->
	<%@include file="footer.jsp"%>
</body>
</html>