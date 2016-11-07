package com.cheths.a1.main;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import com.mongodb.MongoSocketOpenException;
import com.mongodb.MongoTimeoutException;
import com.mongodb.client.model.Aggregates;
import com.mongodb.operation.AggregateToCollectionOperation;

public class MongoDBDataStoreUtilities {

	static DBCollection productReviews;
	
	public static void getConnection() {
		try {
			MongoClient client = new MongoClient("localhost", 27017);
			@SuppressWarnings("deprecation")
			DB db = client.getDB("CustomerReviews");
			productReviews = db.getCollection("productReviews");
		} catch (MongoTimeoutException e) {
			System.out.println("Mongo server is not up and running");
		}
	}
	
	public static void storeProductReviews(Map<String, String> productReviewMap) {
		getConnection();
		String month = productReviewMap.get("month");
		String day = productReviewMap.get("day");
		String year = productReviewMap.get("year");
		String date = "";

		if (day != "" && year != "" && month != "") {
			date = month + "/" + day + "/" + year;
		}

		BasicDBObject basicDBObject = new BasicDBObject("productReviewId", productReviewMap.get("storeProductReview"));
		basicDBObject.put("productModelName", productReviewMap.get("productModelName"));
		basicDBObject.put("category", productReviewMap.get("category"));
		basicDBObject.put("retailerName", productReviewMap.get("retailerName"));
		basicDBObject.put("mfgName", productReviewMap.get("mfgName"));
		basicDBObject.put("productPrice", productReviewMap.get("productPrice"));
		basicDBObject.put("mfgRebate", productReviewMap.get("mfgRebate"));
		basicDBObject.put("zipCode", productReviewMap.get("zipCode"));
		basicDBObject.put("city", productReviewMap.get("city"));
		basicDBObject.put("state", productReviewMap.get("state"));
		basicDBObject.put("userName", productReviewMap.get("userName"));
		basicDBObject.put("userAge", productReviewMap.get("userAge"));
		basicDBObject.put("userOccupation", productReviewMap.get("userOccupation"));
		basicDBObject.put("rating", productReviewMap.get("rating"));
		basicDBObject.put("reviewDate", date);
		basicDBObject.put("comments", productReviewMap.get("comments"));
		basicDBObject.put("productOnSale", productReviewMap.get("productOnSale"));
		try {
			productReviews.insert(basicDBObject);
		} catch (MongoTimeoutException e) {
			System.out.println("Mongo Server isn't up and running!");
		}
	}
	
	public static Map<String, ArrayList<ProductReview>> getProductReviews(){
		getConnection();
		Map<String, ArrayList<ProductReview>> reviewMap = new HashMap<String, ArrayList<ProductReview>>();
		DBCursor cursor = productReviews.find();
		while (cursor.hasNext()) {
			BasicDBObject document = (BasicDBObject) cursor.next();
			document.get("productReviewId");
			ProductReview productReview = new ProductReview(document.getString("productReviewId"),
					document.getString("productModelName"), document.getString("category"),
					document.getString("retailerName"), document.getString("mfgName"),
					document.getString("productPrice"), document.getString("mfgRebate"), document.getString("zipCode"),
					document.getString("city"), document.getString("state"), document.getString("userName"),
					document.getString("userAge"), document.getString("userOccupation"), document.getString("rating"),
					document.getString("reviewDate"), document.getString("comments"),
					document.getString("productOnSale"));
			String productReviewId = document.getString("productReviewId");
			if (!reviewMap.containsKey(productReviewId)) {
				reviewMap.put(productReviewId, new ArrayList<ProductReview>());
			}
			ArrayList<ProductReview> reviewList = reviewMap.get(productReviewId);
			reviewList.add(productReview);
		}
		return reviewMap;
	}
	
	public static ArrayList<DBObject> getTopFiveProductBasedOnRatings() {
		getConnection();
		BasicDBObject queryObject = new BasicDBObject();
		
		DBObject sort = new BasicDBObject();
		DBObject orderBy = new BasicDBObject();
		sort.put("productId.rating",-1);
		orderBy.put("$sort", sort);
		
		DBObject limit=new BasicDBObject();
		limit.put("$limit", 5);
		
		DBObject groupFields = new BasicDBObject("_id", 0);
		Map<String, String> map = new HashMap<>();
		map.put("productReviewId", "$productReviewId");
		map.put("rating", "$rating");
		//map.put("productPrice", "$productPrice");
		groupFields.put("_id", map);
		groupFields.put("rating", new BasicDBObject("$sum","$rating"));
		
		DBObject projectFields = new BasicDBObject();
		projectFields.put("productId", "$_id");
		projectFields.put("rating", "$rating");
		
		DBObject project = new BasicDBObject("$project", projectFields);
		DBObject group = new BasicDBObject("$group", groupFields);
		
		AggregationOutput aggregate = productReviews.aggregate(group, project,orderBy,limit);
		return (ArrayList<DBObject>) aggregate.results();
	}
	
	public static ArrayList<DBObject> getTopFiveProductBasedOnZipCode(){
		getConnection();
		
		DBObject projectFields = new BasicDBObject();
		DBObject project = new BasicDBObject();
		DBObject sort = new BasicDBObject();
		
		DBObject limit = new BasicDBObject("$limit",5);
		DBObject groupFields = new BasicDBObject("_id", 0);
		DBObject group = new BasicDBObject("$group", groupFields);
		
		groupFields.put("count",new BasicDBObject("$sum",1));
		groupFields.put("_id", "$zipCode");
		
		sort.put("count",-1);
		DBObject orderby = new BasicDBObject("$sort",sort);
		
		projectFields.put("zipCode", "$_id");
		projectFields.put("count","$count");
		
		project = new BasicDBObject("$project", projectFields);
		sort.put("count",-1);
		AggregationOutput aggregate = productReviews.aggregate(group,project,orderby,limit);
		
		return (ArrayList<DBObject>) aggregate.results();
	}

	public static ArrayList<DBObject> getTopFiveSoldProducts() {
		getConnection();
		
		DBObject projectFields = new BasicDBObject();
		DBObject project = new BasicDBObject();
		DBObject sort = new BasicDBObject();
		
		DBObject limit = new BasicDBObject("$limit",5);
		DBObject groupFields = new BasicDBObject("_id", 0);
		DBObject group = new BasicDBObject("$group", groupFields);
		
		groupFields.put("count",new BasicDBObject("$sum",1));
		groupFields.put("_id", "$productReviewId");
		
		sort.put("count",-1);
		DBObject orderby = new BasicDBObject("$sort",sort);
		
		projectFields.put("productReviewId", "$_id");
		projectFields.put("count","$count");
		
		project = new BasicDBObject("$project", projectFields);
		sort.put("count",-1);
		AggregationOutput aggregate = productReviews.aggregate(group,project,orderby,limit);
		
		return (ArrayList<DBObject>) aggregate.results();
	}
	
	public static List<ProductReview> getSearchResultsBasedOnFormInput(HttpServletRequest request){
		Map<String, String> paramMap = new HashMap<String, String>();
		Enumeration<String> requestEnum = request.getParameterNames();
		while(requestEnum.hasMoreElements()){
			String parameter = requestEnum.nextElement();
			String value = request.getParameter(parameter);
			paramMap.put(parameter, value);
		}
		return filterResultsBasedOnParams(paramMap);
	}

	private static List<ProductReview> filterResultsBasedOnParams(Map<String, String> paramMap) {
		getConnection();
		
		DBObject groupFields = new BasicDBObject("_id", 0);
		DBObject group = new BasicDBObject("$group", groupFields);
		DBObject projectFields = new BasicDBObject();
		DBObject project = new BasicDBObject();
		DBObject sort = new BasicDBObject();
		BasicDBObject query = new BasicDBObject();
		Map<String, ArrayList<ProductReview>> reviewMap = new HashMap<String, ArrayList<ProductReview>>();
		List<ProductReview> reviewList = new ArrayList<ProductReview>();
		
		String productNameCB = paramMap.get("productNameCB");
		String productPriceCB = paramMap.get("productPriceCB");
		String ratingCB = paramMap.get("ratingCB");
		String retailerCityCB = paramMap.get("retailerCityCB");
		String categoryCB = paramMap.get("categoryCB");
		String retailerNameCB = paramMap.get("retailerNameCB");
		String zipCodeCB = paramMap.get("zipCodeCB");
		String retailerStateCB = paramMap.get("retailerStateCB");
		String mfgNameCB = paramMap.get("mfgNameCB");
		String mfgRebateCB = paramMap.get("mfgRebateCB");
		String usernameCB = paramMap.get("usernameCB");
		String ageCB = paramMap.get("ageCB");
		String occupationCB = paramMap.get("occupationCB");
		String reviewCB = paramMap.get("reviewCB");
		String groupByCB = paramMap.get("groupByCB");
		boolean isDefaultSearch = true;
		
		if(productNameCB != null){
			if(paramMap.get("productName") != null){
				query.put("productReviewId", paramMap.get("productName"));
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(productPriceCB != null){
			if(paramMap.get("productPrice") != null){
				String radioBtnValue = paramMap.get("productPriceRadio");
				String productPrice = paramMap.get("productPrice");
				if(radioBtnValue.equals("gt")) {
					query.put("productPrice", new BasicDBObject("$gt", productPrice));
				} else if(radioBtnValue.equals("lt")) {
					query.put("productPrice", new BasicDBObject("$lt", productPrice));
				} else {
					query.put("productPrice", new BasicDBObject("$eq", productPrice));
				}
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(ratingCB != null){
			if(paramMap.get("productPrice") != null){
				String radioBtnValue = paramMap.get("reviewRatingRadio");
				String rating = paramMap.get("rating");
				if(radioBtnValue.equals("gt")) {
					query.put("rating", new BasicDBObject("$gt", rating));
				} else if(radioBtnValue.equals("lt")) {
					query.put("rating", new BasicDBObject("$lt", rating));
				} else {
					query.put("rating", new BasicDBObject("$eq", rating));
				}
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(retailerCityCB != null){
			if(paramMap.get("retailerCity") != null){
				query.put("city", paramMap.get("retailerCity"));
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(categoryCB != null){
			if(paramMap.get("category") != null){
				query.put("category", paramMap.get("category"));
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(retailerNameCB != null){
			if(paramMap.get("retailerName") != null){
				query.put("retailerName", paramMap.get("retailerName"));
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(zipCodeCB != null){
			if(paramMap.get("zipCode") != null){
				query.put("zipCode", paramMap.get("zipCode"));
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(retailerStateCB != null){
			if(paramMap.get("retailerState") != null){
				query.put("state", paramMap.get("retailerState"));
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(mfgNameCB != null){
			if(paramMap.get("mfgName") != null){
				query.put("mfgName", paramMap.get("mfgName"));
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(mfgRebateCB != null){
			if(paramMap.get("mfgRebate") != null){
				query.put("mfgRebate", paramMap.get("mfgRebate"));
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(usernameCB != null){
			if(paramMap.get("userName") != null){
				query.put("userName", paramMap.get("userName"));
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(ageCB != null){
			if(paramMap.get("age") != null){
				query.put("userAge", paramMap.get("age"));
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(occupationCB != null){
			if(paramMap.get("occupation") != null){
				query.put("userOccupation", paramMap.get("occupation"));
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(reviewCB != null){
			if(paramMap.get("review") != null){
				query.put("comments", paramMap.get("review"));
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(occupationCB != null){
			if(paramMap.get("occupation") != null){
				query.put("userOccupation", paramMap.get("occupation"));
				isDefaultSearch = false;
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if(groupByCB != null){
			if(paramMap.get("groupBy") != null){
				//query.put("userOccupation", paramMap.get("groupBy"));
			}
			updateReviewMapForNewResults(query, reviewList);
		}
		if (isDefaultSearch){
			updateReviewMapForNewResults(null, reviewList);
		}
		
		return reviewList;
	}

	private static void updateReviewMapForNewResults(BasicDBObject query, List<ProductReview> reviewList) {
		DBCursor cursor;
		if (query != null) {
			cursor= productReviews.find(query);
		} else {
			cursor= productReviews.find();
		}
		while (cursor.hasNext()) {
			BasicDBObject document = (BasicDBObject) cursor.next();
			document.get("productReviewId");
			ProductReview productReview = new ProductReview(document.getString("productReviewId"),
					document.getString("productModelName"), document.getString("category"),
					document.getString("retailerName"), document.getString("mfgName"),
					document.getString("productPrice"), document.getString("mfgRebate"), document.getString("zipCode"),
					document.getString("city"), document.getString("state"), document.getString("userName"),
					document.getString("userAge"), document.getString("userOccupation"), document.getString("rating"),
					document.getString("reviewDate"), document.getString("comments"),
					document.getString("productOnSale"));
			String productReviewId = document.getString("productReviewId");
			reviewList.add(productReview);
		}
	}
	
	public static List<String> getColumnNames() {
		getConnection();
		DBCursor cursor = productReviews.find();
		List<String> columnNamesList = new ArrayList<String>();
		for (String key : cursor.next().keySet()) {
			columnNamesList.add(key);
		}
		return columnNamesList;
	}
}
