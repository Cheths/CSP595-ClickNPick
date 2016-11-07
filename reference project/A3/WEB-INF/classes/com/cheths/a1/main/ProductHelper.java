package com.cheths.a1.main;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class ProductHelper {
	private static String orderedDate = "";

	public static Product getProductById(String productId) {
		if (productId != null) {
			List<Product> productList = MySQLDataStoreUtilities.loadAllProducts();
			for (Product product : productList) {
				if (product.getId().equals(productId)) {
					return product;
				}
			}
		}
		return null;
	}
	
	public static Map<String, String> getProductNames(){
		Map<String, String> productIdNamesHashMap = new HashMap<String, String>();
		List<Product> productList = MySQLDataStoreUtilities.loadAllProducts();
		for(Product product: productList){
			productIdNamesHashMap.put(product.getId(), product.getName());
		}
		return productIdNamesHashMap;
	}
	
	public static String getUpdatedShoppingIdsinCsvFormat(String[] updatedShoppingIds) {
		String commaSeperatedId = "";
		if (updatedShoppingIds.length > 0) {
			for (int i = 0; i < updatedShoppingIds.length; i++) {
				if(!(updatedShoppingIds[i].equals("")) && !(updatedShoppingIds[i].equals(null)))	{
					commaSeperatedId = commaSeperatedId + "," + updatedShoppingIds[i];
				}
			}
			if (commaSeperatedId.startsWith("\"\",")) {
				commaSeperatedId = commaSeperatedId.substring(3);
			}
		}
		return commaSeperatedId;
	}
	
	public static int getMyCartCount(String updatedShoppingIds){
		int count = 0;
		if(updatedShoppingIds != null){
			String[] commaSeperatedProductIds = updatedShoppingIds.split(",");
			for (int i = 0; i < commaSeperatedProductIds.length; i++) {
				Product product = getProductById(commaSeperatedProductIds[i]);
				if (product != null) {
					count += 1;
				}
			}
		}
		return count;
	}
	
	public static Double calculatePriceForProduct(Product product) {
		Double tax = 15.00;
		Double totalPrice = product.getPrice() - product.getDiscount() + tax;
		return totalPrice;
	}
	
	public static String generateOrderId(){
		String orderId = "";
		try {
			orderId = generateProductOrderId(Calendar.getInstance().getTime());
			//session.setAttribute("orderId", orderId);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return orderId;
	}
	
	public static String getOrderedDate() {
		//String orderedDate = "";
		DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
		Date date = new Date();
		Timestamp timestamp = new Timestamp(date.getTime());
		orderedDate = dateFormat.format(date);
		return timestamp.toString();
		//return orderedDate;
	}

	public static String getExpectedDeliveryDate() {
		String expectedDeliveryDate = "";
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
		Date date = null;
		try {
			if(orderedDate != ""){
				date = (Date) sdf.parse(orderedDate);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Calendar c1 = Calendar.getInstance();
		
		c1.setTime(date);
		c1.add(Calendar.DATE, 10);
		Timestamp timestamp = new Timestamp(c1.getTimeInMillis());
		expectedDeliveryDate = sdf.format(c1.getTime());

		return timestamp.toString();
	}
	
	public static String generateProductOrderId(Date orderDate) throws NoSuchAlgorithmException {
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        String datestring = df.format(orderDate).toString();
        String hash = generateHashValue(datestring);//creates SHA1 hash of 16 digits
        int datestringlen = datestring.length();
        String ordernum = datestring+hash.substring(datestringlen,datestringlen+5);
        return ordernum;
    }

    private static String generateHashValue(String plain) throws NoSuchAlgorithmException {
        final int MD_PASSWORD_LENGTH = 16;
        final String HASH_ALGORITHM = "SHA1";
        String hash = null;
         try {
                MessageDigest md = MessageDigest.getInstance(HASH_ALGORITHM);
                md.update(plain.getBytes());
                BigInteger hashint = new BigInteger(1, md.digest());
                hash = hashint.toString(MD_PASSWORD_LENGTH);
            } catch (NoSuchAlgorithmException nsae) {
                throw(nsae);
            }
        return hash;
    }
    
    public static void placeOrder(HttpSession session) {
		String shoppingItemId = (String) session.getAttribute("shoppingItemId");
		if (shoppingItemId != null) {
			insertOrdersToDb(session);
		}
	}
    
    public static void writeCustomerOrdersToFile(String shoppingItemIds, HttpSession session, HttpServletRequest request){
    	insertOrdersToDb(session);
    	//CustomerOrderSerializedDataStore.writeCustomerOrders(request, customerOrdersHashMap);
    }

	private static void insertOrdersToDb(HttpSession session) {
		
		String checkOutAmount = (String) session.getAttribute("checkOutAmount").toString();
		String shoppingItemIds = (String) session.getAttribute("shoppingItemId");
		String orderId =(String)session.getAttribute("orderId");
		String userName = (String) session.getAttribute("userName");
		String orderedDate = (String) session.getAttribute("orderedDate");
		String expectedDeliveredDate = (String) session.getAttribute("expectedDeliveredDate");
		
		MySQLDataStoreUtilities.insertQueryForOrderTable(orderId, userName, shoppingItemIds, orderedDate, expectedDeliveredDate, checkOutAmount, "", session);
	}
	
	public static String getProductNames(String productIds) {
		String[] productIdArray = productIds.split(",");
		Product product;
		String productNames = "";
		for(int i = 0; i < productIdArray.length; i++){
			product = getProductById(productIdArray[i]);
			productNames = ","+product.getName();
		}
		if(productNames.length() > 1){
			productNames = productNames.substring(1);
		}
		return productNames;
	}
	
	public static List<Map<String,Map<String,String>>> readCustomerOrders(HttpServletRequest request){
		//return CustomerOrderSerializedDataStore.readCustomerOrders(request);
		return null;
	}
}
