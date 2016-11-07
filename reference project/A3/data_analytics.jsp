<!DOCTYPE html>
<%@page import="com.cheths.a1.main.ProductHelper"%>
<%@page import="com.cheths.a1.main.MongoDBDataStoreUtilities"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<html>
<body>
	<%
		Map<String, String> productIdNamesHashMap = ProductHelper.getProductNames();
		List<String> columnNamesList = MongoDBDataStoreUtilities.getColumnNames();
	%>
	<h3 style="color: blue">Data Analytics</h3>
	<div style="height: 700px; width: 990px;">
		<div>
			<form action="index.jsp" method="POST">
				<div style="display: inline-flex">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="productNameCB" />Select</span><input type="hidden"
						name="hdnDataAnalytics" value="true"><label
						for="productName" style="padding-right: 60px; width: 150px;">Product
						Name</label><select name="productName"><option value="0">All
							Products</option>
						<%
							for (Map.Entry<String, String> productIdName : productIdNamesHashMap.entrySet()) {
						%>
						<option value=<%=productIdName.getKey()%>><%=productIdName.getValue()%></option>
						<%
							}
						%>
					</select>
				</div>
				<div style="display: -webkit-box">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="ratingCB" />Select</span><label for="reviewRating"
						style="padding-right: 60px; width: 150px;">Review Rating</label> <select
						name="rating"><option value="0">0</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select> <span style="padding-left: 40px;"></span> <input type="radio"
						name="reviewRatingRadio" value="eq" />Equals <input type="radio"
						name="reviewRatingRadio" value="gt" />Greater Than
				</div>
				<div style="display: -webkit-box">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="categoryCB" />Select</span><label
						for="categoryLabel" style="padding-right: 60px; width: 150px;">Category</label><input
						type="text" name="pcategory" />
				</div>
				<div style="display: -webkit-box">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="retailerNameCB" />Select</span><label
						for="retailerNameLabel" style="padding-right: 60px; width: 150px;">Retailer
						Name</label><input type="text" name="retailerName" />
				</div>
				<div style="display: -webkit-box">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="zipCodeCB" />Select</span><label
						for="zipCodeLabel" style="padding-right: 60px; width: 150px;">Zip
						Code</label><input type="text" name="zipCode" />
				</div>
				<div style="display: -webkit-box">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="retailerCityCB" />Select</span><label
						for="retailerCityLabel" style="padding-right: 60px; width: 150px;">Retailer
						City</label><input type="text" name="retailerCity" />
				</div>
				<div style="display: -webkit-box">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="productPriceCB" />Select</span><label
						for="productPriceLabel" style="padding-right: 60px; width: 150px;">Product
						Price</label><input type="text" name="productPrice" /><span
						style="padding-left: 40px;"><input type="radio"
						name="productPriceRadio" value="eq" />Equals<input type="radio"
						name="productPriceRadio" value="gt" />Greater Than<input
						type="radio" name="productPriceRadio" value="lt" />Less Than </span>
				</div>
				<div style="display: -webkit-box">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="retailerStateCB" />Select</span><label
						for="retailerStateLabel"
						style="padding-right: 60px; width: 150px;">Retailer State</label><input
						type="text" name="retailerState" />
				</div>
				<div style="display: -webkit-box">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="mfgNameCB" />Select</span><label for="mfgName"
						style="padding-right: 60px; width: 150px;">Manufacturer
						Name</label><input type="text" name="mfgName" />
				</div>
				<div style="display: -webkit-box">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="mfgRebateCB" />Select</span><label
						for="mfgRebateLabel" style="padding-right: 60px; width: 150px;">Manufacturer
						Rebate</label><input type="text" name="mfgRebate" />
				</div>
				<div style="display: -webkit-box">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="usernameCB" />Select</span><label
						for="userNameLabel" style="padding-right: 60px; width: 150px;">User
						Name</label><input type="text" name="userName" />
				</div>
				<div style="display: -webkit-box">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="ageCB" />Select</span><label for="ageLabel"
						style="padding-right: 60px; width: 150px;">Age</label><input
						type="text" name="age" />
				</div>
				<div style="display: -webkit-box">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="occupationCB" />Select</span><label
						for="occupationLabel" style="padding-right: 60px; width: 150px;">Occupation</label><input
						type="text" name="occupation" />
				</div>
				<div style="display: -webkit-box">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="reviewCB" />Select</span><label for="reviewLabel"
						style="padding-right: 60px; width: 150px;">Reviews</label><input
						type="text" name="review" />
				</div>
				<div style="display: inline-flex">
					<span style="padding-left: 30px; padding-right: 150px;"><input
						type="checkbox" name="groupByCB" />Select</span><label for="groupBy"
						style="padding-right: 60px; width: 150px;">Group By</label><select
						name="groupBy"><option value="0">All Columns</option>
						<option value=_id>_id</option>
						<option value=productReviewId>productReviewId</option>
						<option value=productModelName>productModelName</option>
						<option value=category>category</option>
						<option value=retailerName>retailerName</option>
						<option value=mfgName>mfgName</option>
						<option value=productPrice>productPrice</option>
						<option value=mfgRebate>mfgRebate</option>
						<option value=zipCode>zipCode</option>
						<option value=city>city</option>
						<option value=state>state</option>
						<option value=userName>userName</option>
						<option value=userAge>userAge</option>
						<option value=userOccupation>userOccupation</option>
						<option value=rating>rating</option>
						<option value=reviewDate>reviewDate</option>
						<option value=comments>comments</option>
						<option value=productOnSale>productOnSale</option></select>
				</div>
				<div style="text-align: center; padding-top: 20px;">
					<button type="submit" value="Submit">Search</button>
				</div>
			</form>
			<hr class="soft" />
		</div>
	</div>
</body>
</html>