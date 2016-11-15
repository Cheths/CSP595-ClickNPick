<!DOCTYPE html>
<html lang="en">
<body>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>

<!-- Sidebar ================================================== -->
	<div class="span9">
    <ul class="breadcrumb">
		<li><a href="index.html">Home</a> <span class="divider">/</span></li>
		<li class="active">Login</li>
    </ul>
	<h3> Login</h3>	
	<hr class="soft"/>
	
	<div class="row">
		<div class="span4">
			<div class="well">
			<h5>CREATE YOUR ACCOUNT</h5><br/>
			Enter your username and to create an account.<br/><br/><br/>
			<form action="RegisterServlet" method="POST">
			  <div class="control-group">
				<label class="control-label" for="inputEmail1">Username</label>
				<div class="controls">
				  <input class="span3" name="username" type="text" id="inputEmail1" placeholder="Username" required>
				</div>
			  </div>
			  <div class="control-group">
				<label class="control-label" for="inputPassword1">Password</label>
				<div class="controls">
				  <input type="password" name="password" class="span3"  id="inputPassword1" placeholder="Password" required>
				  <input type="text" name="signup" style=" display: none;" value="yes">
				</div>
			  </div>
			  <div class="control-group">
				<label class="control-label" for="inputPassword1">Confirm Password</label>
				<div class="controls">
				  <input type="password" name="confirmPassword" class="span3"  id="inputPassword2" placeholder="Password" required>
				  <input type="text" name="signup" style=" display: none;" value="yes">
				</div>
			  </div>
			  <div class="control-group">
			  <label class="control-label"  for="inputPassword1" > Role </label>
				<select name="role">
					<option value="Customer">Customer</option>
					<option value="Salesman">Salesman</option>
					<option value="Store Manager">Store Manager</option>
				</select>
			  </div>
			  <div class="control-group">
				<div class="controls">
				  <button type="submit" class="btn">Create Your Account</button>
				</div>
			  </div>
			</form>
		</div>
		</div>
		<div class="span1"> &nbsp;</div>
		<div class="span4">
			<div class="well">
			<h5>ALREADY REGISTERED ?</h5>
			<form action="LoginServlet" method="POST">
			  <div class="control-group">
				<label class="control-label" for="inputEmail1">Username</label>
				<div class="controls">
				  <input class="span3" name="username" type="text" id="inputEmail1" placeholder="Username" required>
				</div>
			  </div>
			  <div class="control-group">
				<label class="control-label"  for="inputPassword1" >Password</label>
				<div class="controls">
				  <input type="password" name="password" class="span3"  id="inputPassword1" placeholder="Password" required>
				</div>
			  </div>
			  <div class="control-group">
			  <label class="control-label"  for="inputPassword1" > Role </label>
				<select name="role">
					<option value="Customer">Customer</option>
					<option value="Salesman">Salesman</option>
					<option value="Store Manager">Store Manager</option>
				</select>
			  </div>
			  <div class="control-group">
				<div class="controls">
				  <button type="submit" class="btn">Sign in</button><!--  <a href="forgetpass.html">Forget password?</a> -->
				</div>
			  </div>
			</form>
		</div>
		</div>
	</div>	
	
</div>
</div></div>
</div>
<!-- MainBody End ============================= -->

<!-- Placed at the end of the document so the pages load faster ============================================= -->
	<script src="themes/js/jquery.js" type="text/javascript"></script>
	<script src="themes/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="themes/js/google-code-prettify/prettify.js"></script>
	
	<script src="themes/js/bootshop.js"></script>
    <script src="themes/js/jquery.lightbox-0.5.js"></script>
	
<span id="themesBtn"></span>
<%@include file="footer.jsp" %>
</body>
</html>