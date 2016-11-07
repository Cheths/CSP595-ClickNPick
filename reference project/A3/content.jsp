<!DOCTYPE html>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.cheths.a1.main.ProductReview"%>
<%@page import="com.cheths.a1.main.MongoDBDataStoreUtilities"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.cheths.a1.main.MySQLDataStoreUtilities"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="com.cheths.a1.main.ProductHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cheths.a1.main.Product"%>
<%@page import="java.util.List"%>
<html>
<head></head>
<body>
	<%
		String productId = request.getParameter("id");
		String category = request.getParameter("category");
		String shoppingItemId = request.getParameter("shoppingItemId");
		String checkout = request.getParameter("checkout");
		String shippinginfo = request.getParameter("shippinginfo");
		String makePayment = request.getParameter("makePayment");
		String myOrders = request.getParameter("myOrders");
		String myCart = request.getParameter("myCart");
		Boolean loginError = (Boolean) session.getAttribute("loginError");
		Boolean userCreated = (Boolean) session.getAttribute("userCreated");
		String deleteProductId = request.getParameter("hdnProductId");
		String deleteOrderId = request.getParameter("hdnOrderId");
		String productReviewId = request.getParameter("productReviewId");
		String viewProductReviewId = request.getParameter("viewProductReview");
		String storeProductReview = request.getParameter("storeProductReview");
		String trendingNow = request.getParameter("trendingNow");
		String isDataAnalytics = request.getParameter("isDataAnalytics");
		String dataAnalyticsInputRequest = request.getParameter("hdnDataAnalytics");
		Boolean showMyCartItems = ((Boolean) session.getAttribute("showMyCartItems") != null)
				? (Boolean) session.getAttribute("showMyCartItems") : false;
		Boolean isOrderDeleted = (Boolean)session.getAttribute("isOrderDeleted");
				
		if (loginError != null) {
	%>
	<div style="color: blue; font-size: x-large;">Invalid
		Credentials!</div>
	<%
		session.removeAttribute("loginError");
		} else if (userCreated != null) {
			if (userCreated) {
	%>
	<div style="color: blue; font-size: x-large;">User Created
		Successfully!</div>
	<%
		} else {
	%>
	<div style="color: blue; font-size: x-large;">Signup Failure!</div>
	<%
		}
			session.removeAttribute("userCreated");
		}
	%>
	<%
		if (productId != null) {
			Product product = ProductHelper.getProductById(productId);
			if (product != null) {
	%>

	<div class="span9">
		<ul class="breadcrumb">
			<li><a href="index.jsp">Home</a> <span class="divider">/</span>
			</li>
			<li><a href="index.jsp">Products</a> <span class="divider">/</span>
			</li>
			<li class="active">Product Details</li>
		</ul>
		<div class="row">
			<div id="gallery" class="span3">
				<a href=<%=product.getImage()%> title=<%=product.getName()%>> <img
					src=<%=product.getImage()%> style="width: 100%"
					alt=<%=product.getName()%> />
				</a>
			</div>
			<div class="span6">
				<h3><%=product.getName()%></h3>
				<hr class="soft" />
				<form class="form-horizontal qtyFrm" action="index.jsp" method="GET">
					<input type="hidden" name="shoppingItemId"
						value=<%=product.getId()%>>
					<div class="control-group">
						<label class="control-label"> <span>$<%=product.getPrice()%></span>
						</label>
						<button type="submit" class="btn btn-large btn-primary pull-right">
							Add to cart <i class=" icon-shopping-cart"></i>
						</button>
					</div>
				</form>
			</div>
			<hr class="soft" />
			<form class="form-horizontal qtyFrm pull-right">
				<div class="control-group">
					<label class="control-label"> <span>Color</span>
					</label>
					<div class="controls">
						<select class="span2">
							<option>Black</option>
							<option>Red</option>
							<option>Blue</option>
							<option>Brown</option>
						</select>
					</div>
				</div>
			</form>
			<hr class="soft clr" />
			<p><%=product.getDescription()%></p>
		</div>
	</div>
	</div>
	<%
		}
	%>
	<%
		} else if (category != null) {
	%>
	<div class="span9 content">
		<br class="clr" />
		<div class="tab-content" style="height: 700px; width: 990px;">
			<div class="tab-pane  active" id="blockView">
				<ul class="thumbnails">
					<%
						for (Product product : productList) {
								if (product.getCategory().equals(category)) {
					%>
					<li class="span3">
						<div class="thumbnail">
							<a href="index.jsp?id=<%=product.getId()%>"> <img
								src=<%=product.getImage()%> alt="" />
							</a>
							<div class="caption">
								<h5><%=product.getName()%></h5>
								<h4 style="text-align: center">
									<a class="btn"
										href="index.jsp?shoppingItemId=<%=product.getId()%>"> Add
										to <i class="icon-shopping-cart"></i>
									</a> <a class="btn btn-primary" href="#">$<%=product.getPrice()%></a>
									<a class="btn btn-primary"
										href="index.jsp?productReviewId=<%=product.getId()%>"
										style="width: 130px">Write Reviews</a> <a
										class="btn btn-primary"
										href="index.jsp?viewProductReview=<%=product.getId()%>"
										style="width: 130px">View Reviews</a>
								</h4>
							</div>
						</div>
					</li>
					<%
						}
							}
					%>

				</ul>
				<hr class="soft" />
			</div>
		</div>
	</div>
	<%
		} else if ((shoppingItemId != null) || (showMyCartItems == true) || (myCart != null)) {
			String shoppingItemIds = (String) session.getAttribute("shoppingItemId");
			String[] shoppingItemList = {};

			if (shoppingItemIds != null) {
				shoppingItemList = shoppingItemIds.split(",");
			}

			Double totalPrice = 0D;
			session.removeAttribute("showMyCartItems");
	%>
	<div id="mainBody">
		<div class="container">
			<div class="row">
				<div class="span9">
					<ul class="breadcrumb">
						<li><a href="index.jsp">Home</a> <span class="divider">/</span>
						</li>
						<li class="active">SHOPPING CART</li>
					</ul>
					<h3>SHOPPING CART</h3>
					<hr class="soft" />
					<table class="table table-bordered">
						<thead id="productCheckout">
							<tr>
								<th>Product</th>
								<th>Model</th>
								<th>Quantity/Update</th>
								<th>Price</th>
								<th>Discount</th>
								<th>Tax</th>
								<th>Total</th>
								<th>Remove Orders</th>
							</tr>
						</thead>
						<%
							for (int i = 0; i < shoppingItemList.length; i++) {
									Product product = ProductHelper.getProductById(shoppingItemList[i]);
									if (product != null) {
										Double productPrice = ProductHelper.calculatePriceForProduct(product);
										totalPrice += productPrice;
						%>
						<tbody>
							<tr>
								<td><img width="60" src=<%=product.getImage()%> alt="" />
								</td>
								<td><%=product.getName()%><br /></td>
								<td>
									<div class="input-append">
										<input class="span1" style="max-width: 34px" placeholder="1"
											id="appendedInputButtons" size="16" type="text" readonly />
									</div>
								</td>
								<td><%=product.getPrice()%></td>
								<td>$<%=product.getDiscount()%></td>
								<td>$15.00</td>
								<td><%=productPrice%></td>
								<td>
									<div class="input-append">
										<form action="index.jsp" method="GET">
											<div class="input-append" style="padding-left: 36px;">
												<input type="hidden" name="hdnProductId"
													value=<%=product.getId()%> />
												<button class="btn btn-danger" type="submit">
													<i class="icon-remove icon-white"></i>
												</button>
											</div>
										</form>
									</div>
								</td>
							</tr>
							<%
								}
									}
									if (totalPrice != 0D) {
							%>
							<tr>
								<td colspan=6 style="text-align: right"><strong>TOTAL
										PRICE =</strong></td>
								<td class="label label-important" style="display: block"><strong><%=totalPrice%>
								</strong></td>
							</tr>
						</tbody>
					</table>
					<a href="index.jsp" class="btn btn-large"> <i
						class="icon-arrow-left"></i> Continue Shopping
					</a> <a href="index.jsp?checkout=true" class="btn btn-large pull-right">Checkout
						<i class="icon-arrow-right"></i>
					</a>
				</div>
			</div>
		</div>
	</div>
	<%
		session.setAttribute("checkOutAmount", totalPrice);
			} else {
	%>
	<tr>NO DATA FOUND
	</tr>
	<%
		}
	%>
	<%
		} else if (checkout != null) {
			if (session.getAttribute("userName") != null) {
	%>
	<%@include file="shipping_info.jsp"%>
	<%
		} else {
	%>
	<%@include file="login.jsp"%>
	<%
		}
		} else if (shippinginfo != null) {
	%>
	<%@include file="payment_gateway.jsp"%>
	<%
		session.setAttribute("shippingInfoMap", request.getParameterMap());
	%>
	<%
		} else if (makePayment != null) {
			String itemId = (String) session.getAttribute("shoppingItemId");
			if (itemId != null) {
				String[] shoppingItemList = itemId.split(",");
				Double totalPrice = 0D;
				String orderId = ProductHelper.generateOrderId();
				Map<String, String[]> shippingInfoMap = (Map<String, String[]>) session.getAttribute("shippingInfoMap");
				StringBuilder builder = new StringBuilder();
				String address = "";
				for (Entry<String, String[]> shippingInfo : shippingInfoMap.entrySet()) {
					if ((shippingInfo.getKey() == "address") || (shippingInfo.getKey() == "city")
							|| (shippingInfo.getKey() == "state") || ((shippingInfo.getKey() == "country"))) {
						builder.append(", " + shippingInfo.getValue());
					}
				}
				if (builder.toString().startsWith(",")) {
					address = builder.toString().substring(1);
				}
				String orderedDate = ProductHelper.getOrderedDate();
				String expectedDeliveryDate = ProductHelper.getExpectedDeliveryDate();
				expectedDeliveryDate = expectedDeliveryDate.split(" ")[0];
				session.setAttribute("orderId", orderId);
				session.setAttribute("orderedDate", orderedDate);
				session.setAttribute("expectedDeliveredDate", expectedDeliveryDate);
	%>
	<div id="mainBody">
		<div class="container">
			<div class="row">
				<div class="span9">
					<ul class="breadcrumb">
						<li><a href="index.jsp">Home</a> <span class="divider">/</span>
						</li>
						<li class="active">Order Summary</li>
					</ul>
					<h3>Order Summary</h3>
					<hr class="soft" />
					<div id="orderInfo">
						<div id="orderInfo">
							<!-- <h4>Ship To:</h4> -->
							<p />
							Order no: <strong style="color: blue;"><%=orderId%></strong> <br>Ordered
							Date: <strong><%=orderedDate%></strong> <br>Estimated
							Delivery Date: <strong><%=expectedDeliveryDate%></strong>
						</div>
						<table class="table table-bordered">
							<%
								ProductHelper.placeOrder(session);
							%>
							<thead>
								<tr>
									<th>Product</th>
									<th>Model</th>
									<th>Quantity</th>
									<th>Price</th>
								</tr>
							</thead>
							<%
								for (int i = 0; i < shoppingItemList.length; i++) {
											Product product = ProductHelper.getProductById(shoppingItemList[i]);
											if (product != null) {
												Double productPrice = ProductHelper.calculatePriceForProduct(product);
												totalPrice += productPrice;
							%>
							<tbody>
								<tr>
									<td><img width="60" src=<%=product.getImage()%> alt="" />
									</td>
									<td><%=product.getName()%></td>
									<td>1</td>
									<td><%=product.getPrice()%></td>
								</tr>
								<%
									}
											}
											if (totalPrice != 0D) {
								%>
								<tr>
									<td colspan=3 style="text-align: right"><strong>TOTAL
											PRICE =</strong></td>
									<td class="label label-important" style="display: block">
										<strong> <%=totalPrice%>
									</strong>
									</td>
								</tr>
							</tbody>
						</table>
						<a href="index.jsp" class="btn btn-large"> <i
							class="icon-arrow-left"></i> Continue Shopping
						</a>
					</div>
				</div>
			</div>
		</div>
		<span id="themesBtn"></span>
		<%
			}
		%>
		<%
			}
			} else if (myOrders != null || isOrderDeleted != null) {
				
				List<Map<String, String>> myOrdersMapList = MySQLDataStoreUtilities.fetchOrdersByUserInfo(session);
				if (myOrdersMapList != null) {
		%>
		<div id="mainBody">
			<div class="container">
				<div class="row">
					<div class="span9">
						<ul class="breadcrumb">
							<li><a href="index.jsp">Home</a> <span class="divider">/</span>
							</li>
							<li class="active">SHOPPING CART</li>
						</ul>
						<%if (isOrderDeleted != null) {%>
					<div style="font-size: x-large;color: blue;">Order Deleted Successfully!</div><br/>
					<%session.removeAttribute("isOrderDeleted");
				} %>
						<h3>SHOPPING CART</h3>
						<hr class="soft" />
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>Order No.</th>
									<th>Product</th>
									<th>Ordered date</th>
									<th>Delivery Date</th>
									<th>Amount</th>
									<th>Cancel Order</th>
								</tr>
							</thead>
							<%
								if (!myOrdersMapList.isEmpty()) {
											for (Map<String, String> ordersMap : myOrdersMapList) {
												String orderId = "";
												String productNames = "";
												String oDate = "";
												String dDate = "";
												String amount = "";
												String shippingAddress = "";
												for (Entry<String, String> productDetails : ordersMap.entrySet()) {
													if (productDetails.getKey().equals("orderId")) {
														orderId = productDetails.getValue();
													}
													if (productDetails.getKey().equals("productId")) {
														productNames = ProductHelper.getProductNames(productDetails.getValue());
													}
													if (productDetails.getKey().equals("oDate")) {
														oDate = productDetails.getValue();
													}
													if (productDetails.getKey().equals("dDate")) {
														dDate = productDetails.getValue();
													}
													if (productDetails.getKey().equals("amount")) {
														amount = productDetails.getValue();
													}
													if (productDetails.getKey().equals("shippingAddress")) {
														shippingAddress = productDetails.getValue();
													}
												}
							%>
							<tbody>
								<tr>
									<td><%=orderId%></td>
									<td><%=productNames%></td>
									<td><%=oDate%></td>
									<td><%=dDate%></td>
									<td><%=amount%></td>
									<td><div class="input-append">
											<form action="index.jsp" method="GET">
												<div class="input-append" style="padding-left: 36px;">
													<input type="hidden" value=<%=orderId%> name="hdnOrderId" />
													<button class="btn btn-danger" type="submit">
														<i class="icon-remove icon-white"></i>
													</button>
												</div>
											</form>
										</div></td>
								</tr>
							</tbody>
							<%
								}
							%>
						</table>
						<a href="index.jsp" class="btn btn-large"> <i
							class="icon-arrow-left"></i> Continue Shopping
						</a>
					</div>
				</div>
			</div>
		</div>
		<%
			} else {
		%>
		<thead>
			<div>No Data Found!</div>
			</table>
			<a href="index.jsp" class="btn btn-large"> <i
				class="icon-arrow-left"></i> Continue Shopping
			</a>
	</div>
	</div>
	</div>
	</div>
	<%
		}
	%>
	<%
		} else {
	%>
	<div id="mainBody">
		<div class="container">
			<div class="row">
				<div class="span9">
					<ul class="breadcrumb">
						<li><a href="index.jsp">Home</a> <span class="divider">/</span>
						</li>
						<li class="active">SHOPPING CART</li>
					</ul>
					<h3>SHOPPING CART</h3>
					<hr class="soft" />
					<table class="table table-bordered">
						<thead id="productCheckout">
							<div>No Data Found!</div>
					</table>
					<a href="index.jsp" class="btn btn-large"> <i
						class="icon-arrow-left"></i> Continue Shopping
					</a>
				</div>
			</div>
		</div>
	</div>
	<%
		}
	%>
	<%
		} else if (deleteProductId != null) {
			String existingShoppingItemIds = (String) session.getAttribute("shoppingItemId");
			String[] updatedShoppingIds = existingShoppingItemIds.split(",");
			for (int i = 0; i < updatedShoppingIds.length; i++) {
				if (updatedShoppingIds[i].equals(deleteProductId)) {
					updatedShoppingIds[i] = "";
					break;
				}
			}
			String commaSeperatedId = ProductHelper.getUpdatedShoppingIdsinCsvFormat(updatedShoppingIds);
			session.setAttribute("shoppingItemId", commaSeperatedId);
			session.setAttribute("showMyCartItems", true);
			response.sendRedirect("index.jsp");
		} else if(deleteOrderId != null){
			MySQLDataStoreUtilities.deleteOrder(deleteOrderId);
			session.setAttribute("isOrderDeleted", true);
			response.sendRedirect("index.jsp");
		} else if (productReviewId != null) {
			if (userName != null) {
	%>
	<%@include file="write_review.jsp"%>
	<%
		} else {
	%>
	<%@include file="login.jsp"%>
	<%
		}
	%>
	<%
		} else if (storeProductReview != null) {
			Map<String, String> reviewMap = new HashMap<String, String>();
			Enumeration<String> reviewEnum = request.getParameterNames();
			request.getParameterMap();
			while (reviewEnum.hasMoreElements()) {
				String parameter = reviewEnum.nextElement();
				String value = request.getParameter(parameter);
				reviewMap.put(parameter, value);
			}
			MongoDBDataStoreUtilities.storeProductReviews(reviewMap);
	%>
	<div id="mainBody">
		<div class="container">
			<div class="row">
				<div class="span9">
					<ul class="breadcrumb">
						<li><a href="index.jsp">Home</a> <span class="divider">/</span></li>
						<li class="active">View Review</li>
					</ul>
					<h3 style="color: blue">Thanks for your review!</h3>
					<hr class="soft" />
				</div>
			</div>
		</div>
	</div>
	<%
		} else if (viewProductReviewId != null) {
			Product product = ProductHelper.getProductById(viewProductReviewId);
			Map<String, ArrayList<ProductReview>> reviewMap = MongoDBDataStoreUtilities.getProductReviews();
			ArrayList<ProductReview> productReviewList = reviewMap.get(viewProductReviewId);
	%>

	<div id="mainBody">
		<div class="container">
			<div class="row">
				<div class="span9">
					<ul class="breadcrumb">
						<li><a href="index.jsp">Home</a> <span class="divider">/</span>
						</li>
						<li class="active">View Review</li>
					</ul>
					<h3 style="color: blue">
						User Reviews for
						<%=product.getName()%>
						-
						<%=product.getCategory()%></h3>
					<hr class="soft" />

					<%
						if (productReviewList != null) {
								for (ProductReview productReview : productReviewList) {
					%>
					<div id="orderInfo">
						<div id="orderInfo">
							<span>Retailer Name: <strong><%=productReview.getProductModelName()%></strong>
							</span> <span style="float: right">Retailer Location: <strong><%=productReview.getCity()%>,<%=productReview.getState()%></strong>
							</span> <br /> <span>Manufacturer Name: </span> <span
								style="float: right">Manufacturer Rebate: <strong><%=productReview.getMfgRebate()%>%
							</strong>
							</span>
						</div>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>User</th>
									<th>Price</th>
									<th>Rating</th>
									<th>Remarks</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><%=productReview.getUserName()%></td>
									<td>$<%=productReview.getProductPrice()%></td>
									<td><%=productReview.getRating()%></td>
									<td><%=productReview.getComments()%></td>
								</tr>
							</tbody>
						</table>
					</div>
					<%
						}
							} else {
					%>
					<strong>NO DATA FOUND</strong><br />
					<%
						}
					%>
					<a href="index.jsp" class="btn btn-large"> <i
						class="icon-arrow-left"></i> Back
					</a>
				</div>
			</div>
		</div>
	</div>
	<span id="themesBtn"></span>
	<%
		} else if (trendingNow != null) {
			ArrayList<DBObject> productArrayList = MongoDBDataStoreUtilities.getTopFiveProductBasedOnRatings();
			Map<String, ArrayList<ProductReview>> reviewMap = MongoDBDataStoreUtilities.getProductReviews();
			ArrayList<DBObject> productListTopFiveSold = MongoDBDataStoreUtilities.getTopFiveSoldProducts();
			ArrayList<DBObject> productListTopFiveZipCode = MongoDBDataStoreUtilities
					.getTopFiveProductBasedOnZipCode();
	%>
	<div>
		<h3>Top 5 Products based on review rating</h3>
	</div>
	<div class="tab-content" style="height: 700px; width: 990px;">
		<div class="tab-pane  active" id="blockView">
			<!-- Start of top 5-->
			<ul class="thumbnails">

				<%
					for (DBObject dbObject : productArrayList) {
							Map<String, String> productHashMap = (Map<String, String>) dbObject.get("_id");
							Product product = ProductHelper.getProductById(productHashMap.get("productReviewId"));
				%>
				<li class="span15">
					<div class="thumbnail" style="height: 320px; width: 150px;">
						<a href="HomeServlet?id=<%=product.getId()%>"
							style="padding-bottom: 30px;"> <img
							src=<%=product.getImage()%> alt="" />
						</a>
						<div class="caption">
							<h5><%=product.getName()%></h5>
							<span style="padding-right: 17px;">Rating</span> <input
								type="text" readonly value=<%=productHashMap.get("rating")%>
								style="width: 25px; text-align: center;" />
						</div>
					</div>
				</li>
				<%
					}
				%>
			</ul>
			<!-- End of top 5-->
			<!-- Start of top 5 sold-->
			<div>
				<h3>Top 5 Sold Products</h3>
			</div>
			<div class="tab-content" style="height: 700px; width: 990px;">
				<div class="tab-pane  active" id="blockView">
				<ul class="thumbnails">
					<%
						for (DBObject dbObject : productListTopFiveSold) {
								productId = (String) dbObject.get("productReviewId");
								Product product = ProductHelper.getProductById(productId);
					%>
					<li class="span15">
						<div class="thumbnail" style="height: 320px; width: 150px;">
							<a href="index.jsp?id=<%=product.getId()%>"> <img
								src=<%=product.getImage()%> alt="" />
							</a>
							<div class="caption">
								<h5><%=product.getName()%></h5>
								<span style="padding-right: 17px;">Count</span> <input
									type="text" readonly value=<%=dbObject.get("count")%>
									style="width: 25px; text-align: center;" />
							</div>
						</div>
					</li>
					<%
						}
					%>
					</ul>
					<!-- End of top 5 sold-->
					<!-- Start of top 5 - Zip code-->
					<div>
						<div>
							<h3>Top 5 Products based on Zip Code</h3>
						</div>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>Zip Code</th>
									<th>No. Of Products Sold</th>
								</tr>
							</thead>
							<%
								for (DBObject dbObject : productListTopFiveZipCode) {
							%>
							<tr>
								<td><%=dbObject.get("zipCode")%></td>
								<td><%=dbObject.get("count")%></td>
							</tr>
							<%
								}
							%>
						</table>
					</div>
					<!-- End of top 5 - Zip code-->
					<hr class="soft" />
				</div>
			</div>
		</div>
	</div>
	<%
		} else if (isDataAnalytics != null) {
	%>
	<%@include file="data_analytics.jsp"%>
	<%
		} else if (dataAnalyticsInputRequest != null) {

			List<ProductReview> productReviewList = MongoDBDataStoreUtilities
					.getSearchResultsBasedOnFormInput(request);
	%>
	<div id="mainBody">
		<div class="container">
			<div class="row">
				<div class="span9">
					<ul class="breadcrumb">
						<li><a href="index.jsp">Home</a> <span class="divider">/</span></li>
						<li class="active">Data Analytics</li>
					</ul>
					<h3 style="color: blue">Data Analytics Results</h3>
					<hr class="soft" />
					<%
						for (ProductReview productReview : productReviewList) {
					%>
					<div id="orderInfo">
						<div id="orderInfo">
							<span>Retailer Name: <strong><%=productReview.getRetailerName()%></strong></span><span
								style="float: right">Retailer Location: <strong><%=productReview.getCity()%>,<%=productReview.getState()%></strong></span><br />
							<span>Manufacturer Name: <strong><%=productReview.getMfgName()%></strong></span><span
								style="float: right">Manufacturer Rebate: <strong><%=productReview.getMfgRebate()%>%
							</strong></span>
						</div>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>User</th>
									<th>Price</th>
									<th>Rating</th>
									<th>Remarks</th>
								</tr>
							</thead id="orderInfo">
							<tbody>
								<tr>
									<td><%=productReview.getUserName()%></td>
									<td><%=productReview.getProductPrice()%></td>
									<td><%=productReview.getRating()%></td>
									<td><%=productReview.getComments()%></td>
								</tr>
							</tbody>
						</table>
					</div>
					<%
						}
					%>
					<a href="index.jsp" class="btn btn-large"><i
						class="icon-arrow-left"></i> Back To Home Screen</a>
				</div>
			</div>
		</div>
	</div>
	<span id="themesBtn"></span>
	<%
		} else {
	%>
	<div class="span9">
		<ul class="breadcrumb">
			<li><a href="index.jsp">Home</a> <span class="divider">/</span>
			</li>
			<li class="active">Products Name</li>
		</ul>
		<h3>
			Featured Products <small class="pull-right"></small>
		</h3>
		<hr class="soft" />
		<p>BestDeals.com is a lot like your neighborhood Walmart store. We
			feature a great selection of high-quality merchandise, friendly
			service and, of course, Every Day Low Prices. We also have another
			goal: to bring you the best shopping experience on the Internet.</p>
		<hr class="soft" />
		<br class="clr" />
		<div class="tab-content">
			<div class="tab-pane  active" id="blockView">
				<ul class="thumbnails">
					<%
						List<String> categoryList = new ArrayList<String>();
							for (Product product : productList) {
								if (categoryList.contains(product.getCategory())) {
									continue;
								} else {
					%>
					<li class="span3">
						<div class="thumbnail">
							<a href="index.jsp?id=<%=product.getId()%>"> <img
								src=<%=product.getImage()%> alt="" /></a>
							<div class="caption">
								<h5><%=product.getName()%></h5>
								<h4 style="text-align: center">
									<a class="btn"
										href="index.jsp?shoppingItemId=<%=product.getId()%>"> Add
										to <i class="icon-shopping-cart"></i>
									</a> <a class="btn btn-primary" href="#"><%=product.getPrice()%></a>
									<a class="btn btn-primary"
										href="index.jsp?productReviewId=<%=product.getId()%>"
										style="width: 130px">Write Reviews</a> <a
										class="btn btn-primary"
										href="index.jsp?viewProductReview=<%=product.getId()%>"
										style="width: 130px">View Reviews</a>
								</h4>
							</div>
						</div>
					</li>
					<%
						categoryList.add(product.getCategory());
								}
							}
					%>
				</ul>
				<hr class="soft" />
			</div>
		</div>
	</div>
	<%
		}
	%>

</body>
</html>