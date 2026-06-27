<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
	<jsp:include page="/admin/layout/header.jsp" />
	<div class="container-fluid py-4">
		<div class="row g-4">
		<jsp:include page="/admin/layout/sidebar.jsp" />
		<main class="col-lg-9 col-xl-10">

		<h1 class="fw-bold mb-4"> Order Management</h1>

		<div class="card border-0 shadow-sm">
		<div class="table-responsive">
		<table class="table align-middle mb-0">

			<thead class="table-light">
				<tr>
					<th>Order ID</th>
					<th>Customer</th>
					<th>Total</th>
					<th>Status</th>
					<th>Order Date</th>
					<th>Action</th>
				</tr>
			</thead>

			<tbody>

				<c:forEach var="o" items="${orders}">

					<tr>

						<td>#${o.orderId}</td>

						<td>${o.user.name}</td>

						<td>$${o.totalAmount}</td>

						<td><span class="badge text-bg-success">
								${o.status} </span></td>

						<td>${o.createdAt}</td>

						<td><a href="order-details?id=${o.orderId}" class="btn btn-sm btn-outline-success">
								View Details </a></td>

					</tr>

				</c:forEach>

			</tbody>

		</table>
		</div>
		</div>

		</main>
		</div>
	</div>
	<!-- FOOTER -->
	<jsp:include page="/admin/layout/footer.jsp" />
</body>
</html>
