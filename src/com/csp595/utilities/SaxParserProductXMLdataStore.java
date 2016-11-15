package com.csp595.utilities;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public SaxParserProductXMLdataStore(String xmlFileName) {
		if(productHashMap.isEmpty()){
			//ParseDocument(xmlFileName);
			//MySqlUtil.insertRecordstoProductTable();
			productHashMap = MySqlUtil.getAllProductMap();
		}
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
			product.setCategory(attributes.getValue("category"));
		}

	}

	@Override
	public void endElement(String str1, String str2, String element) throws SAXException {

		if (element.equals("product")) {
			productList.add(product);
			productHashMap.put(product.getId(), product);
			return;
		}
		if (element.equalsIgnoreCase("condition")) {
			product.setCondition(elementValueRead);
			return;
		}
		if (element.equalsIgnoreCase("discount")) {
			product.setDiscount(Integer.parseInt(elementValueRead));
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
			product.setPrice(Integer.parseInt(elementValueRead));
			return;
		}
		if (element.equalsIgnoreCase("description")) {
			product.setDescription(elementValueRead);
			return;
		}
	}
	
    @Override
    public void characters(char[] content, int begin, int end) throws SAXException {
        elementValueRead = new String(content, begin, end);
    }
}
