package com.csp595.utilities;

import java.util.HashMap;
import java.util.Map.Entry;

import com.csp595.beans.Product;

public class AjaxUtility {

	public static HashMap<String, Product> getProductHashMap(){
		HashMap<String, Product> productHashMap = MySqlUtil.getProductHashMap();
		return productHashMap;
	}
	
	/*
	 * Helper method to get search results. 
	 */
	public static StringBuffer readData(String searchValue){
		HashMap<String, Product> productHashMap = MySqlUtil.getProductHashMap();
		StringBuffer buffer = new StringBuffer();
		
		for (Entry<String, Product> productEntry: productHashMap.entrySet()){
			Product product = productEntry.getValue();
			if(product.getName().toLowerCase().startsWith(searchValue.toLowerCase())){
				buffer.append("<product>");
				buffer.append("<id>" + product.getId() + "</id>");
				buffer.append("<productName>" + product.getName() + "</productName>");
				buffer.append("</product>");
			}
		}
		return buffer;
	}
}
