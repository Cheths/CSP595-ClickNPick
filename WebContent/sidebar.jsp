<!DOCTYPE html>
<html lang="en">
<body>
<% String display = "";
String checkOutAmount = (String) session.getAttribute("checkoutAmount");
if(myCartCount == 0){
	display = "No Items in Cart";	
} else {
	display = myCartCount+" Items in your cart";
} %>
<!-- Sidebar ================================================== -->
	<div id="sidebar" class="span3">
		<div class="well well-small"><a id="myCart" href="product_summary.jsp?myCart=true"><img src="themes/images/ico-cart.png" alt="cart"><%=display %> 
		<% if(checkOutAmount != null){%>
			<span class="badge badge-warning pull-right">$ <%=checkOutAmount %></span>			
		<%} %>
		</a></div>
		<ul id="sideManu" class="nav nav-tabs nav-stacked">
			<!-- <li class="subMenu open"><a> ELECTRONICS [230]</a>
				<ul>
				<li><a class="active" href="products.html"><i class="icon-chevron-right"></i>Cameras (100) </a></li>
				<li><a href="products.html"><i class="icon-chevron-right"></i>Computers, Tablets & laptop (30)</a></li>
				<li><a href="products.html"><i class="icon-chevron-right"></i>Mobile Phone (80)</a></li>
				<li><a href="products.html"><i class="icon-chevron-right"></i>Sound & Vision (15)</a></li>
				</ul>
			</li> -->
			<li class="subMenu"><a> CLOTHES </a>
			<ul style="display:none">
				<li><a href="products.html"><i class="icon-chevron-right"></i>Women's Clothing </a></li>
				<li><a href="products.html"><i class="icon-chevron-right"></i>Women's Shoes </a></li>												
				<li><a href="products.html"><i class="icon-chevron-right"></i>Women's Hand Bags </a></li>	
				<li><a href="products.html"><i class="icon-chevron-right"></i>Men's Clothings </a></li>
				<li><a href="products.html"><i class="icon-chevron-right"></i>Men's Shoes </a></li>												
				<li><a href="products.html"><i class="icon-chevron-right"></i>Kids Clothing </a></li>												
				<li><a href="products.html"><i class="icon-chevron-right"></i>Kids Shoes </a></li>												
			</ul>
			</li>
			<li class="subMenu"><a>KIDS</a>
				<ul style="display:none">
					<li><a href="products.html"><i class="icon-chevron-right"></i>Angoves  </a></li>
					<li><a href="products.html"><i class="icon-chevron-right"></i>Bouchard Aine & Fils </a></li>												
					<li><a href="products.html"><i class="icon-chevron-right"></i>French Rabbit </a></li>	
					<li><a href="products.html"><i class="icon-chevron-right"></i>Louis Bernard  </a></li>
					<li><a href="products.html"><i class="icon-chevron-right"></i>BIB Wine (Bag in Box) </a></li>												
					<li><a href="products.html"><i class="icon-chevron-right"></i>Other Liquors & Wine </a></li>												
					<li><a href="products.html"><i class="icon-chevron-right"></i>Garden </a></li>												
					<li><a href="products.html"><i class="icon-chevron-right"></i>Khao Shong </a></li>												
				</ul>
			</li>
			<li><a href="products.html">MEN </a></li>
			<li><a href="products.html">WOMEN </a></li>
			<li><a href="products.html"><blink>DONATE A SMILE :) </blink></a></li>			
		</ul>
		<br/>
		<div class="thumbnail">
			<img src="themes/images/payment_methods.png" title="Bootshop Payment Methods" alt="Payments Methods">
			<div class="caption">
			  <h5>Payment Methods</h5>
			</div>
		</div>
		<a href="trending_products.jsp">
		<img style="width: 250px; height: 75px;" src="themes/images/trendingnow.png" alt="">
		</a>
	</div>
<!-- Sidebar end=============================================== -->

</body>
</html>