<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/add-product.css">
</head>
<body>
	<!-- HEADER -->
	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container">

		<!-- SIDEBAR -->
		<jsp:include page="/admin/layout/sidebar.jsp" />

		<!-- MAIN CONTENT -->
		<main class="content">

			<h1>Add Product</h1>

			<form action="${pageContext.request.contextPath}/admin/add-product"
				method="post" class="form-box">

				<label>Product Name</label> <input type="text" name="name" required>

				<label>Price</label> <input type="number" name="price" step="0.01"
					required> <label>Stock</label> <input type="number"
					name="stock" required> <label>Description</label>
				<textarea name="description"></textarea>

				<label>Image URL</label> <input type="text" name="imageUrl">

				<label>Category ID</label> <select name="categoryId" required>

					<option value="">-- Select Category --</option>

					<%
					List<Category> categories = (List<Category>) request.getAttribute("categories");

					if (categories != null) {
						for (Category c : categories) {
					%>

					<option value="<%=c.getCategoryId()%>">
						<%=c.getName()%>
					</option>

					<%
					}
					}
					%>

				</select>

				<button type="submit">Add Product</button>

			</form>

		</main>

	</div>

	<!-- FOOTER -->
	<jsp:include page="/admin/layout/footer.jsp" />
</body>
</html>