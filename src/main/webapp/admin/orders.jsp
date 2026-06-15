<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin-orders.css">
</head>
<body>
	<jsp:include page="/admin/layout/header.jsp" />
	<jsp:include page="/admin/layout/sidebar.jsp" />
	<div class="orders-section">

		<h1 class="page-title">📦 Order Management</h1>

		<table class="orders-table">

			<thead>
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

						<td><span class="status status-${o.status}">
								${o.status} </span></td>

						<td>${o.createdAt}</td>

						<td><a href="order-details?id=${o.orderId}" class="view-btn">
								View Details </a></td>

					</tr>

				</c:forEach>

			</tbody>

		</table>

	</div>
	<!-- FOOTER -->
	<jsp:include page="/admin/layout/footer.jsp" />
</body>
</html>