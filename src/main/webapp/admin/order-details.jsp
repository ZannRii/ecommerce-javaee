<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="model.Order"%>
<%@ page import="java.util.List"%>
<%@ page import="model.OrderItem"%>

<%
Order order = (Order) request.getAttribute("order");
List<OrderItem> items = (List<OrderItem>) request.getAttribute("items");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Details</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/order-details.css">

</head>
<body>

	<!-- HEADER -->
	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container">

		<!-- SIDEBAR -->
		<jsp:include page="/admin/layout/sidebar.jsp" />

		<!-- CONTENT -->
		<main class="content">

			<h1>📦 Order Details</h1>

			<!-- ORDER INFO -->
			<div class="info-card">

				<h2>Order Information</h2>

				<p>
					<strong>Order ID:</strong> #${order.orderId}
				</p>

				<p>
					<strong>Customer:</strong> ${order.user.name}
				</p>

				<p>
					<strong>Status:</strong> <span
						class="status status-${order.status}"> ${order.status} </span>
				</p>

				<p>
					<strong>Address:</strong> ${order.address}
				</p>

				<p>
					<strong>Date:</strong> ${order.createdAt}
				</p>

			</div>

			<!-- PRODUCTS -->
			<div class="table-card">

				<h2>Products</h2>

				<table class="details-table">

					<thead>

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

			<!-- TOTAL -->
			<div class="total-card">

				<h2>Grand Total : $${order.totalAmount}</h2>

			</div>

			<!-- STATUS UPDATE -->
			<div class="status-card">

				<h2>Update Status</h2>

				<form action="update-order-status" method="post">

					<input type="hidden" name="orderId" value="${order.orderId}">

					<select name="status">

						<option value="PENDING">PENDING</option>

						<option value="SHIPPED">SHIPPED</option>

						<option value="DELIVERED">DELIVERED</option>

						<option value="CANCELLED">CANCELLED</option>

					</select>

					<button type="submit">Update Status</button>

				</form>

			</div>

		</main>

	</div>

	<!-- FOOTER -->
	<jsp:include page="/admin/layout/footer.jsp" />

</body>
</html>