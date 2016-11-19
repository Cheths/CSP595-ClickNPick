<%@page import="com.csp595.utilities.MongoUtil"%>
<%@page import="com.mongodb.Mongo"%>
<%@page import="com.csp595.beans.ProductReview"%>
<%@page import="java.util.List"%>
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
						String selectedProductId = (String) request.getParameter("readProductReview");
						Product product = SaxParserProductXMLdataStore.getProductByID(selectedProductId);
						List<ProductReview> productReviewsList = MongoUtil.getProductReviewListById(product.getId());
						if (productReviewsList != null && !productReviewsList.isEmpty()) {
					%>
					<h3>
						Reviews for
						<%=product.getName()%>
					</h3>
					<form action="index.jsp" method="POST">
						<%
							for (ProductReview productReview : productReviewsList) {
						%>

						<table class="form-tbl" cellspacing="0">
							<tbody>
								<tr>
									<th><label for="{#review.form.fields.userId.id}">User
											ID<em>*</em>
									</label></th>
									<td><input readonly name="userId"
										value="<%=productReview.getUserId()%>" id="userId"
										class="form-control" type="text"></input></td>
								</tr>

								<tr>
									<th><label for="{#review.form.fields.reviewRating.id}">User
											Rating<em>*</em>
									</label></th>
									<td><input readonly name="reviewRating"
										value="<%=productReview.getReviewRating()%>" id="reviewRating"
										class="form-control" type="text"></input></td>
								</tr>

								<tr>
									<th><label for="{#review.form.fields.reviewDate.id}">Review
											Date<em>*</em>
									</label></th>
									<td><input readonly name="reviewDate"
										value="<%=productReview.getReviewDate()%>" id="reviewDate"
										class="form-control" type="text"></input></td>
								</tr>

								<tr>
									<th><label for="{#review.form.fields.reviewText.id}">Review<em>*</em></label></th>
									<td><input readonly name="reviewText"
										value="<%=productReview.getReviewText()%>" id="reviewText"
										class="form-control" type="text"></input></td>
								</tr>

							</tbody>
						</table>
						&nbsp;
					</form>
					<%
						}
					%>

					<%
						} else {
					%>
					<h3>
						No Reviews found for
						<%=product.getName()%></h3>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@include file="footer.jsp"%>