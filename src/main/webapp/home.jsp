<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="model.User"%>

<%
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
<title>ShopHub</title>
<link rel="stylesheet" href="css/style.css">
</head>

<body>

	<!-- STICKY HEADER -->
	<div class="sticky-header">

		<header class="top-nav">
			<div class="logo">🛒 ShopHub</div>

			<div class="search-bar">
				<input type="text" id="searchBox" placeholder="Search products...">
				<button onclick="searchProduct()">Search</button>
			</div>

			<div class="nav-right">
				🛍 Cart: <span id="cartCount">0</span>

				<% if (user == null) { %>
				<a href="login.jsp" class="login-btn">Login</a>
				<% } else { %>
				<span class="user">Hi, <%= user.getName() %></span> <a href="logout"
					class="login-btn">Logout</a>
				<% } %>
			</div>
		</header>

		<nav class="category-nav">
			<button onclick="filter('all')">All</button>
			<button onclick="filter('tech')">Tech</button>
			<button onclick="filter('fashion')">Fashion</button>
			<button onclick="filter('home')">Home</button>
		</nav>

	</div>

	<!-- HERO -->
	<section class="hero">
		<h1>Big Sale Today</h1>
		<p>Up to 50% off</p>
	</section>

	<!-- PRODUCTS -->
	<section class="products">

		<!-- PRODUCT 1 -->
		<div class="product-card tech">
			<img src="images/laptop.png">
			<h3>Laptop</h3>
			<p>$899</p>

			<form action="cart" method="post">
				<input type="hidden" name="productId" value="1"> <input
					type="number" name="quantity" value="1" min="1">

				<button type="submit">Add to Cart</button>
			</form>
		</div>
		<!-- PRODUCT 2 -->
		<div class="product-card fashion">
			<img src="images/shirt.jpg">
			<h3>Shirt</h3>
			<p>$25</p>

			<form action="cart" method="post">
				<input type="hidden" name="productId" value="2"> <input
					type="number" name="quantity" value="1" min="1">

				<button type="submit">Add to Cart</button>
			</form>
		</div>

		<!-- PRODUCT 3 -->
		<div class="product-card tech">
			<img src="images/phone.jpg">
			<h3>Phone</h3>
			<p>$499</p>

			<form action="cart" method="post">
				<input type="hidden" name="productId" value="3"> <input
					type="number" name="quantity" value="1" min="1">

				<button type="submit">Add to Cart</button>
			</form>
		</div>

		<!-- PRODUCT 4 -->
		<div class="product-card home">
			<img src="images/chair.jpg">
			<h3>Chair</h3>
			<p>$120</p>

			<form action="cart" method="post">
				<input type="hidden" name="productId" value="4"> <input
					type="number" name="quantity" value="1" min="1">

				<button type="submit">Add to Cart</button>
			</form>
		</div>

	</section>

	<footer>
		<p>© 2026 ShopHub</p>
	</footer>

	<script src="js/scripts.js"></script>

</body>
</html>