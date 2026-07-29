<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="model.Product"%>
<%@ page import="model.Category"%>
<%
User user = (User) session.getAttribute("user");
%>
<%
List<Category> categories = (List<Category>) request.getAttribute("categories");
%>
<%
@SuppressWarnings("unchecked")
List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html>
<head>
<title>ShopHub</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">
</head>

<body class="bg-light">

	<!-- STICKY HEADER -->
	<div class="position-sticky top-0 z-3 shadow-sm">

		<header
			class="navbar navbar-expand-lg navbar-dark bg-dark px-3 px-lg-4 py-3">
			<a href="home" class="navbar-brand fw-bold"><i
				class="bi bi-bag-check-fill text-warning me-2"></i>ShopHub</a>

			<div class="d-flex flex-grow-1 mx-lg-4 my-3 my-lg-0">
				<input class="form-control rounded-end-0" type="text" id="searchBox"
					value="${keyword}" placeholder="Search products..."
					onkeydown="if(event.key === 'Enter'){ searchProduct(); }">
				<button type="button"
					class="btn btn-warning rounded-start-0 fw-semibold"
					onclick="searchProduct()">Search</button>
			</div>

			<div class="d-flex align-items-center gap-2 flex-wrap">

				<a href="cart" class="btn btn-outline-warning"> <i
					class="bi bi-cart3 me-1"></i> Cart <span id="cartCount"
					class="badge text-bg-warning ms-1"> ${cartCount} </span>
				</a>

				<%
				if (user == null) {
				%>
				<a href="login.jsp" class="btn btn-warning fw-semibold">Login</a>
				<%
				} else {
				%>
				<span class="text-white fw-semibold"> Hi, <%=user.getName()%>
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

				<%
				}
				%>
			</div>
		</header>

		<nav
			class="bg-white border-bottom px-3 px-lg-4 py-2 d-flex gap-2 overflow-auto">

			<button class="btn btn-outline-success btn-sm rounded-pill px-3"
				onclick="location.href='home'">All</button>

			<%
			if (categories != null) {
				for (Category c : categories) {
			%>

			<button class="btn btn-outline-success btn-sm rounded-pill px-3"
				onclick="location.href='home?categoryId=<%=c.getCategoryId()%>'">

				<%=c.getName()%>

			</button>

			<%
			}
			}
			%>

		</nav>

	</div>

	<!-- HERO -->
	<section class="bg-success bg-gradient text-white py-5">
		<div class="container py-4">
			<div class="row align-items-center g-4">
				<div class="col-lg-7">
					<p class="text-uppercase fw-bold text-warning mb-2">Seasonal
						deals</p>
					<h1 class="display-4 fw-bold">Shop smarter with fresh picks</h1>
					<p class="lead mb-0">Curated products, clear prices, and fast
						checkout for everyday shopping.</p>
				</div>
				<div class="col-lg-5 text-lg-end">
					<img src="${pageContext.request.contextPath}/images/laptop.png"
						class="img-fluid rounded-4 shadow" alt="Featured product">
				</div>
			</div>
		</div>
	</section>





	<section class="container py-5">
		<div class="d-flex align-items-center justify-content-between mb-4">
			<h2 class="fw-bold mb-0">Featured Products</h2>
		</div>
		<div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-4">

			<%
			if (products != null && !products.isEmpty()) {
				for (Product p : products) {
			%>

			<div class="col">
				<div class="card h-100 border-0 shadow-sm">

					<img src="<%=p.getImageUrl()%>"
						class="card-img-top object-fit-cover" height="210"
						alt="<%=p.getName()%>">

					<div class="card-body d-flex flex-column">
						<h3 class="h6 fw-bold"><%=p.getName()%></h3>

						<p class="h5 text-success fw-bold">
							$<%=p.getPrice()%></p>

						<form action="cart" method="post" class="mt-auto">

							<input type="hidden" name="action" value="add"> <input
								type="hidden" name="productId" value="<%=p.getProductId()%>">
							<input class="form-control mb-2" type="number" name="quantity"
								value="1" min="1" max="<%=p.getStockQuantity()%>">
							<button class="btn btn-success w-100 fw-semibold" type="submit">
								<i class="bi bi-cart-plus me-1"></i>Add To Cart
							</button>

						</form>
						<a href="product-detail?id=<%=p.getProductId()%>"
							class="btn btn-outline-dark w-100 mt-2"> View Details <i
							class="bi bi-arrow-right"></i></a>
					</div>
				</div>
			</div>

			<%
			}
			} else {
			%>

			<div class="col-12">
				<div class="alert alert-info">No products found.</div>
			</div>

			<%
			}
			%>
		</div>
	</section>
	<footer class="bg-dark text-white text-center py-4 mt-5">
		<p class="mb-0">© 2026 ShopHub</p>
	</footer>

	
	<!-- Include Chatbot -->
	<jsp:include page="chat.jsp" />
	<jsp:include page="chat-icon.jsp" />

	

	<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
