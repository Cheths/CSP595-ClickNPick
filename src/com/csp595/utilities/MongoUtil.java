package com.csp595.utilities;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.csp595.beans.TrendingProduct;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
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
	
	
	
}
