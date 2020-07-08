<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href='<c:url value="/resources/css/registration.css"></c:url>'>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.min.js"></script>
<script type="text/javascript">
function fillShippingAddress(form){
	if(form.shippingsame.checked==true){
		form["shippingAddress.houseOrAptNo"].value=form["billingAddress.houseOrAptNo"].value;
		form["shippingAddress.streetName"].value=form["billingAddress.streetName"].value;
		form["shippingAddress.city"].value=form["billingAddress.city"].value;
		form["shippingAddress.state"].value=form["billingAddress.state"].value;
		form["shippingAddress.country"].value=form["billingAddress.country"].value;
		form["shippingAddress.zipCode"].value=form["billingAddress.zipCode"].value;
	}
	if(form.shippingsame.checked==false){
		form["shippingAddress.houseOrAptNo"].value=""
		form["shippingAddress.streetName"].value=""
		form["shippingAddress.city"].value=""
		form["shippingAddress.state"].value=""
		form["shippingAddress.country"].value=""
		form["shippingAddress.zipCode"].value=""
	}
}

$(document).ready(function(){
	$('#form').validate({
		rules:{
			firstName:{required:true},
			lastName:{required:true},
			phoneNumber:{required:true,number:true,minlength:10,maxlength:10},
			"user.email":{required:true,email:true},
			"user.password":{required:true,minlength:5,maxlength:10},
			"billingAddress.houseOrAptNo":{required:true},
			"billingAddress.streetName":{required:true},
			"billingAddress.state":{required:true},
			"billingAddress.city":{required:true},
			"billingAddress.country":{required:true},
			"billingAddress.zipCode":{required:true,number:true}
		},
		messages:{
			firstName:{required:"Firstname is mandatory"},
			phoneNumber:{required:"Phonenumber is required"},
			"user.email":{required:"Email is required",email:"Please enter valid email address"}
		}
	})
})

</script>
</head>
<body>
<div class="container">
<c:url var="url" value="/all/registercustomer"></c:url>
<form:form modelAttribute="customer" action="${url }" id="form">
<p align="center"><b>Customer Details</b></p>
<form:label path="id"></form:label>
<form:hidden path="id"/>


<form:label path="firstName">Enter Firstname</form:label>
<form:input path="firstName" id="firstname"/>


<form:label path="lastName">Enter lastname</form:label>
<form:input path="lastName" id="lastname" />


<form:label path="phoneNumber">Enter phonenumber</form:label>
<form:input path="phoneNumber" id="phonenumber" />

<hr>
<p align="center"><b>Login credentials</b><br></p>
<form:label path="user.email">Enter Email </form:label>
<form:input path="user.email" id="user.email"/>

<form:label path="user.password">Enter password</form:label>
<form:input path="user.password" type="password" id="user.password"/>
<hr>
<p align="center"><b>Billing Address</b><br></p>
<form:label path="billingAddress.houseOrAptNo">Enter Apartmentnumber</form:label>
<form:input path="billingAddress.houseOrAptNo" id="billingAddress.houseOrAptNo"/>

<form:label path="billingAddress.streetName">Enter Streetname</form:label>
<form:input path="billingAddress.streetName" id="billingAddress.streetName"/>

<form:label path="billingAddress.city">Enter city</form:label>
<form:input path="billingAddress.city" id="billingAddress.city"/>

<form:label path="billingAddress.state">Enter State</form:label>
<form:input path="billingAddress.state" id="billingAddress.state"/>

<form:label path="billingAddress.country">Enter country</form:label>
<form:input path="billingAddress.country" id="billingAddress.country"/>

<form:label path="billingAddress.zipCode">Enter zipCode</form:label>
<form:input path="billingAddress.zipCode" id="billingAddress.zipCode"/>

<hr>

<p align="center"><b>Shipping Address</b></p>	
<label>
Check this if billing address and shipping address are same</label>
<input type="checkbox" onclick="fillShippingAddress(this.form)" id="shippingsame" >
<form:label path="shippingAddress.houseOrAptNo">Enter Apartmentnumber</form:label>
<form:input path="shippingAddress.houseOrAptNo" id="shippingAddress.houseOrAptNo"/>


<form:label path="shippingAddress.streetName">Enter Streetname</form:label>
<form:input path="shippingAddress.streetName" id="shippingAddress.streetName"/>


<form:label path="shippingAddress.city">Enter city</form:label>
<form:input path="shippingAddress.city" id="shippingAddress.city"/>


<form:label path="shippingAddress.state">Enter State</form:label>
<form:input path="shippingAddress.state" id="shippingAddress.state"/>


<form:label path="shippingAddress.country">Enter country</form:label>
<form:input path="shippingAddress.country" id="shippingAddress.country"/>


<form:label path="shippingAddress.zipCode">Enter zipCode</form:label>
<form:input path="shippingAddress.zipCode" id="shippingAddress.zipCode"/>


<button type="submit" >Register</button>
</form:form>
</div>
</body>
</html>
