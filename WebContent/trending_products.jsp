<%@page import="com.csp595.beans.TrendingProduct"%>
<%@page import="com.csp595.utilities.SaxParserProductXMLdataStore"%>
<%@page import="com.csp595.beans.Product"%>
<%@page import="com.csp595.utilities.MongoUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@include file="header.jsp"%>
<%@include file="sidebar.jsp"%>
<html lang="en">
<body>
	<div id="mainBody">
		<div class="container">
			<div class="row">
			<div class="span9">	
				<div class="well well-small">
					<div class="row-fluid">
						<div id="featured" class="">
							<div class="carousel-inner">
								<div class="item active">
									<!-- Top five most sold products regardless of the rating-->
									<%
										List<Map<String, String>> topSoldProductList = MongoUtil.getTopSoldProducts();
									%>
									<ul class="thumbnails">
										<h4>
											Top five Trending Products
										</h4>
										<%for (Map<String, String> topSoldProduct : topSoldProductList) {
											Product product = SaxParserProductXMLdataStore.getProductByName((String) topSoldProduct.keySet().toArray()[0]);%>
											<li class="span3">
												<div class="thumbnail">
													<i class="tag"></i> 
													<a href="product_details.jsp?productId=<%=product.getId()%>">
														<img src="themes/images/products/new/<%=product.getImage()%>" alt="">
													</a>
													<div class="caption">
														<h5><%=product.getName()%></h5>
														<h4>
															<a class="btn" href="product_details.jsp?productId=<%=product.getId()%>">VIEW</a> <span
																class="pull-right">$<%=product.getPrice() %></span>
														</h4>
													</div>
													<h5> Purchase Count:
													<%=topSoldProduct.values().toArray()[0]%></h5>
												</div>
											</li>
											<%} %>
										</ul>
										
										<!-- Top five most liked products-->
										<ul class="thumbnails">
										<h4>
											Top five Liked Products
										</h4>
										<%
											List<TrendingProduct> mostLikedProductList = MongoUtil.getTopFiveLikedProducts();
										%>
										<%for (TrendingProduct trendingProduct : mostLikedProductList) {
											Product product = SaxParserProductXMLdataStore.getProductByID(trendingProduct.getProductId());%>
											<li class="span3">
												<div class="thumbnail">
													<i class="tag"></i> 
													<a href="product_details.jsp?productId=<%=product.getId()%>">
														<img src="themes/images/products/new/<%=product.getImage()%>" alt="">
													</a>
													<div class="caption">
														<h5><%=product.getName()%></h5>
														<h4>
															<a class="btn" href="product_details.jsp?productId=<%=product.getId()%>">VIEW</a>
															<span class="pull-right">$<%=product.getPrice() %></span>
														</h4>
													</div>
													<h5>Rating <%=trendingProduct.getReviewRating()%></h5>
												</div>
											</li>
											<%} %>
										</ul>
										
										<!-- Top five zip-codes where maximum number of products sold -->
										 <ul class="thumbnails">
										<h4>Top five zip-codes where maximum number of products sold</h4>
										<%	
										List<Map<String, String>> zipCodeReviewCountMapList = MongoUtil.getMostReviewsInZipCode();
											if (!zipCodeReviewCountMapList.isEmpty()) {
										%>
										<table>
											<tbody>
												<tr>
													<th>Zip Code</th>
													<th>Max number of products reviewed to zip code</th>
													<%
														for (Map<String, String> zipCodeReviewCountMap : zipCodeReviewCountMapList) {
													%>
												
												<tr>
													<td><%=zipCodeReviewCountMap.keySet().toArray()[0]%></td>
													<td><%=zipCodeReviewCountMap.values().toArray()[0]%></td>
												</tr>
												<%
													}
												%>
											</tbody>
										</table>
										<%} %>
									 </ul>
									
								</div>
							</div>
						</div>
					</div>
				</div>
				</div>
			</div>
		</div>
	</div>
</body>
<%@include file="footer.jsp"%>
</html>