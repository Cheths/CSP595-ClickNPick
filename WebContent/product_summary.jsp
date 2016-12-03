<!DOCTYPE html>
<%@page import="com.csp595.utilities.MySqlUtil"%>
<%@page import="javax.swing.text.Document"%>
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
		boolean isValid = request.getParameter("isValid")!=null && request.getParameter("isValid").equals("yes") ? true : false;
		int discountPercentage = 0;
		String isAlreadyUsed = "";
		if(isValid)
			discountPercentage =  (request.getParameter("disc")!=null && !request.getParameter("disc").isEmpty()) ? Integer.parseInt(request.getParameter("disc")) : 0 ;
		else{
			isAlreadyUsed = request.getParameter("alreadyUsed") != null ?  request.getParameter("alreadyUsed") : " ";	
		}
			
				
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
						if ((shoppingItemId != null && !shoppingItemId.equals("")) || !fromCouponValidation.isEmpty()) {
							
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
										<input class="span1" style="max-width: 34px" disabled="disabled" placeholder="1" id="appendedInputButtons" size="16" type="text">
										<a href="UtilityServlet?removeItem=<%=product.getId()%>" class="btn btn-danger" ><i class="icon-remove icon-white"></i></a>
										<!-- <button class="btn btn-danger" type="button">
											<i class="icon-remove icon-white"></i>
										</button> -->
									</div>
								</td>
								<td>$<%=product.getPrice()%></td>
								<td>$<%=product.getDiscount()%></td>
								<%-- <td>$<%=tax%></td> --%>
								<td colspan="2">$<%=individualProductTotal%></td>
							</tr>
							<%
								}
									}
									totalTax = checkoutAmount * (0.05);
									checkoutAmount = Math.floor(checkoutAmount + totalTax);
							%>

							<tr>
								<td colspan="6" style="text-align: right">Total Price:</td>
								<%
								if(isValid == true && discountPercentage > 0){
// 									totalDiscount = totalPrice *  ((double)discountPercentage/100);
// 									totalPrice -= totalPrice *  ((double)discountPercentage/100);
									checkoutAmount = checkoutAmount - ( checkoutAmount *  ((double)discountPercentage/100));
								}
								%>
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
										($<%=totalPrice%> - $<%=totalDiscount%> + $<%=totalTax%>) - <%=discountPercentage%>% =
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
									
									<form class="form-horizontal" action="ValidateCouponServlet">
										<div class="control-group">
											<label class="control-label"><strong>
													VOUCHERS CODE: </strong> </label>
											<div class="controls">
											<%
											if(request.getParameter("isValid")!=null && request.getParameter("isValid").equalsIgnoreCase("yes")){
											%>
												<input type="hidden" name="shopItemId" value="<%=shoppingItemId %>>">
												<input type="text" name="couponCode" disabled="disabled"  class="input-medium" />
												<button id="addCoupon_button" type="submit"  disabled="disabled" class="btn">ADD</button>												
											<%}else{ %>
												<input type="hidden" name="shopItemId" value="<%=shoppingItemId %>>">
												<input type="text" name="couponCode" id="couponCode_text"  class="input-medium" />
												<button id="addCoupon_button" type="submit"   class="btn">ADD</button>												
											<%} 
											
											if(request.getParameter("isValid")!=null && request.getParameter("isValid").equalsIgnoreCase("no")){
												if(isAlreadyUsed != null && !isAlreadyUsed.isEmpty() && isAlreadyUsed.equalsIgnoreCase("yes")){
												%>
													<div class="alert" style="background-color: #f44336;width:220px;">
													<span class="closebtn"
													onclick="this.parentElement.style.display='none';">&times;</span>
													<strong>This coupon is already redeemed!</strong>
													</div>
												<%}else{ %>
													<div class="alert" style="background-color: #f44336;width:220px;">
													<span class="closebtn"
													onclick="this.parentElement.style.display='none';">&times;</span>
													<strong>Invalid coupon for this user!</strong>
													</div>
											<%}
											}%>
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
					<% if (shoppingItemId != null && !shoppingItemId.isEmpty()) {%>
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