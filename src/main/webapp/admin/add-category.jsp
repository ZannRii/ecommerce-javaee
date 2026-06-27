<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Category</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

</head>
<body class="bg-light">

	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container-fluid py-4">
		<div class="row g-4">

		<jsp:include page="/admin/layout/sidebar.jsp" />

		<main class="col-lg-9 col-xl-10">

			<h1 class="fw-bold mb-4">Add Category</h1>

			<form action="add-category" method="post" class="card border-0 shadow-sm">
				<div class="card-body p-4">

				<label class="form-label fw-semibold">Category Name</label> <input class="form-control mb-3" type="text" name="name" required>
				<label class="form-label fw-semibold">Description</label> <input class="form-control mb-4" type="text" name="description" required>

				<button class="btn btn-success" type="submit"><i class="bi bi-plus-lg me-1"></i>Add Category</button>
				</div>

			</form>

		</main>

		</div>
	</div>

	<jsp:include page="/admin/layout/footer.jsp" />

</body>
</html>
