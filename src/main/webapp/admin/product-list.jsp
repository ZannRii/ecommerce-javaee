<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.Product"%>

<%
List<Product> products = (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/product-list.css">
</head>
<body>
	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container">

		<jsp:include page="/admin/layout/sidebar.jsp" />

		<main class="content">

			<h1>Products</h1>

			<table class="admin-table">

				<tr>
					<th>ID</th>
					<th>Image</th>
					<th>Name</th>
					<th>Price</th>
					<th>Stock</th>
					<th>Category</th>
					<th>Action</th>
				</tr>

				<%
				for (Product p : products) {
				%>

				<tr>

					<td><%=p.getProductId()%></td>

					<td><img src="${pageContext.request.contextPath}/<%=p.getImageUrl()%>" width="60"></td>

					<td><%=p.getName()%></td>

					<td>$<%=p.getPrice()%></td>

					<td><%=p.getStockQuantity()%></td>

					<td><%=p.getCategoryName()%></td>

					<td><a href="edit-product?id=<%=p.getProductId()%>"
						class="edit-btn"> Edit </a> <a
						href="delete-product?id=<%=p.getProductId()%>"  onclick="return confirm('Are you sure you want to delete this product?')" class="delete-btn">
							Delete </a></td>

				</tr>

				<%
				}
				%>

			</table>

		</main>

	</div>

	<jsp:include page="/admin/layout/footer.jsp" />
</body>
</html>