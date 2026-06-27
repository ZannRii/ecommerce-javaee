<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Product</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
	<!-- HEADER -->
	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container-fluid py-4">
		<div class="row g-4">

		<!-- SIDEBAR -->
		<jsp:include page="/admin/layout/sidebar.jsp" />

		<!-- MAIN CONTENT -->
		<main class="col-lg-9 col-xl-10">

			<h1 class="fw-bold mb-4">Add Product</h1>

			<form action="${pageContext.request.contextPath}/admin/add-product"
				method="post" class="card border-0 shadow-sm">
				<div class="card-body p-4">

				<label class="form-label fw-semibold">Product Name</label> <input class="form-control mb-3" type="text" name="name" required>

				<label class="form-label fw-semibold">Price</label> <input class="form-control mb-3" type="number" name="price" step="0.01"
					required> <label class="form-label fw-semibold">Stock</label> <input class="form-control mb-3" type="number"
					name="stock" required> <label class="form-label fw-semibold">Description</label>
				<textarea class="form-control mb-3" name="description" rows="4"></textarea>

				<label class="form-label fw-semibold">Image URL</label> <input class="form-control mb-3" type="text" name="imageUrl">

				<label class="form-label fw-semibold">Category</label> <select class="form-select mb-4" name="categoryId" required>

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

				<button class="btn btn-success" type="submit"><i class="bi bi-plus-lg me-1"></i>Add Product</button>
				</div>

			</form>

		</main>

		</div>
	</div>

	<!-- FOOTER -->
	<jsp:include page="/admin/layout/footer.jsp" />
</body>
</html>
