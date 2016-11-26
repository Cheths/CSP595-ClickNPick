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
			<li class="subMenu"><a> WOMEN  </a>
			<ul style="display:none">
				<li><a href="products.jsp?gender=female&category=tops"><i class="icon-chevron-right"></i>Tops,T-Shirts & Shirts </a></li>
				<li><a href="products.jsp?gender=female&category=jeans"><i class="icon-chevron-right"></i>Jeans </a></li>												
				<li><a href="products.jsp?gender=female&category=sweaters"><i class="icon-chevron-right"></i>Sweaters</a></li>	
				<li><a href="products.jsp?gender=female&category=jackets"><i class="icon-chevron-right"></i>Jackets</a></li>
				<li><a href="products.jsp?gender=female&category=blazers"><i class="icon-chevron-right"></i>Blazers</a></li>												
			</ul>
			</li>
			<li class="subMenu"><a>MEN</a>
				<ul style="display:none">
					<li><a href="products.jsp?gender=male&category=tshirt"><i class="icon-chevron-right"></i>T Shirts</a></li>
					<li><a href="products.jsp?gender=male&category=casual"><i class="icon-chevron-right"></i>Casual Shirts and Trousers</a></li>												
					<li><a href="products.jsp?gender=male&category=formal"><i class="icon-chevron-right"></i>Formal Shirts and Trousers</a></li>	
					<li><a href="products.jsp?gender=male&category=jeans"><i class="icon-chevron-right"></i>Jeans</a></li>
					<li><a href="products.jsp?gender=male&category=sweater"><i class="icon-chevron-right"></i>Sweaters</a></li>												
					<li><a href="products.jsp?gender=male&category=jacket"><i class="icon-chevron-right"></i>Jackets</a></li>												
				</ul>
			</li>
			<li class="subMenu"><a>KIDS</a>
				<ul style="display:none">
					<li><a href="products.jsp?gender=kids&category=clothingsets"><i class="icon-chevron-right"></i>Clothing Sets</a></li>
					<li><a href="products.jsp?gender=kids&category=boys"><i class="icon-chevron-right"></i>Boys T-Shirts</a></li>												
					<li><a href="products.jsp?gender=kids&category=girls"><i class="icon-chevron-right"></i>Girls Tops</a></li>	
					<li><a href="products.jsp?gender=kids&category=dresses"><i class="icon-chevron-right"></i>Girls Dresses</a></li>
			    </ul>
			</li>
			
			<li><a href="products.html"><blink>DONATE A SMILE :) [58]</blink></a></li>			
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