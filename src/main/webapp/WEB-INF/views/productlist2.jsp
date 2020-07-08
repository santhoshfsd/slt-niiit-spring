<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="header.jsp"%>
<html>
<head>
<link type="text/css" rel="stylesheet" href='<c:url value="/resources/css/grid.css"></c:url>'>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Insert title here</title>
<script>
$(document).ready(function() {
    $('#list').click(function(event){event.preventDefault();$('#products .item').addClass('list-group-item');});
    $('#grid').click(function(event){event.preventDefault();$('#products .item').removeClass('list-group-item');$('#products .item').addClass('grid-group-item');});
});
</script>
</head>
<body>

<div class="container">
    <div class="well well-sm">
        <strong>Category Title</strong>

    </div>
    <div id="products" class="row list-group">
    	<c:forEach items="${product}" var="p">
	 		<div class="item  col-xs-4 col-lg-4">
            <div class="thumbnail">
		<img class="group list-group-image" src='<c:url value="/resources/images/${p.getId()}.png">
							</c:url>' alt="Image Not available" width="400" height="250" />
                <div class="caption">
                    <h4 class="group inner list-group-item-heading">
                        ${p.productname }</h4>
                    <p class="group inner list-group-item-text">
						${p.productdescription }
                    <div class="row">
                        <div class="col-xs-12 col-md-6">
                            <p class="lead">
                               ${p.price }</p>
                        </div>
                        <div class="col-xs-12 col-md-6">
                        	<c:url value="/cart/addFromList/${p.getId() }" var="url"></c:url>
                            <a class="btn btn-success" href="${url}">Add to cart</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		</c:forEach>
    </div>
</div>
</body>
</html>
<%@ include file="/WEB-INF/views/footer.jsp" %>