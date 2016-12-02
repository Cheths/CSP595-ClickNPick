package com.csp595.utilities;

import java.io.File;
import java.util.Map;
import java.util.Map.Entry;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.csp595.beans.Product;

public class PrepareXmlFile {

	private static final String PRODUCT_SCRIPT_XML_FILE_NAME = "C:\\apache-tomcat-7.0.34\\webapps\\CSP595-ClicknPick\\Scripts\\Products.xml";

	public static void prepareXmlFile() {

		try {

			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

			Document doc = docBuilder.newDocument();
			Element rootElement = doc.createElement("Products");
			doc.appendChild(rootElement);

			Map<String, Product> productHashMap = MySqlUtil.getAllProductMap(null);
			for (Entry<String, Product> productEntry : productHashMap.entrySet()) {
				Product product = productEntry.getValue();

				Element prod = doc.createElement("product");
				rootElement.appendChild(prod);
				prod.setAttribute("id", product.getId());

				Element category = doc.createElement("category");
				category.appendChild(doc.createTextNode(product.getCategory()));
				prod.appendChild(category);

				Element name = doc.createElement("name");
				name.appendChild(doc.createTextNode(product.getName()));
				prod.appendChild(name);

				Element description = doc.createElement("description");
				description.appendChild(doc.createTextNode(product.getDescription()));
				prod.appendChild(description);

				Element type = doc.createElement("type");
				type.appendChild(doc.createTextNode(product.getType()));
				prod.appendChild(type);

				Element price = doc.createElement("price");
				price.appendChild(doc.createTextNode(String.valueOf(product.getPrice())));
				prod.appendChild(price);

				Element discount = doc.createElement("discount");
				discount.appendChild(doc.createTextNode(String.valueOf(product.getDiscount())));
				prod.appendChild(discount);

				Element manufacturer = doc.createElement("manufacturer");
				manufacturer.appendChild(doc.createTextNode(product.getManufacturer()));
				prod.appendChild(manufacturer);

				Element condition = doc.createElement("condition");
				condition.appendChild(doc.createTextNode(product.getCondition()));
				prod.appendChild(condition);

				Element image = doc.createElement("image");
				image.appendChild(doc.createTextNode(product.getImage()));
				prod.appendChild(image);

				Element gender = doc.createElement("gender");
				gender.appendChild(doc.createTextNode(product.getGender()));
				prod.appendChild(gender);

			}
			if (!productHashMap.isEmpty()) {
				TransformerFactory transformerFactory = TransformerFactory.newInstance();
				Transformer transformer = transformerFactory.newTransformer();
				DOMSource source = new DOMSource(doc);
				StreamResult result = new StreamResult(new File(PRODUCT_SCRIPT_XML_FILE_NAME));
				transformer.transform(source, result);
			}
			System.out.println("File saved!");

		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (TransformerException tfe) {
			tfe.printStackTrace();
		}
	}
}
