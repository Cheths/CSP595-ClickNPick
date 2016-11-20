<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp"%>
<%@include file="sidebar.jsp"%>
<html>
<body>
	<div id="mainBody">
		<div class="container">
			<div class="row">
				<div class="span9">
					<%
						String selectedProductId = (String) request.getParameter("showReviewSection");
						Product product = SaxParserProductXMLdataStore.getProductByID(selectedProductId);
						if ((String) session.getAttribute("userName") != null) {
					%>
					<h3>Please Enter Review</h3>
					<form action="UtilityServlet" method="POST">
						<table>
							<tbody>
								<tr>
									<th><label class="write-review-label" for="{#review.form.fields.productName.id}">Product
											Model Name <em>*</em>
									</label></th>
									<td><input readonly name="productName"
										value="<%=product.getName()%>" id="productName"
										class="form-control" type="text" maxlength="255"></input></td>
								</tr>

								<tr hidden="hidden"><th>
								<label class="write-review-label" for="{#review.form.fields.productId.id}">Product
									Id<em>*</em>
								</label></th>
								<td hidden><input name="productId"
									value="<%=product.getId()%>" id="productId"
									class="form-control" type="text" maxlength="255"></input></td>
								</tr>

								<tr>
									<th><label class="write-review-label" for="{#review.form.fields.productCategory.id}">Product
											Category <em>*</em>
									</label></th>
									<td><input readonly name="productCategory"
										value="<%=product.getCategory()%>" id="productCategory"
										class="form-control" type="text"></input></td>
								</tr>

								<tr>
									<th><label class="write-review-label" for="{#review.form.fields.productPrice.id}">Product
											Price <em>*</em>
									</label></th>
									<td><input readonly name="productPrice"
										value="<%=product.getPrice()%>" id="productPrice"
										class="form-control" type="text" maxlength="255"></input></td>
								</tr>

								<tr>
									<th><label class="write-review-label" for="{#review.form.fields.retailerZip.id}">Retailer
											Zip<em>*</em>
									</label></th>
									<td><input name="retailerZip" required="required"
										id="retailerZip" class="form-control" type="text"
										maxlength="255"></input></td>
								</tr>

								<tr>
									<th><label class="write-review-label" for="{#review.form.fields.retailerCity.id}">Retailer
											City<em>*</em>
									</label></th>
									<td><input name="retailerCity" required="required"
										id="retailerCity" class="form-control" type="text"
										maxlength="255"></input></td>
								</tr>

								<tr>
									<th><label for="{#review.form.fields.retailerState.id}">Retailer
											State<em>*</em>
									</label></th>
									<td><input name="retailerState" required="required"
										id="retailerState" class="form-control" type="text"
										maxlength="255"></input></td>
								</tr>

								<tr>
									<th><label class="write-review-label" for="{#review.form.fields.manufacturerName.id}">Manufacturer
											Name<em>*</em>
									</label></th>
									<td><input name="manufacturerName" required="required"
										id="manufacturerName" class="form-control" type="text"
										maxlength="255"></input></td>
								</tr>

								<tr>
									<th><label class="write-review-label" for="{#review.form.fields.userId.id}">User
											ID<em>*</em>
									</label></th>
									<td><input readonly name="userId" id="userId"
										value="<%=(String) session.getAttribute("userName")%>"
										required="required" class="form-control" type="text"
										maxlength="255"></input></td>
								</tr>

								<tr>
									<th><label class="write-review-label" for="{#review.form.fields.userAge.id}">User
											Age<em>*</em>
									</label></th>
									<td><input name="userAge" required="required" id="userAge"
										class="form-control" type="text" maxlength="255"></input></td>
								</tr>

								<tr>
									<th><label class="write-review-label" for="{#review.form.fields.userGender.id}">UserGender<em>*</em></label></th>
									<td><select name="userGender" id="userGender">
											<option value="Male">Male</option>
											<option value="Female">Female</option>
											<option value="Other">Other</option>
									</select></td>
								</tr>

								<tr>
									<th><label class="write-review-label" for="{#review.form.fields.userOccupation.id}">User
											Occupation<em>*</em>
									</label></th>
									<td><input name="userOccupation" required="required"
										id="userOccupation" class="form-control" type="text"
										maxlength="255"></input></td>
								</tr>

								<tr>
									<th><label class="write-review-label" for="{#review.form.fields.reviewRating.id}">Review
											Rating<em>*</em>
									</label></th>
									<td><select name="reviewRating" id="reviewRating">
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
									</select></td>
								</tr>

								<tr>
									<th><label class="write-review-label" for="{#review.form.fields.reviewDate.id}">Review
											Date<em>*</em>
									</label></th>
									<td><input name="reviewDate" required="required"
										id="reviewDate" class="form-control" type="text"
										maxlength="255"></input></td>
								</tr>

								<tr>
									<th><label class="write-review-label" for="{#review.form.fields.reviewText.id}">Review
											Text:<em>*</em>
									</label></th>
									<td><input name="reviewText" required="required"
										id="reviewText" class="form-control" type="text"
										maxlength="255"></input></td>
								</tr>
								<tr>
									<td class="noborder">
									<input class="btn btn-primary" type="submit" class="checkout"
										id="submit" value="Submit Review" /></td>
								</tr>
							</tbody>
						</table>
						<input type="hidden" name="writeReview" value="true">
					</form>

					<%
						}else{
							response.sendRedirect("login.jsp");
						}
					%>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@include file="footer.jsp"%>