<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="model.Order"%>
<%@ page import="java.util.List"%>
<%@ page import="model.OrderItem"%>

<%
Order order = (Order) request.getAttribute("order");
List<OrderItem> items = (List<OrderItem>) request.getAttribute("items");
List<String> allowedStatuses = (List<String>) request.getAttribute("allowedStatuses");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Details</title>

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

		<!-- CONTENT -->
		<main class="col-lg-9 col-xl-10">

			<div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
				<h1 class="fw-bold mb-0"><i class="bi bi-receipt text-success me-2"></i>Order Details</h1>
				<a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-dark">
					<i class="bi bi-arrow-left me-1"></i>Back to Orders
				</a>
			</div>

			<%
			if (request.getAttribute("error") != null) {
			%>
			<div class="alert alert-danger alert-dismissible fade show" role="alert">
				<i class="bi bi-exclamation-triangle me-2"></i>${error}
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
			<%
			}
			%>

			<%
			if (request.getAttribute("success") != null) {
			%>
			<div class="alert alert-success alert-dismissible fade show" role="alert">
				<i class="bi bi-check-circle me-2"></i>${success}
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
			<%
			}
			%>

			<!-- ORDER INFO -->
			<div class="card border-0 shadow-sm mb-4">
				<div class="card-body">

				<h2 class="h5 fw-bold mb-3">Order Information</h2>

				<p>
					<strong>Order ID:</strong> #${order.orderId}
				</p>

				<p>
					<strong>Customer:</strong> ${order.user.name}
				</p>

				<p>
					<strong>Status:</strong> <span
						class="badge text-bg-success"> ${order.status} </span>
				</p>

				<p>
					<strong>Address:</strong> ${order.address}
				</p>

				<p>
					<strong>Date:</strong> ${order.createdAt}
				</p>

				</div>
			</div>

			<!-- PRODUCTS -->
			<div class="card border-0 shadow-sm mb-4">
				<div class="card-body">

				<h2 class="h5 fw-bold mb-3">Products</h2>

				<div class="table-responsive">
				<table class="table align-middle mb-0">

					<thead class="table-light">

						<tr>
							<th>Product</th>
							<th>Price</th>
							<th>Qty</th>
							<th>Subtotal</th>
						</tr>

					</thead>

					<tbody>

						<%
						for (OrderItem item : items) {
						%>

						<tr>

							<td><%=item.getProductName()%></td>

							<td>$<%=item.getPriceAtPurchase()%>
							</td>

							<td><%=item.getQuantity()%></td>

							<td>$<%=item.getPriceAtPurchase() * item.getQuantity()%>
							</td>

						</tr>

						<%
						}
						%>

					</tbody>

				</table>
				</div>

				</div>
			</div>

			<!-- TOTAL -->
			<div class="card border-0 shadow-sm mb-4">
				<div class="card-body">

				<h2 class="h4 text-success fw-bold mb-0">Grand Total : $${order.totalAmount}</h2>

				</div>
			</div>

			<!-- STATUS UPDATE -->
			<div class="card border-0 shadow-sm">
				<div class="card-body">

				<h2 class="h5 fw-bold mb-3">Update Status</h2>

				<form action="update-order-status" method="post" class="row g-3 align-items-end">

					<input type="hidden" name="orderId" value="${order.orderId}">

					<div class="col-md-8">
					<label class="form-label fw-semibold">Status</label>
					<select class="form-select" name="status" <%=allowedStatuses == null || allowedStatuses.isEmpty() ? "disabled" : ""%>>

						<%
						if (allowedStatuses != null && !allowedStatuses.isEmpty()) {
							for (String status : allowedStatuses) {
						%>
						<option value="<%=status%>"><%=status%></option>
						<%
							}
						} else {
						%>
						<option>No further status changes allowed</option>
						<%
						}
						%>

					</select>
					</div>

					<div class="col-md-4">
					<button class="btn btn-success w-100" type="submit" <%=allowedStatuses == null || allowedStatuses.isEmpty() ? "disabled" : ""%>>Update Status</button>
					</div>

				</form>

				</div>
			</div>

		</main>

		</div>
	</div>

	<!-- FOOTER -->
	<jsp:include page="/admin/layout/footer.jsp" />

</body>
</html>
