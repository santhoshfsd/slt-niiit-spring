<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript">

$("#categoryid").change(function() {
    
	var parent = $(this).val(); //get option value from parent 
	
	var bird = [
	    {display: "Dark chocolate", value: "dark-chocolate" }, 
	    {display: "Milk chocolate", value: "milk-chocolate" }, 
	    {display: "White chocolate", value: "white-chocolate" },
	    {display: "Gianduja chocolate", value: "gianduja-chocolate" }];
	var dog = [
	    {display: "Dark chocolate", value: "dark-chocolate" }, 
	    {display: "Milk chocolate", value: "milk-chocolate" }, 
	    {display: "White chocolate", value: "white-chocolate" },
	    {display: "Gianduja chocolate", value: "gianduja-chocolate" }];
	var fish = [
	    {display: "Dark chocolate", value: "dark-chocolate" }, 
	    {display: "Milk chocolate", value: "milk-chocolate" }, 
	    {display: "White chocolate", value: "white-chocolate" },
	    {display: "Gianduja chocolate", value: "gianduja-chocolate" }];
	var cat = [
	    {display: "Dark chocolate", value: "dark-chocolate" }, 
	    {display: "Milk chocolate", value: "milk-chocolate" }, 
	    {display: "White chocolate", value: "white-chocolate" },
	    {display: "Gianduja chocolate", value: "gianduja-chocolate" }];
	switch(parent){ //using switch compare selected option and populate child
          case 'Bird':
            list(bird);
            break;
          case 'Dog':
           alert(parent);
        	  list(dog);
            break;              
          case 'Fish':
            list(fish);
            break;
          case 'Cat':
              list(cat);
              break;  
        default: //default child option is blank
            $("#subcategoryid").html('');  
            break;
       }
});

//function to populate child select box
function list(array_list)
{
$("#subcategoryid").html(""); //reset child options
$(array_list).each(function (i) { //populate child options 
    $("#subcategoryid").append
    ("<option value=""+array_list[i].value+"">"+array_list[i].display+"</option>");

});
}

});	

</script>
</head>
<body>
	<!-- using spring form tag, create a form to get input for product -->
	<!-- product =new Product() -->
	<!--  url=/admin/saveproduct -->
	<div class="container">
	<h3 align="center">Add Product</h3>
	<c:url value="/admin/saveproduct" var="url"></c:url>
	<form:form action='${url }' modelAttribute="product" role="form" enctype="multipart/form-data">
		<!-- hidden field is for product id
			product.setId(0)
 		-->
		<form:hidden path="id" />
        <div class="form-group">
		<form:label path="productname">Enter product Name</form:label>
		<!-- product.setProductname('Pen') -->
		<form:input path="productname" class="form-control" style="width:750px"/>
		<form:errors path="productname" cssStyle="color:red"></form:errors>
        </div>
        
        <div class="form-group">
		<form:label path="productdescription">Enter ProductDescription</form:label>
		<!-- product.setProductDescription('.....') -->
		<form:textarea path="productdescription"  class="form-control" style="width:750px"/>
        <form:errors path="productdescription" cssStyle="color:red"></form:errors>
        </div>
        <div class="form-group">
		<form:label path="quantity">Enter Quantity</form:label>
		<!-- product.setQuantity(12) -->
		<form:input path="quantity" class="form-control" style="width:750px"/>
		<form:errors path="quantity" cssStyle="color:red"></form:errors>
        </div>
        <div class="form-group">
		<form:label path="price">Enter Price</form:label>
		<!-- product.setPrice(..) -->
		<form:input path="price" class="form-control" style="width:750px"/>
		<form:errors path="price" cssStyle="color:red"></form:errors>
        </div>

		<div class="form-group">
		<form:select name="categoryid" path="category.id" id="categoryid">
		<c:forEach items="${categories1}" var ="c1">
		<c:set value="${c1.categoryid}" var="val"/>
		<form:option value="${val}">${c1.categoryname}</form:option>
		</c:forEach>
		</form:select>		
        </div>

        <div class="form-group">
        <form:select name="subcategoryid" path="category.id" id="subcategoryid">
		</form:select>		
		</div>
        <div class="form-group">
		<form:label path="image">Upload Image</form:label>
		<form:input type="file" path="image" />
        </div>
		<input type="submit" value="Add Product">
	</form:form>
	</div>
</body>
</html>