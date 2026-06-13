<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Product"%>
<%@ page import="java.util.List"%>
<%@ page import="model.Category"%>

<%
Product p = (Product) request.getAttribute("product");

List<Category> categories = (List<Category>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/edit-product.css">
</head>
<body>
	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container">

		<jsp:include page="/admin/layout/sidebar.jsp" />

		<main class="content">

			<h1>Edit Product</h1>

			<form action="edit-product" method="post" class="form-box">

				<input type="hidden" name="productId" value="<%=p.getProductId()%>">

				<label>Name</label> <input type="text" name="name"
					value="<%=p.getName()%>"> <label>Price</label> <input
					type="number" step="0.01" name="price" value="<%=p.getPrice()%>">

				<label>Stock</label> <input type="number" name="stock"
					value="<%=p.getStockQuantity()%>"> <label>Description</label>

				<textarea name="description"><%=p.getDescription()%></textarea>

				<label>Image URL</label> <input type="text" name="imageUrl"
					value="<%=p.getImageUrl()%>"> <label>Category</label> <select
					name="categoryId">

					<%
					for (Category c : categories) {
					%>

					<option value="<%=c.getCategoryId()%>"
						<%=p.getCategoryId() == c.getCategoryId() ? "selected" : ""%>>

						<%=c.getName()%>

					</option>

					<%
					}
					%>

				</select>

				<button type="submit">Update Product</button>

			</form>

		</main>

	</div>

	<jsp:include page="/admin/layout/footer.jsp" />
</body>
</html>