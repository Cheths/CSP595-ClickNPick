<!DOCTYPE html>
<%@page import="java.util.Map"%>
<%@page import="com.csp595.utilities.SaxParserProductXMLdataStore"%>
<%@page import="com.csp595.beans.Product"%>
<html lang="en">
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<body>
<% String productId = request.getParameter("productId");
	Product product = productHashMap.get(productId);
	%>
	<div class="row">
	<div class="span9">
    <ul class="breadcrumb">
    <li><a href="index.jsp">Home</a> <span class="divider">/</span></li>
    <li><a href="index.jsp">Products</a> <span class="divider">/</span></li>
    <li class="active">Product Details</li>
    </ul>	
	<div class="row">	  
			<div id="gallery" class="span3">
            <a href="product_summary.jsp?shoppingItemId=<%=product.getId()%>" title=<%=product.getName()%>>
				<img src="themes/images/products/new/<%= product.getImage()%>" style="width:100%" alt=<%=product.getName()%>/>
            </a>
			<div id="differentview" class="moreOptopm carousel slide">
                <div class="carousel-inner">
                  <div class="item active">
                  
                  </div>
                  <div class="item">
                   
                  </div>
                </div>
              </div>
			  
			 <!-- <div class="btn-toolbar">
			  <div class="btn-group">
				<span class="btn"><i class="icon-envelope"></i></span>
				<span class="btn" ><i class="icon-print"></i></span>
				<span class="btn" ><i class="icon-zoom-in"></i></span>
				<span class="btn" ><i class="icon-star"></i></span>
				<span class="btn" ><i class=" icon-thumbs-up"></i></span>
				<span class="btn" ><i class="icon-thumbs-down"></i></span>
			  </div>
			</div> -->
			</div>
			<div class="span6">
				<h3><%=product.getName()%></h3>
				<hr class="soft "/>
				<p>
				<%=product.getDescription()%>
				</p>
				
			
				<hr class="soft"/>
				<form class="form-horizontal qtyFrm">
				  <div class="control-group">
				  <label class="control-label"><span>Price</span></label>
					<label class="control-label"><span>$<%=product.getPrice()%></span></label>
					 </div>
				</form>
				
				<hr class="soft"/>
				<form class="form-horizontal qtyFrm">
				  <div  class="control-group">
					<label class="control-label" ><span>Color</span></label>
					<div class="controls">
					  <select class="span2">
						  <option>Black</option>
						  <option>Red</option>
						  <option>Blue</option>
						  <option>Brown</option>
						</select>
						<br/>
						<br/>

								<!-- <input type="number" class="span1" placeholder="Qty."/>-->
								<%
									if (session.getAttribute("userName") != null) {
								%>
								<a class="btn btn-large btn-primary pull-right"
									href="product_summary.jsp?shoppingItemId=<%=product.getId()%>"
									style="width: 110px";>Add to cart </a> 
								<a class="btn btn-large btn-primary"
									href="write_product_reviews.jsp?showReviewSection=<%=product.getId()%>"
									style="width: 110px; margin-bottom: 10px;">Write Review</a> 
								<a
									class="btn btn-large btn-primary"
									href="read_product_reviews.jsp?readProductReview=<%=product.getId()%>"
									style="width: 110px ; margin-bottom: 10px;">View Reviews</a>
								<%
									} else {
								%>
								<a class="btn btn-large btn-primary pull-right" href="login.jsp"> Add to cart</a>
					 <%} %>	
					</div>
				  </div>
				</form>
			
					
					
			</div>
	</div>
</div>
</div> 
</div>
</div>
<!-- MainBody End ============================= -->
</body>
<%@include file="footer.jsp" %>
</html>