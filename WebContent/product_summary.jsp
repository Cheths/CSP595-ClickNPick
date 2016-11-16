<!DOCTYPE html>
<%@page import="javax.sql.rowset.serial.SerialArray"%>
<%@page import="java.util.Map"%>
<%@page import="com.csp595.utilities.SaxParserProductXMLdataStore"%>
<%@page import="com.csp595.beans.Product"%>
<html lang="en">
<body>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<script type="text/javascript">
	function addQty() {
		document.getElementById("appendedInputButtons");
	}
</script>
<!-- Header End====================================================================== -->
<% Map<String, Product> productHashMap = SaxParserProductXMLdataStore.getProductHashMap(); %>
<% String shoppingItemId = request.getParameter("shoppingItemId");
	final int tax = 15;
	String existingShoppingItemId = (String) session.getAttribute("shoppingItemId");
	String[] csvProductIds = new String[100];
	if(shoppingItemId != null){
		existingShoppingItemId += ","+shoppingItemId;
		
		if(existingShoppingItemId.startsWith(",")){
			existingShoppingItemId = existingShoppingItemId.substring(1);
		}
		session.setAttribute("shoppingItemId", existingShoppingItemId);
		csvProductIds = existingShoppingItemId.split(",");
	}
	
	%>
	<div id="mainBody">
	<div class="container">
	<div class="row">

	<div class="span9">
    <ul class="breadcrumb">
		<li><a href="index.html">Home</a> <span class="divider">/</span></li>
		<li class="active"> SHOPPING CART</li>
    </ul>
	<h3>  SHOPPING CART [ <small>3 Item(s) </small>]<a href="index.jsp" class="btn btn-large pull-right"><i class="icon-arrow-left"></i> Continue Shopping </a></h3>	
	<hr class="soft"/>
	<table class="table table-bordered">
		<tr><th> I AM ALREADY REGISTERED  </th></tr>
		 <tr> 
		 <td>
			<form class="form-horizontal">
				<div class="control-group">
				  <label class="control-label" for="inputUsername">Username</label>
				  <div class="controls">
					<input type="text" id="inputUsername" placeholder="Username">
				  </div>
				</div>
				<div class="control-group">
				  <label class="control-label" for="inputPassword1">Password</label>
				  <div class="controls">
					<input type="password" id="inputPassword1" placeholder="Password">
				  </div>
				</div>
				<div class="control-group">
				  <div class="controls">
					<button type="submit" class="btn">Sign in</button> OR <a href="register.html" class="btn">Register Now!</a>
				  </div>
				</div>
				<div class="control-group">
					<div class="controls">
					  <a href="forgetpass.html" style="text-decoration:underline">Forgot password ?</a>
					</div>
				</div>
			</form>
		  </td>
		  </tr>
	</table>		
			
	<table class="table table-bordered">
              <thead>
                <tr>
                  <th>Product</th>
                  <th>Description</th>
                  <th>Quantity/Update</th>
				  <th>Price</th>
                  <th>Discount</th>
                  <th>Tax</th>
                  <th>Total</th>
				</tr>
              </thead>
              <tbody>
              <%
              double checkoutAmount = 0;
              double totalPrice = 0;
              double totalDiscount = 0;
              double totalTax = 0;
              if(csvProductIds != null){
              for(int i=0;i<csvProductIds.length;i++){
            	  Product product = productHashMap.get(csvProductIds[i]);
	            	  if (product != null){
		            	  double price = product.getPrice();
		            	  totalPrice += price; 
		            	  double discount = product.getDiscount();
		            	  totalDiscount += discount;
		            	  totalTax += tax;
		            	  double individualProductTotal = price - discount + tax;
		            	  checkoutAmount += individualProductTotal;%>
		            	  <tr>
		                  <td> <img width="60" src="themes/images/products/4.jpg" alt=""/></td>
		                  <td><%=product.getName()%><br/>Color : black, Material : metal</td>
						  <td>
							<div class="input-append"><input class="span1" style="max-width:34px" placeholder="1" id="appendedInputButtons" size="16" type="text"><button class="btn" type="button" onclick="addQty()"><i class="icon-minus"></i></button><button class="btn" type="button"><i class="icon-plus"></i></button><button class="btn btn-danger" type="button"><i class="icon-remove icon-white"></i></button>				</div>
						  </td>
		                  <td>$<%=product.getPrice()%></td>
		                  <td>$<%=product.getDiscount()%></td>
		                  <td>$<%=tax %></td>
		                  <td>$<%=individualProductTotal %></td>
		                </tr>
             <% } } }
//             	session.setAttribute("checkoutAmount", arg1)
%>
				
                <tr>
                  <td colspan="6" style="text-align:right">Total Price:	</td>
                  <td><%=totalPrice%></td>
                </tr>
				 <tr>
                  <td colspan="6" style="text-align:right">Total Discount:	</td>
                  <td><%=totalDiscount%></td>
                </tr>
                 <tr>
                  <td colspan="6" style="text-align:right">Total Tax:	</td>
                  <td> $<%=totalTax%></td>
                </tr>
				 <tr>
                  <td colspan="6" style="text-align:right"><strong>TOTAL ($<%=totalPrice%> - $<%=totalDiscount%> + $<%=totalTax%>) =</strong></td>
                  <td class="label label-important" style="display:block"> <strong> $<%=checkoutAmount%> </strong></td>
                </tr>
				</tbody>
            </table>
		
		
            <table class="table table-bordered">
			<tbody>
				 <tr>
                  <td> 
				<form class="form-horizontal">
				<div class="control-group">
				<label class="control-label"><strong> VOUCHERS CODE: </strong> </label>
				<div class="controls">
				<input type="text" class="input-medium" placeholder="CODE">
				<button type="submit" class="btn"> ADD </button>
				</div>
				</div>
				</form>
				</td>
                </tr>
				
			</tbody>
			</table>
		
	<a href="index.jsp" class="btn btn-large"><i class="icon-arrow-left"></i> Continue Shopping </a>
	<a href="shipping_info.jsp?checkoutAmount=<%=checkoutAmount %>" class="btn btn-large pull-right">Next <i class="icon-arrow-right"></i></a>
	
</div>
</div></div>
</div></div>
<!-- MainBody End ============================= -->
<%@include file="footer.jsp" %>
</body>
</html>