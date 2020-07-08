<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
var k;
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
        <%-- <div class="form-group">
		<form:select path="category.id" onchange="populate(this.id,'subcategoryid')">
		<c:forEach items="${categories}" var ="c">
		<form:option value="${c.id}">${c.categoryName}</form:option>
		</c:forEach>
		</form:select>		
        </div>
		 --%>
		<div class="form-group">
		<form:select path="category.id" id="categoryid" onchange="getCategoryId()">
		<c:forEach items="${categories1}" var ="c1">
		<c:set value="${c1.categoryid}" var="val"/>
		<form:option value="${val}">${c1.categoryname}</form:option>
		</c:forEach>
		</form:select>		
        </div>
         <script>
		 function getCategoryId()
		 {
			 var k;
		 	k=document.getElementById("categoryid").value;		 	
			 window.location.replace("getproductform?catid="+k);
		 }
		 </script>
		         <c:set value="${param.catid}" var="category_id"/>
        <div class="form-group">
        <form:select path="category.id" id="subcategoryid">
        <c:forEach items="${subcategory}" var ="sc">
        <c:if test="${sc.categoryids == category_id}">
        <form:option value="${sc.subcategoryid}">${sc.categoryname}</form:option>
        </c:if>
		</c:forEach>
		</form:select>		
		</div>
        <div class="form-group">
		<form:label path="image">Upload Image</form:label>
		<form:input type="file" path="image" />
        </div>
		<h1>${category_id}</h1>
		<input type="submit" value="Add Product">
	</form:form>
	</div>
</body>
</html>