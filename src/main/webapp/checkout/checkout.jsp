<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="model.*"%>

<%
User user = (User) session.getAttribute("user");
String type = (String) request.getAttribute("type");

Product product = (Product) request.getAttribute("product");
Integer quantity = (Integer) request.getAttribute("quantity");

List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");

Double total = (Double) request.getAttribute("total");
%>

<!DOCTYPE html>
<html>
<head>
<title>Checkout</title>

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
					class="badge text-bg-warning ms-1"> ${cartCount} </span> </a><span
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

	<!-- ================= CONTENT ================= -->
	<main class="container py-5">

		<h2 class="fw-bold mb-4">Checkout</h2>
		<div class="row g-4">
			<div class="col-lg-7">

				<!-- BUY NOW SECTION -->
				<%
				if ("buyNow".equals(type) && product != null) {
				%>

				<div class="card border-0 shadow-sm mb-4">
					<div class="card-body">

						<h3 class="h5 fw-bold"><%=product.getName()%></h3>

						<p class="text-secondary mb-1">
							Price: $<%=product.getPrice()%></p>

						<p class="text-secondary">
							Quantity:
							<%=quantity%></p>

						<hr>

						<h3 class="text-success fw-bold">
							Total: $<%=total%></h3>

					</div>
				</div>

				<%
				}
				%>

				<!-- CART SECTION -->
				<%
				if ("cart".equals(type) && cartItems != null) {
				%>

				<div class="card border-0 shadow-sm mb-4">
					<div class="card-body">

						<%
						for (CartItem item : cartItems) {
						%>

						<div
							class="d-flex justify-content-between gap-3 border-bottom py-3">

							<p class="fw-semibold mb-0"><%=item.getProduct().getName()%></p>

							<p class="text-secondary mb-0">
								Quantity:
								<%=item.getQuantity()%></p>

							<p class="fw-bold mb-0">
								$<%=item.getProduct().getPrice() * item.getQuantity()%>
							</p>

						</div>

						<%
						}
						%>

						<hr>

						<h3 class="text-success fw-bold">
							Total: $<%=total%></h3>

					</div>
				</div>

				<%
				}
				%>

				<!-- ================= ADDRESS FORM ================= -->
			</div>
			<div class="col-lg-5">
				<div class="card border-0 shadow-sm">
					<div class="card-body p-4">
						<h3 class="h5 fw-bold mb-3">
							<i class="bi bi-geo-alt text-success me-2"></i>Delivery Address
						</h3>

						<form action="place-order" method="post">

							<input type="hidden" name="type" value="<%=type%>">

							<!-- BUY NOW DATA -->
							<%
							if ("buyNow".equals(type)) {
							%>

							<input type="hidden" name="productId"
								value="<%=product.getProductId()%>"> <input
								type="hidden" name="quantity" value="<%=quantity%>">

							<%
							}
							%>

							<!-- ADDRESS -->
							<label class="form-label fw-semibold">Delivery Address</label>
							<textarea class="form-control mb-3" rows="5" name="address"
								required></textarea>

							<button type="submit"
								class="btn btn-success btn-lg w-100 fw-semibold">Place
								Order</button>

						</form>

					</div>
				</div>
			</div>
		</div>

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
