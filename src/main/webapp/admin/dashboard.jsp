<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container-fluid py-4">
		<div class="row g-4">

		<!-- SIDEBAR -->
		<jsp:include page="/admin/layout/sidebar.jsp" />

		<!-- Main Content -->
		<main class="col-lg-9 col-xl-10">

			<h1 class="fw-bold mb-4">Admin Dashboard</h1>

			<div class="row g-4">

				<div class="col-sm-6 col-xl-3">
				<div class="card border-0 shadow-sm h-100">
					<div class="card-body">
					<div class="text-secondary fw-semibold">Products</div>
					<p class="display-6 fw-bold text-success mb-0">${totalProducts}</p>
					</div>
				</div>
				</div>

				<div class="col-sm-6 col-xl-3">
				<div class="card border-0 shadow-sm h-100">
					<div class="card-body">
					<div class="text-secondary fw-semibold">Users</div>
					<p class="display-6 fw-bold text-success mb-0">${totalUsers}</p>
					</div>
				</div>
				</div>

				<div class="col-sm-6 col-xl-3">
				<div class="card border-0 shadow-sm h-100">
					<div class="card-body">
					<div class="text-secondary fw-semibold">Orders</div>
					<p class="display-6 fw-bold text-success mb-0">${totalOrders}</p>
					</div>
				</div>
				</div>

				<div class="col-sm-6 col-xl-3">
				<div class="card border-0 shadow-sm h-100">
					<div class="card-body">
					<div class="text-secondary fw-semibold">Revenue</div>
					<p class="display-6 fw-bold text-success mb-0">$${totalRevenue}</p>
					</div>
				</div>
				</div>

			</div>

		</main>

		</div>
	</div>

	<!-- FOOTER -->
	<jsp:include page="/admin/layout/footer.jsp" />
</body>
</html>
