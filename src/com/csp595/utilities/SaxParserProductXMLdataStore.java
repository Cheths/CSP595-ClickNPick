package com.csp595.utilities;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import com.csp595.beans.Product;

public class SaxParserProductXMLdataStore extends DefaultHandler {

	private Product product;
	private static List<Product> productList = new ArrayList<Product>();
	private String elementValueRead;
	private static Map<String, Product> productHashMap = new HashMap<String, Product>();

	public Product getProduct() {
		return product;
	}

	public static Map<String, Product> getProductHashMap(){
		return productHashMap;
	}
	
	public static List<Product> getProductList() {
		return productList;
	}

	public SaxParserProductXMLdataStore(String xmlFileName, HttpServletRequest request, HttpSession session) throws SQLException {
		if(productHashMap.isEmpty()){
			ParseDocument(xmlFileName);
			MySqlUtil.insertRecordstoProductTable();
			productHashMap = MySqlUtil.getAllProductMap(request);
		}
	}
	
	/*public SaxParserProductXMLdataStore(String xmlFileName) throws SQLException {
		if(productHashMap.isEmpty()){
			ParseDocument(xmlFileName);
			MySqlUtil.insertRecordstoProductTable();
			//productHashMap = MySqlUtil.getAllProductMap(request);
		}
	}*/

	public static Product getProductByID(String productID) {
		Product product = new Product();
		Map<String, Product> tempProductIdProductMap = SaxParserProductXMLdataStore.getProductHashMap();
		for (Entry<String, Product> entry : tempProductIdProductMap.entrySet()) {
			if (entry.getValue().getId().equals(productID)) {
				return entry.getValue();
			}
		}
		return product;
	}

	
	private void ParseDocument(String xmlFileName) {
		SAXParserFactory factory = SAXParserFactory.newInstance();
		try {
			SAXParser parser = factory.newSAXParser();
			parser.parse(xmlFileName, this);
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException io) {
			io.printStackTrace();
		}

	}

	@Override
	public void startElement(String str1, String str2, String elementName, Attributes attributes) throws SAXException {

		if (elementName.equalsIgnoreCase("product")) {
			product = new Product();
			product.setId(attributes.getValue("id"));
		}

	}

	@Override
	public void endElement(String str1, String str2, String element) throws SAXException {

		if (element.equals("product")) {
			productList.add(product);
			productHashMap.put(product.getId(), product);
			return;
		}
		if (element.equalsIgnoreCase("category")) {
			product.setCategory(elementValueRead);
			return;
		}
		if (element.equalsIgnoreCase("condition")) {
			product.setCondition(elementValueRead);
			return;
		}
		if (element.equalsIgnoreCase("discount")) {
			product.setDiscount(Double.parseDouble(elementValueRead));
			return;
		}
		if (element.equalsIgnoreCase("name")) {
			product.setName(elementValueRead);
			return;
		}
		if (element.equalsIgnoreCase("image")) {
			product.setImage(elementValueRead);
			return;
		}
		if (element.equalsIgnoreCase("price")) {
			product.setPrice(Double.parseDouble(elementValueRead));
			return;
		}
		if (element.equalsIgnoreCase("description")) {
			product.setDescription(elementValueRead);
			return;
		}
		if (element.equalsIgnoreCase("type")) {
			product.setType(elementValueRead);
			return;
		}
		if (element.equalsIgnoreCase("manufacturer")) {
			product.setManufacturer(elementValueRead);
			return;
		}
		if (element.equalsIgnoreCase("gender")) {
			product.setGender(elementValueRead);
			return;
		}
	}
	
    @Override
    public void characters(char[] content, int begin, int end) throws SAXException {
        elementValueRead = new String(content, begin, end);
    }
    
	public static Product getProductByName(String productName) {
		Product product = new Product();
		Map<String, Product> tempProductIdProductMap = SaxParserProductXMLdataStore.getProductHashMap();
		for (Entry<String, Product> entry : tempProductIdProductMap.entrySet()) {
			if (entry.getValue().getName().equals(productName)) {
				return entry.getValue();
			}
		}
		return product;
	}
}
