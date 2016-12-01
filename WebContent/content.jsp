<!DOCTYPE html>
<%@page import="com.csp595.utilities.SaxParserProductXMLdataStore"%>
<%@page import="java.util.Map"%>
<%@page import="com.csp595.beans.Product"%>
<%@page import="java.util.Map.Entry"%>
<html lang="en">

<body>
	<div id="mainBody">
	<div class="container">
	<div class="row">
	<div class="span9">
		<% if(request.getParameter("writeReview") != null){
		%>
		<div class="alert" style="background-color: #5bb75b;">
		 <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
		 <strong>Success!</strong> Review Successfully Submitted
		</div>
		<%}else if(request.getAttribute("mongoConnectionError") != null){ %>
		<div class="alert" style="background-color: #f44336;">
		 <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
		 <strong>Failure!</strong>Unable to submit review as Mongo Db is not connected
		</div>
		<%} %>
			<div class="well well-small">
			<h4>Featured Products <small class="pull-right">200+ featured products</small></h4>
			<div class="row-fluid">
			<div id="featured" class="carousel slide">
			<div class="carousel-inner">
			  <div class="item active">
			  <ul class="thumbnails">
				<li class="span3">
				  <div class="thumbnail">
				  <i class="tag"></i>
					<a href="product_details.jsp?productId=6"><img
						src="themes/images/products/new/Alba.jpg" alt="" /></a>
					<div class="caption">
					  <h5>Alba</h5>
					  <h4><a class="btn" href="product_details.jsp?productId=6">VIEW</a> <span class="pull-right">$25.00</span></h4>
					</div>
				  </div>
				</li>
				<li class="span3">
				  <div class="thumbnail">
				  <i class="tag"></i>
					<a href="product_details.jsp?productId=30"><img src="themes/images/products/new/AllenSolly.jpg" alt=""></a>
					<div class="caption">
					  <h5>Allen Solly</h5>
					  <h4><a class="btn" href="product_details.jsp?productId=30">VIEW</a> <span class="pull-right">$50.00</span></h4>
					</div>
				  </div>
				</li>
				<li class="span3">
				  <div class="thumbnail">
				  <i class="tag"></i>
					<a href="product_details.jsp?productId=68"><img src="themes/images/products/new/MFortCollinsjacket.jpg" alt=""></a>
					<div class="caption">
					  <h5>Fort Collins</h5>
					   <h4><a class="btn" href="product_details.jsp?productId=59">VIEW</a> <span class="pull-right">$60.00</span></h4>
					</div>
				  </div>
				</li>
				<li class="span3">
				  <div class="thumbnail">
				  <i class="tag"></i>
					<a href="product_details.jsp?productId=59"><img src="themes/images/products/new/WROGN.jpg" alt=""></a>
					<div class="caption">
					  <h5>WROGN</h5>
					   <h4><a class="btn" href="product_details.jsp?productId=59">VIEW</a> <span class="pull-right">$49.00</span></h4>
					</div>
				  </div>
				</li>
			  </ul>
			  </div>
			   <div class="item">
			  <ul class="thumbnails">
				<li class="span3">
				  <div class="thumbnail">
				  <i class="tag"></i>
					<a href="product_details.jsp?productId=22"><img src="themes/images/products/new/WRoadstersweater.jpg" alt=""></a>
					<div class="caption">
					  <h5>Roadster</h5>
					  <h4><a class="btn" href="product_details.jsp?productId=22">VIEW</a> <span class="pull-right">$29.00</span></h4>
					</div>
				  </div>
				</li>
				<li class="span3">
				  <div class="thumbnail">
				  <i class="tag"></i>
					<a href="product_details.jsp?productId=15"><img src="themes/images/products/new/Mango.jpg" alt=""></a>
					<div class="caption">
					  <h5>Mango</h5>
					  <h4><a class="btn" href="product_details.jsp?productId=15">VIEW</a> <span class="pull-right">$40.00</span></h4>
					</div>
				  </div>
				</li>
				<li class="span3">
				  <div class="thumbnail">
					<a href="product_details.jsp?productId=95"><img src="themes/images/products/new/Toy Balloon.jpg" alt=""></a>
					<div class="caption">
					  <h5>Toy Balloon</h5>
					   <h4><a class="btn" href="product_details.jsp?productId=95">VIEW</a> <span class="pull-right">$40.00</span></h4>
					</div>
				  </div>
				</li>
				<li class="span3">
				  <div class="thumbnail">
					<a href="product_details.jsp?productId=81"><img src="themes/images/products/new/Juniors.jpg" alt=""></a>
					<div class="caption">
					  <h5>Juniors</h5>
					   <h4><a class="btn" href="product_details.jsp?productId=81">VIEW</a> <span class="pull-right">$18.00</span></h4>
					</div>
				  </div>
				</li>
			  </ul>
			  </div>
			   <div class="item">
			  <ul class="thumbnails">
				<li class="span3">
				  <div class="thumbnail">
					<a href="product_details.jsp?productId=48"><img src="themes/images/products/new/Arrow.jpg" alt=""></a>
					<div class="caption">
					  <h5>Arrow</h5>
					  <h4><a class="btn" href="product_details.jsp?productId=48">VIEW</a> <span class="pull-right">$32.00</span></h4>
					</div>
				  </div>
				</li>
				<li class="span3">
				  <div class="thumbnail">
					<a href="product_details.jsp?productId=37"><img src="themes/images/products/new/MAdidastshirt.jpg" alt=""></a>
					<div class="caption">
					  <h5>Adidas</h5>
					  <h4><a class="btn" href="product_details.jsp?productId=37">VIEW</a> <span class="pull-right">$20.00</span></h4>
					</div>
				  </div>
				</li>
				<li class="span3">
				  <div class="thumbnail">
					<a href="product_details.jsp?productId=42"><img src="themes/images/products/new/LPSport.jpg" alt=""></a>
					<div class="caption">
					  <h5>LP Sport</h5>
					   <h4><a class="btn" href="product_details.jsp?productId=42">VIEW</a> <span class="pull-right">$27.00</span></h4>
					</div>
				  </div>
				</li>
				<li class="span3">
				  <div class="thumbnail">
					<a href="product_details.jsp?productId=24"><img src="themes/images/products/new/Dressberry.jpg" alt=""></a>
					<div class="caption">
					  <h5>Dress Berry</h5>
					   <h4><a class="btn" href="product_details.jsp?productId=24">VIEW</a> <span class="pull-right">$40.00</span></h4>
					</div>
				  </div>
				</li>
			  </ul>
			  </div>
			   
			  </div>
			  <a class="left carousel-control" href="#featured" data-slide="prev">&lsaquo;</a>
			  <a class="right carousel-control" href="#featured" data-slide="next">&rsaquo;</a>
			  </div>
			  </div>
		</div>
	<!--  	<h4>Latest Products </h4>
			  <ul class="thumbnails">
			<%
				if (!productHashMap.isEmpty()) {
					for (Entry<String, Product> productEntry :productHashMap
							
							.entrySet()) {
						Product product = productEntry.getValue();
			%>
			<li class="span3">
				<div class="thumbnail">
					<a href="product_details.jsp?productId=<%=product.getId()%>"><img
						src="themes/images/products/<%= product.getImage() %>" alt="" /></a>
					<div class="caption">
						<h5><%=product.getName() %></h5>
						<h4 style="text-align: center">
						<%if(userName != null){%>
							<a class="btn" href="product_summary.jsp?shoppingItemId=<%=product.getId()%>"> Add to <i class="icon-shopping-cart"></i></a>
						<%} else {%>
							<a class="btn" href="login.jsp"> Add to <i class="icon-shopping-cart"></i></a>
						<%}%> 
							<a class="btn btn-primary" href="#"><%=product.getPrice() %></a>
							<a class="btn btn-primary" href="write_product_reviews.jsp?showReviewSection=<%=product.getId()%>" style="width:130px">Write Review</a>
						<a class="btn btn-primary" href="read_product_reviews.jsp?readProductReview=<%=product.getId()%>"  style="width:130px">View Reviews</a>
						</h4>
					</div>
				</div>
			</li>
			<%
				}
				}
			%>
		</ul>   -->	

		</div>		
		</div>
	</div>
</div>
		<!-- === -->
</body>
</html>