<!DOCTYPE html>
<%@page import="com.csp595.utilities.ProductHelper"%>
<%@page import="com.csp595.controller.UtilityServlet"%>
<%@page import="com.csp595.utilities.MySqlUtil"%>
<html lang="en">
<body>
	<%@include file="header.jsp"%>

	<%@include file="sidebar.jsp"%>

	<!-- Sidebar ================================================== -->

	<div id="mainBody">
		<div class="container">
			<div class="row">
				<div class="span9">
					<%
						String loginError = (String) session.getAttribute("loginError");
						String mailId = (String) request.getParameter("mailId");
						if (loginError != null) {
							if (loginError.equals("true")) {
								session.removeAttribute("loginError");
					%>
					<div class="alert" style="background-color: #f44336;">
						<span class="closebtn"
							onclick="this.parentElement.style.display='none';">&times;</span>
						<strong>Invalid User Credentials!</strong>
					</div>
					<%
						}
						} else if(mailId != null){
							ProductHelper.sendPasswordThroughMail(mailId);
							%>
							<div class="alert" style="background-color: #5bb75b;">
								<span class="closebtn"
									onclick="this.parentElement.style.display='none';">&times;</span>
								<strong>An email has been sent to your mail id with the password.</strong>
							</div>
							<%
						}
					%>
					<ul class="breadcrumb">
						<li><a href="index.jsp">Home</a> <span class="divider">/</span></li>
						<li class="active">Login</li>
					</ul>
					<h3>Login</h3>
					<div class="span4">
						<div class="well">
							<h5>ALREADY REGISTERED ?</h5>
							<form action="LoginServlet" method="POST">
								<div class="control-group">
									<label class="control-label" for="inputEmail1">Username</label>
									<div class="controls">
										<input class="span3" name="username" type="text"
											id="inputEmail1" placeholder="Username" required>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="inputPassword1">Password</label>
									<div class="controls">
										<input type="password" name="password" class="span3"
											id="inputPassword1" placeholder="Password" required>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="inputPassword1">
										Role </label> <select name="role">
										<option value="Customer">Customer</option>
										<option value="Salesman">Salesman</option>
										<option value="Store Manager">Store Manager</option>
									</select>
								</div>
								<div class="control-group">
									<div class="controls">
										<button type="submit" class="btn">Sign in</button>
										<a href="forget_password.jsp">Forgot password?</a>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!-- MainBody End ============================= -->

	<!-- Placed at the end of the document so the pages load faster ============================================= -->
	<script src="themes/js/jquery.js" type="text/javascript"></script>
	<script src="themes/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="themes/js/google-code-prettify/prettify.js"></script>

	<script src="themes/js/bootshop.js"></script>
	<script src="themes/js/jquery.lightbox-0.5.js"></script>

	<span id="themesBtn"></span>
	<%@include file="footer.jsp"%>
</body>
</html>