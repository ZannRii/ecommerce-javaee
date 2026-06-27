<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Product"%>
<%@ page import="model.User"%>

<%
User user = (User) session.getAttribute("user");
%>
<%
Product p = (Product) request.getAttribute("product");
%>

<!DOCTYPE html>
<html>
<head>
<title>Product Detail</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>

<body class="bg-light">

	<!-- HEADER -->
	<div class="position-sticky top-0 z-3 shadow-sm">
		<header class="navbar navbar-dark bg-dark px-3 px-lg-4 py-3">
			<a href="home" class="navbar-brand fw-bold"><i class="bi bi-bag-check-fill text-warning me-2"></i>ShopHub</a>
			<div class="d-flex align-items-center gap-2 flex-wrap">
				<a href="cart" class="btn btn-outline-warning">
					<i class="bi bi-cart3 me-1"></i> Cart <span id="cartCount" class="badge text-bg-warning ms-1">
						${cartCount} </span>
				</a> <span class="text-white fw-semibold"> Hi, <%=user.getName()%>
				</span>
				<!-- DROPDOWN MENU -->
				<div class="dropdown">

					<button type="button" class="btn btn-outline-light dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"><i class="bi bi-list"></i></button>

					<div class="dropdown-menu dropdown-menu-end shadow">

						<a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="bi bi-person me-2"></i>Profile</a>
						<a class="dropdown-item" href="${pageContext.request.contextPath}/my-orders"><i class="bi bi-box-seam me-2"></i>My Orders</a>
						<a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>

					</div>

				</div>
			</div>
		</header>
	</div>

	<main class="container py-5">
	<div class="row g-4 align-items-start">

		<!-- LEFT IMAGE -->
		<div class="col-lg-6">
			<img src="<%=p.getImageUrl()%>" class="img-fluid rounded-4 shadow-sm bg-white" alt="<%=p.getName()%>">
		</div>

		<!-- RIGHT INFO -->
		<div class="col-lg-6">
		<div class="card border-0 shadow-sm">
		<div class="card-body p-4">

			<h1 class="fw-bold"><%=p.getName()%></h1>

			<p class="display-6 text-success fw-bold">
				$<%=p.getPrice()%></p>

			<p class="badge text-bg-light border">
				<i class="bi bi-box-seam me-1"></i> Stock:
				<%=p.getStockQuantity()%>
			</p>

			<p class="text-secondary">
				<%=p.getDescription()%>
			</p>

			<!-- ACTION FORM -->

			<form action="cart" method="post" class="mb-3">

				<input type="hidden" name="productId" value="<%=p.getProductId()%>">

				<label class="form-label fw-semibold">Cart Quantity</label> <input class="form-control mb-3" type="number" name="quantity"
					value="1" min="1" max="<%=p.getStockQuantity()%>">

				<button type="submit" name="action" value="add" class="btn btn-success w-100 fw-semibold">
					<i class="bi bi-cart-plus me-1"></i>Add To Cart</button>
			</form>
			<form action="checkout" method="post">

				<input type="hidden" name="type" value="buyNow"> <input
					type="hidden" name="productId" value="<%=p.getProductId()%>">

				<label class="form-label fw-semibold">Product Quantity</label> <input class="form-control mb-3" type="number" name="quantity"
					value="1" min="1" max="<%=p.getStockQuantity()%>">

				<button type="submit" class="btn btn-warning w-100 fw-semibold">Buy Now</button>

			</form>

		</div>
		</div>
		</div>

	</div>
	</main>

	<!-- FOOTER -->
	<footer class="bg-dark text-white text-center py-4">
		<p class="mb-0">© 2026 ShopHub</p>
	</footer>
	<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
