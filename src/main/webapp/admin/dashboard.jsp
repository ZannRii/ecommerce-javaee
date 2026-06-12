<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin-dashboard.css">
</head>
<body>

	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container">

		<!-- SIDEBAR -->
		<jsp:include page="/admin/layout/sidebar.jsp" />

		<!-- Main Content -->
		<main class="content">

			<h1>Admin Dashboard</h1>

			<div class="cards">

				<div class="card">
					<h3>Products</h3>
					<p>${totalProducts}</p>
				</div>

				<div class="card">
					<h3>Users</h3>
					<p>${totalUsers}</p>
				</div>

				<div class="card">
					<h3>Orders</h3>
					<p>${totalOrders}</p>
				</div>

				<div class="card">
					<h3>Revenue</h3>
					<p>$${totalRevenue}</p>
				</div>

			</div>

		</main>

	</div>

	<!-- FOOTER -->
	<jsp:include page="/admin/layout/footer.jsp" />
</body>
</html>