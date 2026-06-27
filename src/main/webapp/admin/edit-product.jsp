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
<title>Edit Product</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container-fluid py-4">
		<div class="row g-4">

		<jsp:include page="/admin/layout/sidebar.jsp" />

		<main class="col-lg-9 col-xl-10">

			<h1 class="fw-bold mb-4">Edit Product</h1>

			<form action="edit-product" method="post" class="card border-0 shadow-sm">
				<div class="card-body p-4">

				<input type="hidden" name="productId" value="<%=p.getProductId()%>">

				<label class="form-label fw-semibold">Name</label> <input class="form-control mb-3" type="text" name="name"
					value="<%=p.getName()%>"> <label class="form-label fw-semibold">Price</label> <input
					class="form-control mb-3" type="number" step="0.01" name="price" value="<%=p.getPrice()%>">

				<label class="form-label fw-semibold">Stock</label> <input class="form-control mb-3" type="number" name="stock"
					value="<%=p.getStockQuantity()%>"> <label class="form-label fw-semibold">Description</label>

				<textarea class="form-control mb-3" name="description" rows="4"><%=p.getDescription()%></textarea>

				<label class="form-label fw-semibold">Image URL</label> <input class="form-control mb-3" type="text" name="imageUrl"
					value="<%=p.getImageUrl()%>"> <label class="form-label fw-semibold">Category</label> <select
					class="form-select mb-4" name="categoryId">

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

				<button class="btn btn-success" type="submit">Update Product</button>
				</div>

			</form>

		</main>

		</div>
	</div>

	<jsp:include page="/admin/layout/footer.jsp" />
</body>
</html>
