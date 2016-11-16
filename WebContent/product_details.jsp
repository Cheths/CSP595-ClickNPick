<!DOCTYPE html>
<%@page import="java.util.Map"%>
<%@page import="com.csp595.utilities.SaxParserProductXMLdataStore"%>
<%@page import="com.csp595.beans.Product"%>
<html lang="en">
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<body>
<% Map<String, Product> productHashMap = SaxParserProductXMLdataStore.getProductHashMap(); %>
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
				<img src="themes/images/products/large/3.jpg" style="width:100%" alt=<%=product.getName()%>/>
            </a>
			<div id="differentview" class="moreOptopm carousel slide">
                <div class="carousel-inner">
                  <div class="item active">
                   <a href="themes/images/products/large/f1.jpg"> <img style="width:29%" src="themes/images/products/large/f1.jpg" alt=""/></a>
                   <a href="themes/images/products/large/f2.jpg"> <img style="width:29%" src="themes/images/products/large/f2.jpg" alt=""/></a>
                   <a href="themes/images/products/large/f3.jpg" > <img style="width:29%" src="themes/images/products/large/f3.jpg" alt=""/></a>
                  </div>
                  <div class="item">
                   <a href="themes/images/products/large/f3.jpg" > <img style="width:29%" src="themes/images/products/large/f3.jpg" alt=""/></a>
                   <a href="themes/images/products/large/f1.jpg"> <img style="width:29%" src="themes/images/products/large/f1.jpg" alt=""/></a>
                   <a href="themes/images/products/large/f2.jpg"> <img style="width:29%" src="themes/images/products/large/f2.jpg" alt=""/></a>
                  </div>
                </div>
              </div>
			  
			 <div class="btn-toolbar">
			  <div class="btn-group">
				<span class="btn"><i class="icon-envelope"></i></span>
				<span class="btn" ><i class="icon-print"></i></span>
				<span class="btn" ><i class="icon-zoom-in"></i></span>
				<span class="btn" ><i class="icon-star"></i></span>
				<span class="btn" ><i class=" icon-thumbs-up"></i></span>
				<span class="btn" ><i class="icon-thumbs-down"></i></span>
			  </div>
			</div>
			</div>
			<div class="span6">
				<h3><%=product.getName()%></h3>
				<hr class="soft"/>
				<form class="form-horizontal qtyFrm">
				  <div class="control-group">
					<label class="control-label"><span><%=product.getPrice()%></span></label>
					<div class="controls">
					<input type="number" class="span1" placeholder="Qty."/>
					<% if(session.getAttribute("userName") != null){%>
						<a class="btn btn-large btn-primary pull-right" href="product_summary.jsp?shoppingItemId=<%=product.getId()%>"> Add to cart </a>
					 <%} else{ %>
					 	<a class="btn btn-large btn-primary pull-right" href="register.jsp"> Add to cart</a>
					 <%} %>	
					</div>
				  </div>
				</form>
				
				<hr class="soft"/>
				<form class="form-horizontal qtyFrm pull-right">
				  <div class="control-group">
					<label class="control-label"><span>Color</span></label>
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
				<hr class="soft clr"/>
				<p>
				<%=product.getDescription()%>
				</p>
			<hr class="soft"/>
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