<!DOCTYPE html>
<html lang="en">
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<body>
<div id="mainBody">
	<div class="container">
	<div class="row">
	<div class="span9">
    <ul class="breadcrumb">
		<li><a href="index.jsp">Home</a> <span class="divider">/</span></li>
		<li class="active">Forgot password?</li>
    </ul>
	<h3> FORGOT YOUR PASSWORD?</h3>	
	<hr class="soft"/>
	
	<div class="row">
		<div class="span9" style="min-height:900px">
			<div class="well">
			<h5>Reset your password</h5><br/>
			Please enter the email address for your account. Password will be sent to you.<br/><br/><br/>
			<form action="login.jsp" method="POST">
			  <div class="control-group">
				<label class="control-label" for="inputEmail1">E-mail address</label>
				<div class="controls">
				  <input class="span3"  type="text" name ="mailId" id="inputEmail1" placeholder="Email">
				</div>
			  </div>
			  <div class="controls">
			  <button type="submit" class="btn block">Submit</button>
			  </div>
			</form>
		</div>
		</div>
	</div>	
</div>
</div>
</div>
</div>
<!-- MainBody End ============================= -->
</body>
</html>