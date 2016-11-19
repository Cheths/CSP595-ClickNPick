package com.csp595.utilities;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.csp595.beans.ProductReview;
import com.csp595.beans.TrendingProduct;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;

public class MongoUtil {
	private static DBCollection productReview;
	
	public static void getConnection() throws Exception {
		MongoClient mongo;
		mongo = new MongoClient("localhost", 27017);
		DB db = mongo.getDB("clicknpick");
		productReview = db.getCollection("productReviews");
	}
	
	// Trending Products code - begin
	public static List<TrendingProduct> getTopFiveLikedProducts() {
		List<TrendingProduct> trendingProductList = new ArrayList<TrendingProduct>();
		try {
			getConnection();
			DBObject sort = new BasicDBObject();
			DBObject limit = new BasicDBObject();
			DBObject orderby = new BasicDBObject();
			sort.put("reviewRating", -1);
			orderby = new BasicDBObject("$sort", sort);
			limit = new BasicDBObject("$limit", 5);
			
			/*DBObject groupFields= new BasicDBObject();
			groupFields.put("_id", "$productName");
			groupFields.put("avgReviewRating", new BasicDBObject("$avg","$reviewRating"));
			DBObject group = new BasicDBObject("$group", groupFields);*/
			
			/*DBObject projectFields = new BasicDBObject();
			projectFields.put("productName", "$productName");
			projectFields.put("productId", "$productId");
			projectFields.put("avgReviewRating","$avgReviewRating");
			DBObject project = new BasicDBObject("$project", projectFields);*/
			
			AggregationOutput aggregate = productReview.aggregate(orderby, limit);
			for (DBObject obj : aggregate.results()) {
				TrendingProduct trendingProduct = new TrendingProduct();
				trendingProduct.setProductId(obj.get("productId").toString());
				trendingProduct.setProductName(obj.get("productId").toString());
				trendingProduct.setReviewRating(obj.get("reviewRating").toString());
				trendingProductList.add(trendingProduct);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return trendingProductList;
	}

	public static List<Map<String,String>> getMostReviewsInZipCode() {
		List<Map<String,String>> zipCodeReviewCountMapList = new ArrayList<Map<String,String>>();
		try {
			getConnection();
			DBObject groupFields= new BasicDBObject("_id", 0);
			groupFields.put("_id", "$retailerZip");
			groupFields.put("count",new BasicDBObject("$sum",1));
			DBObject group = new BasicDBObject("$group", groupFields);
			
			DBObject sort = new BasicDBObject();
			sort.put("ReviewValue",-1);
			
			DBObject projectFields = new BasicDBObject();
			projectFields.put("value", "$_id");
			projectFields.put("ReviewValue","$count");
			DBObject project = new BasicDBObject("$project", projectFields);
			
			DBObject orderby=new BasicDBObject("$sort",sort);
			DBObject limit=new BasicDBObject("$limit",5);
			AggregationOutput aggregate = productReview.aggregate(group,project,orderby,limit);
			for(DBObject obj : aggregate.results()){
				Map<String,String> zipCodeReviewCount = new HashMap<String, String>();
				zipCodeReviewCount.put(obj.get("value").toString(), obj.get("ReviewValue").toString());	
				zipCodeReviewCountMapList.add(zipCodeReviewCount);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return zipCodeReviewCountMapList;
	}

	public static List<Map<String,String>> getTopSoldProducts() {
		List<Map<String,String>> mostSoldProductList = new ArrayList<Map<String,String>>();
		try{
			DBObject groupFields= new BasicDBObject("_id", 0);
			groupFields.put("_id", "$productName");
			groupFields.put("count", new BasicDBObject("$sum", 1));
			DBObject group = new BasicDBObject("$group", groupFields);

			DBObject projectFields = new BasicDBObject();
			projectFields.put("value", "$_id");
			projectFields.put("ReviewValue","$count");
			DBObject project = new BasicDBObject("$project", projectFields);

			DBObject sort = new BasicDBObject();
			sort.put("ReviewValue",-1);
			DBObject orderby=new BasicDBObject("$sort",sort);

			DBObject limit=new BasicDBObject("$limit",5);
			AggregationOutput aggregate = productReview.aggregate(group,project,orderby,limit);
			for(DBObject obj : aggregate.results()){
				Map<String,String> mostSoldProductReviewAndCountMap = new HashMap<String, String>();
				mostSoldProductReviewAndCountMap.put(obj.get("value").toString(), obj.get("ReviewValue").toString());	
				mostSoldProductList.add(mostSoldProductReviewAndCountMap);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return mostSoldProductList;
	}
	// Trending Products code - end
	
	// Product Read Review and Write Review code - begin 
	public static ProductReview populateDbObjectToProductReview(BasicDBObject obj) {
		ProductReview productReview = new ProductReview();
		productReview.setManufacturerName(obj.getString("manufacturerName"));
		productReview.setManufacturerRebate(obj.getString("manufacturerRebate"));
		productReview.setProductCategory(obj.getString("productCategory"));
		productReview.setProductName(obj.getString("productName"));
		productReview.setProductId(obj.getString("productId"));
		productReview.setProductOnSale(obj.getString("productOnSale"));
		productReview.setProductPrice(obj.getString("productPrice"));
		productReview.setRetailerCity(obj.getString("retailerCity"));
		productReview.setRetailerName(obj.getString("retailerName"));
		productReview.setRetailerState(obj.getString("retailerState"));
		productReview.setRetailerZip(obj.getString("retailerZip"));
		productReview.setReviewRating(obj.getString("reviewRating"));
		productReview.setReviewDate(obj.getString("reviewDate"));
		productReview.setReviewText(obj.getString("reviewText"));
		productReview.setUserAge(obj.getString("userAge"));
		productReview.setUserId(obj.getString("userName"));
		productReview.setUserGender(obj.getString("userGender"));
		productReview.setUserOccupation(obj.getString("userOccupation"));
		return productReview;
	}

	public static List<ProductReview> getProductReviewListById(String productId) throws Exception {
		List<ProductReview> productReviewList = new ArrayList<>();
		Map<String, List<ProductReview>> productNameAndReviewMap = getAllProductNameAndReviewsMap();
		productReviewList = productNameAndReviewMap.get(productId);
		return productReviewList;
	}
	
	public static Map<String, List<ProductReview>> getAllProductNameAndReviewsMap() throws Exception {
		Map<String, List<ProductReview>> productNameAndReviewMap = new HashMap<String, List<ProductReview>>();
		getConnection();
		DBCursor cursor = productReview.find();
		while (cursor.hasNext()) {
			BasicDBObject obj = (BasicDBObject) cursor.next();
			if (!productNameAndReviewMap.containsKey(obj.getString("productId"))) {
				List<ProductReview> productReviewList = new ArrayList<ProductReview>();
				productNameAndReviewMap.put(obj.getString("productId"), productReviewList);
			}
			List<ProductReview> listReview = productNameAndReviewMap.get(obj.getString("productId"));
			listReview.add(populateDbObjectToProductReview(obj));
		}
		return productNameAndReviewMap;
	}
	
	public static void insertProductReview(String manufacturerName, String productCategory,
			String productName,String productId, String productPrice, String retailerCity,
			String retailerName, String retailerState, String retailerZip, String reviewRating, String reviewDate,
			String reviewText, String userAge, String userName, String userGender, String userOccupation)
			throws Exception {

		getConnection();
		BasicDBObject doc = new BasicDBObject("title", "productReviews").append("userName", userName)
				.append("manufacturerName", manufacturerName).append("productCategory", productCategory)
				.append("productName", productName).append("productId", productId)
				.append("productPrice", productPrice).append("retailerCity", retailerCity)
				.append("retailerName", retailerName).append("retailerState", retailerState)
				.append("retailerZip", retailerZip).append("reviewRating", reviewRating)
				.append("reviewDate", reviewDate).append("reviewText", reviewText).append("userAge", userAge)
				.append("userName", userName).append("userGender", userGender).append("userOccupation", userOccupation);
		productReview.insert(doc);
	}
	// Product Read Review and Write Review code - end 
	
}
