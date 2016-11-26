<!DOCTYPE html">
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="com.csp595.utilities.MySqlUtil"%>
<%@page import="com.csp595.beans.Coupon"%>
<html>
<body>
	<%@include file="header.jsp"%>
	<%@include file="sidebar.jsp"%>

	<div class="row">
		<div class="span9">
			<%
				ArrayList<String> userList = MySqlUtil.getUserList();
				String addCoupons = request.getParameter("addCoupons");
				String viewCoupons = request.getParameter("viewCoupons");
				Boolean isCouponAdded = (Boolean) request.getAttribute("addCouponSuccess");
				if (isCouponAdded != null) {
					if (isCouponAdded) {
			%>
			<div class="alert" style="background-color: #5bb75b;">
				<span class="closebtn"
					onclick="this.parentElement.style.display='none';">&times;</span> <strong>Success!</strong>
				Coupon Added Successfully
			</div>
			<%
				}
				}
			%>
			<br />
			<div style="padding-bottom: 20px;">
				<a href="admin_operations.jsp?addCoupons=true" class="btn btn-large">Add
					Coupon</a> <a href="admin_operations.jsp?viewCoupons=true"
					class="btn btn-large">View Coupons</a>
			</div>
			<%
				if (addCoupons != null) {
			%>
			<div class="well">
				<form action="UtilityServlet" class="form-horizontal">
					<h4>Coupon Details</h4>
					<div class="control-group">
						<label class="control-label" for="couponCode">Coupon Code
							<sup>*</sup>
						</label>
						<div class="controls">
							<input type="text" name="couponCode" id="couponCode"
								placeholder="COUPON CODE" required="required" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="discount">Discount (%) <sup>*</sup></label>
						<div class="controls">
							<input type="number" name="discount" id="discount"
								required="required" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="userBase">User Name <sup>*</sup></label>
						<div class="controls">
							<select name="userBase" class="srchTxt">
								<option value="All">All</option>
								<% for(String username: userList){ 
									String name = username;
								%>
								<option value=<%=name %>><%=name %></option>
								<%} %>
							</select>
						</div>
					</div>


					<div class="control-group">
						<div class="controls">
							<input class="btn btn-large btn-success" type="submit"
								value="Submit" />
						</div>
					</div>
				</form>
			</div>
			<%
				} else if (viewCoupons != null) {
					Map<String, Coupon> couponHashMap = MySqlUtil.getCouponHashMap();
			%>
			<div class="span9">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Coupon Code</th>
							<th>Discount</th>
							<th>User Name</th>
						</tr>
					</thead>
					<%
						for (Entry<String, Coupon> couponEntry : couponHashMap.entrySet()) {
								Coupon coupon = couponEntry.getValue();
								if (coupon != null) {
					%>
					<tbody>
						<tr>
							<td><%=coupon.getCouponCode()%></td>
							<td><%=coupon.getDiscount()%></td>
							<td><%=coupon.getUserName()%></td>
						</tr>
					</tbody>
					<%
						}
							}
							if (couponHashMap.isEmpty()) {
					%>
					<tbody>
						<tr>
							<td colspan="3">NO COUPONS FOUND</td>
						</tr>
					</tbody>
					<%
						}
					%>
				</table>
			</div>
			<%
				} else {
			%>
			<div style="padding-bottom: 250px;"></div>
			<%
				}
			%>
			<a href="index.jsp" class="btn btn-large pull-left">Back <i
				class="icon-arrow-left"></i></a>
		</div>
	</div>

	<%@include file="footer.jsp"%>
</body>
</html>