<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.CartItem"%>
<%@ page import="model.User"%>
<%@ page import="model.Product"%>

<%
User user = (User) session.getAttribute("user");
@SuppressWarnings("unchecked")
List<CartItem> items = (List<CartItem>) request.getAttribute("items");

double total = 0;

if (request.getAttribute("total") != null) {
	total = (double) request.getAttribute("total");
}
%>
<%
Product p = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Cart - ShopHub</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">
</head>

<body class="bg-light">

	<!-- HEADER -->
	<div class="position-sticky top-0 z-3 shadow-sm">
		<header class="navbar navbar-dark bg-dark px-3 px-lg-4 py-3">
			<a href="home" class="navbar-brand fw-bold"><i
				class="bi bi-bag-check-fill text-warning me-2"></i>ShopHub</a>
			<div class="d-flex align-items-center gap-2 flex-wrap">
				<a href="cart" class="btn btn-outline-warning"> <i
					class="bi bi-cart3 me-1"></i> Cart <span id="cartCount"
					class="badge text-bg-warning ms-1"> ${cartCount} </span>
				</a> <span class="text-white fw-semibold"> Hi, <%=user.getName()%>
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

	<!-- CART -->
	<main class="container py-5">
		<h1 class="fw-bold mb-4">Your Cart</h1>
		<%
		if (items != null && !items.isEmpty()) {
		%>

		<div class="card border-0 shadow-sm">
			<div class="table-responsive">
				<table class="table align-middle mb-0">
					<thead class="table-light">
						<tr>
							<th>Image</th>
							<th>Product</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Subtotal</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (CartItem item : items) {
						%>
						<tr>
							<!-- IMAGE -->
							<td><img src="<%=item.getProduct().getImageUrl()%>"
								class="rounded object-fit-cover" width="72" height="72"></td>
							<!-- NAME -->
							<td><%=item.getProduct().getName()%></td>
							<!-- PRICE -->
							<td>$<%=item.getProduct().getPrice()%></td>
							<!-- UPDATE -->
							<td>

								<form action="cart" method="post" class="d-flex gap-2">
									<input type="hidden" name="action" value="update"> <input
										type="hidden" name="productId"
										value="<%=item.getProduct().getProductId()%>"> <input
										type="number" name="quantity" value="<%=item.getQuantity()%>"
										min="1" max="<%=item.getProduct().getStockQuantity()%>"
										class="form-control form-control-sm w-auto">

									<button type="submit" class="btn btn-sm btn-outline-success">Update</button>
								</form>

							</td>

							<!-- SUBTOTAL -->
							<td>$<%=item.getSubtotal()%></td>

							<!-- REMOVE -->
							<td>

								<form action="cart" method="post">
									<input type="hidden" name="action" value="remove"> <input
										type="hidden" name="productId"
										value="<%=item.getProduct().getProductId()%>">
									<button type="submit" class="btn btn-sm btn-outline-danger">Remove</button>
								</form>

							</td>
						</tr>
						<%
						}
						%>

					</tbody>
				</table>
			</div>
		</div>
		<!-- TOTAL -->
		<div class="card border-0 shadow-sm mt-4">
			<div
				class="card-body d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3">
				<h2 class="h4 fw-bold mb-0">
					Total : $<%=total%>
				</h2>
				<form action="checkout" method="post">

					<input type="hidden" name="type" value="cart">

					<button type="submit" class="btn btn-success btn-lg fw-semibold">
						<i class="bi bi-credit-card me-1"></i>Checkout
					</button>

				</form>
			</div>
		</div>
		<%
		} else {
		%>

		<div class="card border-0 shadow-sm text-center py-5">
			<div class="card-body">
				<i class="bi bi-cart-x display-3 text-secondary"></i>
				<h2 class="fw-bold mt-3">Your cart is empty</h2>
				<a href="home" class="btn btn-success mt-3"> Continue Shopping </a>
			</div>
		</div>

		<%
		}
		%>
	</main>
	<!-- FOOTER -->
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
