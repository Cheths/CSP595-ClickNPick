function init() {
	searchFieldValue = document.getElementById("searchValue").value;
	searchTable = document.getElementById("complete-table");
	autoRow = document.getElementById("auto-row");
};
function autoCompleteSearch(){
	var searchValue = document.getElementById("searchValue").value;
	var url = "autoComplete?action=complete&searchValue="+searchValue;
	req = initRequest();
	req.open("GET",url,true);
	req.onreadystatechange = callback;
	req.send();
};
function initRequest(){
	isIE = false;
	if (window.XMLHttpRequest) {
		if (navigator.userAgent.indexOf('MSIE') != -1) {
			isIE = true;
		}
		return new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		isIE = true;
		return new ActiveXObject("Microsoft.XMLHTTP");
	}
};
function callback(){
	clearTable();
	if(req.readyState == 4){
		if(req.status == 200){
			parseMessages(req.responseXML);
		}
	}
};
function clearTable(){
	if(searchTable.getElementsByTagName("tr").length > 0)
		searchTable.style.display = 'none';
	for(loop = searchTable.childNodes.length-1; loop >= 0; loop--){
		searchTable.removeChild(searchTable.childNodes[loop]);
	}
};
function parseMessages(responseXml){
	if(responseXml == null){
		return false;
	} else {
		var products = responseXml.getElementsByTagName("products")[0];
		if(products.childNodes.length > 0){
			searchTable.setAttribute("bordercolor", "black");
			searchTable.setAttribute("border", "1");
			for (loop = 0; loop < products.childNodes.length; loop++) {
			var product = products.childNodes[loop];
			var productName = product.getElementsByTagName("productName")[0];
			var productId = product.getElementsByTagName("id")[0];
			appendProduct(productName.childNodes[0].nodeValue,
			productId.childNodes[0].nodeValue);
			}
		}
	}
};
function appendProduct(productName,productId) {
	var row;
	var cell;
	var linkElement;

	if (isIE) {
		searchTable.style.display = 'block';
		row = searchTable.insertRow(searchTable.rows.length);
		cell = row.insertCell(0);
	} else {
		searchTable.style.display = 'table';
		row = document.createElement("tr");
		cell = document.createElement("td");
		cell.setAttribute("style","background-color: blue;font-family: cursive;padding-left: 10px;");
		row.appendChild(cell);
		searchTable.appendChild(row);
	}
	cell.className = "popupCell";
	linkElement = document.createElement("a");
	linkElement.className = "popupItem";
	linkElement.setAttribute("href", "UtilityServlet?id=" + productId);
	linkElement.setAttribute("style","color: aliceblue;");
	linkElement.appendChild(document.createTextNode(productName));
	cell.appendChild(linkElement);
};