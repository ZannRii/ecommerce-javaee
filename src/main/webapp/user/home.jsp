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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
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

				<a href="cart" class="cart-link"> 🛍 Cart: <span id="cartCount">
						${cartCount} </span>
				</a>

				<%
				if (user == null) {
				%>
				<a href="login.jsp" class="login-btn">Login</a>
				<%
				} else {
				%>
				<span class="user"> Hi, <%=user.getName()%>
				</span>
				<!-- DROPDOWN MENU -->
				<div class="user-menu">

					<div class="user-icon" onclick="toggleMenu()">☰</div>

					<div id="dropdownMenu" class="dropdown-menu">

						<a href="profile">👤 Profile</a> <a href="my-orders">📦 My
							Orders</a> <a href="logout">🚪 Logout</a>

					</div>

				</div>

				<%
				}
				%>
			</div>
		</header>

		<nav class="category-nav">

			<button onclick="location.href='home'">All</button>

			<%
			if (categories != null) {
				for (Category c : categories) {
			%>

			<button
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
	<section class="hero">
		<h1>Big Sale Today</h1>
		<p>Up to 50% off</p>
	</section>





	<section class="products">

		<%
		if (products != null) {
			for (Product p : products) {
		%>

		<div class="product-card">

			<img src="<%=p.getImageUrl()%>">

			<h3><%=p.getName()%></h3>

			<p>
				$<%=p.getPrice()%></p>

			<form action="cart" method="post">

				<input type="hidden" name="action" value="add"> <input
					type="hidden" name="productId" value="<%=p.getProductId()%>">
				<input type="number" name="quantity" value="1" min="1"
					max="<%=p.getStockQuantity()%>">
				<button type="submit">Add To Cart</button>

			</form>
			<a href="product-detail?id=<%=p.getProductId()%>"
				class="btn detail-btn"> View Details -></a>
		</div>

		<%
		}
		} else {
		%>

		<p>No products available.</p>

		<%
		}
		%>

	</section>
	<footer>
		<p>© 2026 ShopHub</p>
	</footer>

	<script src="${pageContext.request.contextPath}/js/scripts.js"></script>

</body>
</html>