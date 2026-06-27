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
<title>Products</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container-fluid py-4">
		<div class="row g-4">

		<jsp:include page="/admin/layout/sidebar.jsp" />

		<main class="col-lg-9 col-xl-10">

			<div class="d-flex justify-content-between align-items-center mb-4">
				<h1 class="fw-bold mb-0">Products</h1>
				<a class="btn btn-success" href="${pageContext.request.contextPath}/admin/add-product"><i class="bi bi-plus-lg me-1"></i>Add Product</a>
			</div>

			<div class="card border-0 shadow-sm">
			<div class="table-responsive">
			<table class="table align-middle mb-0">
				<thead class="table-light">

				<tr>
					<th>ID</th>
					<th>Image</th>
					<th>Name</th>
					<th>Price</th>
					<th>Stock</th>
					<th>Category</th>
					<th>Action</th>
				</tr>
				</thead>
				<tbody>

				<%
				for (Product p : products) {
				%>

				<tr>

					<td><%=p.getProductId()%></td>

					<td><img src="${pageContext.request.contextPath}/<%=p.getImageUrl()%>" class="rounded object-fit-cover" width="64" height="64"></td>

					<td><%=p.getName()%></td>

					<td>$<%=p.getPrice()%></td>

					<td><%=p.getStockQuantity()%></td>

					<td><%=p.getCategoryName()%></td>

					<td><a href="edit-product?id=<%=p.getProductId()%>"
						class="btn btn-sm btn-outline-success"> Edit </a> <a
						href="delete-product?id=<%=p.getProductId()%>"  onclick="return confirm('Are you sure you want to delete this product?')" class="btn btn-sm btn-outline-danger">
							Delete </a></td>

				</tr>

				<%
				}
				%>

				</tbody>
			</table>
			</div>
			</div>

		</main>

		</div>
	</div>

	<jsp:include page="/admin/layout/footer.jsp" />
</body>
</html>
