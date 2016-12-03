<%@page import="com.csp595.beans.Donation"%>
<%@page import="java.util.List"%>
<%@page import="com.csp595.utilities.MySqlUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="header.jsp"%>
<%@include file="sidebar.jsp"%>
<html>
<body>
	<%
		List<Donation> donationList = MySqlUtil.readDonations(userRole,userName);
	%>
	<div class="row">
		<div class="span9">
			<%
				if (donationList != null && donationList.isEmpty()) {
			%>
			<h3>NO DONATIONS FOUND</h3>
			<%
				} else {
			%>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>Donar Name</th>
						<th>Organization</th>
						<th>Pieces of Clothes</th>
						<th>Pick Up Location</th>
						<th>Pick Up Date</th>
					</tr>
				</thead>
				<%
					for (Donation donation : donationList) {
							if (donation != null) {
				%>
				<tbody>
					<tr>
						<td><%=donation.getUsername()%></td>
						<td><%=donation.getOrganization()%></td>
						<td><%=donation.getQuantity()%></td>
						<td><%=donation.getPickUpLocation()%></td>
						<td><%=donation.getPickUpDate()%></td>
					</tr>
				</tbody>
				<%
					}
						}
				%>
			</table>
			<%
				}
			%>
		</div>
	</div>
</body>
</html>
<%@include file="footer.jsp"%>