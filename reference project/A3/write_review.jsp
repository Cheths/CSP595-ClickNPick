<!DOCTYPE html>
<%@page import="com.cheths.a1.main.ProductHelper"%>
<%@page import="com.cheths.a1.main.Product"%>
<html>
<body>
<%
//String productReviewId = request.getParameter("productReviewId");
Product product = ProductHelper.getProductById(productReviewId);
//String userName = (String) session.getAttribute("userName");
%>
	<div class="span9 content">
		<br class="clr">
		<div class="tab-content" style="height: 700px; width: 990px;">
			<div class="tab-pane  active" id="blockView">
				<ul class="thumbnails">
					<div class="span9">
						<ul class="breadcrumb">
							<li><a href="index.html">Home</a> <span class="divider">/</span>
							</li>
							<li class="active">Product Review Form</li>
						</ul>
						<h3>Product Review Form</h3>
						<div class="well">
							<form class="form-horizontal" name="productReviewForm" action="index.jsp" method="POST">
								<h4>Product Info</h4>
								<div class="control-group">
									<label class="control-label" for="productModelName">Model
										Name <sup>*</sup>
									</label>
									<div class="controls">
										<input type="text" id="productModelName"
											name="productModelName" value=<%=product.getName() %>
											placeholder="Enter Product Name" readonly> <input
											type="text" name="storeProductReview" value=<%=product.getId() %>
											style="display: none;">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Category <sup>*</sup>
									</label>
									<div class="controls">
										<input type="text" value=<%=product.getCategory() %> name="pCategory"
											style="width: 130px;">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="productPrice">Price<sup>*</sup>
									</label>
									<div class="controls">
										<input type="text" id="productPrice" value=<%=product.getPrice() %>
											name="productPrice" readonly>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="company">Retailer
										Name</label>
									<div class="controls">
										<input type="text" id="retailerName" value=<%=product.getRetailer() %>
											name="retailerName" readonly>
									</div>
								</div>
								<h4>Retailer Information</h4>
								<div class="control-group">
									<label class="control-label" for="zipCode">Zip code<sup>*</sup>
									</label>
									<div class="controls">
										<input type="text" id="zipCode" name="zipCode" required>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="city">City<sup>*</sup>
									</label>
									<div class="controls">
										<input type="text" id="city" name="city" required>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="state">State<sup>*</sup>
									</label>
									<div class="controls">
										<select id="state" name="state" required>
											<option value="">-</option>
											<option value="1">Alabama</option>
											<option value="2">Alaska</option>
											<option value="3">Arizona</option>
											<option value="4">Arkansas</option>
											<option value="5">California</option>
											<option value="6">Colorado</option>
											<option value="7">Connecticut</option>
											<option value="8">Delaware</option>
											<option value="53">District of Columbia</option>
											<option value="9">Florida</option>
											<option value="10">Georgia</option>
											<option value="11">Hawaii</option>
											<option value="12">Idaho</option>
											<option value="13">Illinois</option>
											<option value="14">Indiana</option>
											<option value="15">Iowa</option>
											<option value="16">Kansas</option>
											<option value="17">Kentucky</option>
											<option value="18">Louisiana</option>
											<option value="19">Maine</option>
											<option value="20">Maryland</option>
											<option value="21">Massachusetts</option>
											<option value="22">Michigan</option>
											<option value="23">Minnesota</option>
											<option value="24">Mississippi</option>
											<option value="25">Missouri</option>
											<option value="26">Montana</option>
											<option value="27">Nebraska</option>
											<option value="28">Nevada</option>
											<option value="29">New Hampshire</option>
											<option value="30">New Jersey</option>
											<option value="31">New Mexico</option>
											<option value="32">New York</option>
											<option value="33">North Carolina</option>
											<option value="34">North Dakota</option>
											<option value="35">Ohio</option>
											<option value="36">Oklahoma</option>
											<option value="37">Oregon</option>
											<option value="38">Pennsylvania</option>
											<option value="51">Puerto Rico</option>
											<option value="39">Rhode Island</option>
											<option value="40">South Carolina</option>
											<option value="41">South Dakota</option>
											<option value="42">Tennessee</option>
											<option value="43">Texas</option>
											<option value="52">US Virgin Islands</option>
											<option value="44">Utah</option>
											<option value="45">Vermont</option>
											<option value="46">Virginia</option>
											<option value="47">Washington</option>
											<option value="48">West Virginia</option>
											<option value="49">Wisconsin</option>
											<option value="50">Wyoming</option>
										</select>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Product On Sale </label>
									<div class="controls">
										<select class="span1" name="productOnSale">
											<option value="">Yes</option>
											<option value="1">No</option>
										</select>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="country">Manufacturer
										Name</label>
									<div class="controls">
										<input type="text" id="mfgName" name="mfgName">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="mfgRebate">Manufacturer
										Rebate<sup>*</sup>
									</label>
									<div class="controls">
										<input type="text" id="mfgRebate" value=<%=product.getDiscount() %> name="mfgRebate"
											readonly>
									</div>
								</div>
								<h4>User Info</h4>
								<div class="control-group">
									<label class="control-label" for="phone">Name<sup>*</sup>
									</label>
									<div class="controls">
										<input type="text" value=<%=userName %> name="userName" readonly>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="phone">Age<sup>*</sup>
									</label>
									<div class="controls">
										<input type="number" name="userAge" id="userAge">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Gender </label>
									<div class="controls">
										<select class="span1" name="gender">
											<option value="">Male</option>
											<option value="1">Female</option>
										</select>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="phone">Occupation</label>
									<div class="controls">
										<input type="text" name="userOccupation" id="userOccupation">
									</div>
								</div>
								<h4>Review Info</h4>
								<div class="control-group">
									<label class="control-label">Rating </label>
									<div class="controls">
										<select class="span1" name="rating" required>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
										</select>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Date<sup>*</sup>
									</label>
									<div class="controls">
										<select class="span1" name="month">
											<option value="">-</option>
											<option value="1">1&nbsp;&nbsp;</option>
											<option value="2">2&nbsp;&nbsp;</option>
											<option value="3">3&nbsp;&nbsp;</option>
											<option value="4">4&nbsp;&nbsp;</option>
											<option value="5">5&nbsp;&nbsp;</option>
											<option value="6">6&nbsp;&nbsp;</option>
											<option value="7">7&nbsp;&nbsp;</option>
											<option value="8">8&nbsp;&nbsp;</option>
											<option value="9">9&nbsp;&nbsp;</option>
											<option value="10">10&nbsp;&nbsp;</option>
											<option value="11">11&nbsp;&nbsp;</option>
											<option value="12">12&nbsp;&nbsp;</option>
										</select> <select class="span1" name="day">
											<option value="">-</option>
											<option value="1">1&nbsp;&nbsp;</option>
											<option value="2">2&nbsp;&nbsp;</option>
											<option value="3">3&nbsp;&nbsp;</option>
											<option value="4">4&nbsp;&nbsp;</option>
											<option value="5">5&nbsp;&nbsp;</option>
											<option value="6">6&nbsp;&nbsp;</option>
											<option value="7">7&nbsp;&nbsp;</option>
											<option value="1">8&nbsp;&nbsp;</option>
											<option value="2">9&nbsp;&nbsp;</option>
											<option value="3">10&nbsp;&nbsp;</option>
											<option value="4">11&nbsp;&nbsp;</option>
											<option value="5">12&nbsp;&nbsp;</option>
											<option value="6">13&nbsp;&nbsp;&nbsp;</option>
											<option value="7">14&nbsp;&nbsp;</option>
											<option value="1">15&nbsp;&nbsp;</option>
											<option value="2">16&nbsp;&nbsp;</option>
											<option value="3">17&nbsp;&nbsp;</option>
											<option value="4">18&nbsp;&nbsp;</option>
											<option value="5">19&nbsp;&nbsp;</option>
											<option value="6">20&nbsp;&nbsp;</option>
											<option value="7">21&nbsp;&nbsp;</option>
											<option value="1">22&nbsp;&nbsp;</option>
											<option value="2">23&nbsp;&nbsp;</option>
											<option value="3">24&nbsp;&nbsp;</option>
											<option value="4">25&nbsp;&nbsp;</option>
											<option value="5">26&nbsp;&nbsp;</option>
											<option value="6">27&nbsp;&nbsp;</option>
											<option value="7">28&nbsp;&nbsp;</option>
											<option value="5">29&nbsp;&nbsp;</option>
											<option value="6">30&nbsp;&nbsp;</option>
											<option value="7">31&nbsp;&nbsp;</option>
										</select> <select class="span1" name="year">
											<option value="">-</option>
											<option value="1">2015&nbsp;&nbsp;</option>
											<option value="2">2016&nbsp;&nbsp;</option>
										</select>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="comments">Comments</label>
									<div class="controls">
										<textarea name="comments" id="comments" cols="26" rows="3"
											placeholder="Enter Review here" required ></textarea>
									</div>
								</div>
								<p>
									<sup>*</sup>Required field
								</p>
								<div class="control-group">
									<div class="controls">
										<input class="btn btn-large btn-success" type="submit"
											value="Submit" />
									</div>
								</div>
								<div class="controls">
									<input class="btn btn-large btn-success" type="submit"
										value="Back"></input>
								</div>
							</form>
						</div>
					</div>
				</ul>
				<hr class="soft">
			</div>
		</div>
	</div>

</body>
</html>