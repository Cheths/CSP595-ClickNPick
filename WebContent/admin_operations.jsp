<!DOCTYPE html">
<html>
<body>
	<%@include file="header.jsp"%>
	<%@include file="sidebar.jsp"%>

	<div class="row">
		<div class="span9">
		<a href="admin_operations.jsp" class="btn btn-large pull-right">Add Coupons <i class="icon-arrow-right"></i></a>
		
			<h3>Add Coupons</h3>
			<div class="well">
				<form action="payment_gateway.jsp" class="form-horizontal">
					<h4>Coupon Details</h4>
					<div class="control-group">
						<label class="control-label" for="couponCode">Coupon Code <sup>*</sup></label>
						<div class="controls">
							<input type="text" name="couponCode" id="couponCode" placeholder="COUPON CODE" required="required" /> 
						</div>
					</div>
				</form>
			</div>
			
			<a href="admin_operations.jsp" class="btn btn-large pull-right">Back <i class="icon-arrow-left"></i></a>
		</div>
	</div>

	<%@include file="footer.jsp"%>
</body>
</html>