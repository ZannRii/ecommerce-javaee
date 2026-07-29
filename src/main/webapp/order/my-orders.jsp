<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="model.User"%>

<%
User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Orders - ShopHub</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">
</head>
<body class="bg-light">
	<!-- ================= HEADER ================= -->
	<div class="position-sticky top-0 z-3 shadow-sm">
		<header class="navbar navbar-dark bg-dark px-3 px-lg-4 py-3">

			<a href="home" class="navbar-brand fw-bold"><i
				class="bi bi-bag-check-fill text-warning me-2"></i>ShopHub</a>

			<div class="d-flex align-items-center gap-2 flex-wrap">
				<a href="cart" class="btn btn-outline-warning"><i
					class="bi bi-cart3 me-1"></i> Cart <span id="cartCount"
					class="badge text-bg-warning ms-1"> ${cartCount} </span></a> <span
					class="text-white fw-semibold"> Hi, <%=user.getName()%>
				</span>
				<!-- DROPDOWN MENU -->
				<div class="dropdown">

					<button type="button" class="btn btn-outline-light dropdown-toggle"
						data-bs-toggle="dropdown" aria-expanded="false">
						<i class="bi bi-list"></i>
					</button>

					<div class="dropdown-menu dropdown-menu-end shadow">

						<a class="dropdown-item"
							href="${pageContext.request.contextPath}/profile"><i
							class="bi bi-person me-2"></i>Profile</a> <a class="dropdown-item"
							href="${pageContext.request.contextPath}/my-orders"><i
							class="bi bi-box-seam me-2"></i>My Orders</a> <a
							class="dropdown-item text-danger"
							href="${pageContext.request.contextPath}/logout"><i
							class="bi bi-box-arrow-right me-2"></i>Logout</a>

					</div>

				</div>
			</div>

		</header>
	</div>

	<!-- SUCCESS ORDER HISTORY CONTENT BODY -->
	<main class="container py-5">
		<h2 class="fw-bold mb-4">
			<i class="bi bi-box-seam text-success me-2"></i>Your Order History
		</h2>

		<c:choose>
			<%-- Triggers when the database array is empty --%>
			<c:when test="${empty detailedOrders}">
				<div class="card border-0 shadow-sm text-center py-5">
					<div class="card-body">
						<i class="bi bi-bag-x display-3 text-secondary"></i>
						<p class="h5 fw-semibold mt-3">You haven't placed any orders
							with ShopHub yet!</p>
						<a href="${pageContext.request.contextPath}/home"
							class="btn btn-success mt-3">Shop Now</a>
					</div>
				</div>
			</c:when>

			<c:otherwise>
				<%-- Outer iteration loop across customer order data rows --%>
				<c:forEach var="order" items="${detailedOrders}">
					<div class="card border-0 shadow-sm mb-4">
						<div class="card-body">

							<!-- Top Summary Segment -->
							<div
								class="d-flex flex-column flex-md-row justify-content-between gap-3 border-bottom pb-3 mb-3">
								<div class="meta-group">
									<span class="fw-bold d-block">Order ID:
										#${order.orderId}</span> <span class="text-secondary">Date
										Placed: ${order.createdAt}</span>
								</div>
								<div>
									<!-- Dynamic class assignment parsing matching enum string styles -->
									<span class="badge text-bg-success"> ${order.status} </span>
								</div>
							</div>

							<!-- Middle Dynamic Item Row Generation -->
							<div>
								<c:forEach var="item" items="${order.items}">
									<div
										class="d-flex flex-column flex-md-row justify-content-between gap-3 border-bottom py-3">
										<div class="d-flex align-items-center gap-3">
											<img class="rounded object-fit-cover" width="72" height="72"
												src="${item.imageUrl}" alt="${item.productName}">
											<div class="product-meta">
												<span class="fw-bold d-block">${item.productName}</span> <span
													class="text-secondary">Quantity: ${item.quantity}</span>
											</div>
										</div>
										<div class="text-md-end">
											<span class="text-secondary d-block">Unit:
												$${item.priceAtPurchase}</span> <strong>Subtotal:
												$${item.priceAtPurchase * item.quantity}</strong>
										</div>
									</div>
								</c:forEach>
							</div>

							<!-- Bottom Delivery & Aggregation Row -->
							<div
								class="d-flex flex-column flex-lg-row justify-content-between gap-3 pt-3">
								<div class="delivery-block">
									<span class="fw-semibold d-block"><i
										class="bi bi-geo-alt text-success me-1"></i>Delivery Location</span>
									<span class="text-secondary">${order.address}</span>
								</div>
								<div class="total-block">
									<span class="text-secondary d-block">Grand Total</span> <span
										class="h4 text-success fw-bold">$${order.totalAmount}</span>
								</div>
								<div class="order-actions">

									<c:if test="${order.status == 'PENDING'}">

										<form action="cancel-order" method="post">

											<input type="hidden" name="orderId" value="${order.orderId}">

											<button type="submit" class="btn btn-outline-danger">Cancel
												Order</button>

										</form>

									</c:if>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</main>

	<!-- ================= FOOTER ================= -->
	<footer class="bg-dark text-white text-center py-4">
		<p class="mb-0">© 2026 ShopHub</p>
	</footer>
	<!-- Include Chatbot -->
	<jsp:include page="/user/chat.jsp" />
	<jsp:include page="/user/chat-icon.jsp" />
	<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
