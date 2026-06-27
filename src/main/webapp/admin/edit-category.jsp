<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="model.Category"%>

<%
Category category = (Category) request.getAttribute("category");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Category</title>

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

			<h1 class="fw-bold mb-4">Edit Category</h1>

			<form action="edit-category" method="post" class="card border-0 shadow-sm">
				<div class="card-body p-4">

				<!-- Hidden ID -->
				<input type="hidden" name="id" value="<%=category.getCategoryId()%>">

				<!-- Category Name -->
				<label class="form-label fw-semibold">Category Name</label> <input class="form-control mb-3" type="text" name="name"
					value="<%=category.getName()%>" required>
				<!-- Category Name -->
				<label class="form-label fw-semibold">Description</label> <input class="form-control mb-4" type="text" name="description"
					value="<%=category.getDescription()%>" required>

				<button class="btn btn-success" type="submit">Update Category</button>
				</div>

			</form>

		</main>

		</div>
	</div>

	<!-- FOOTER -->
	<jsp:include page="/admin/layout/footer.jsp" />

</body>
</html>
