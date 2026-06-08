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
<link rel="stylesheet" href="css/detail.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/cart.css">
</head>

<body>

	<!-- HEADER -->
	<div class="sticky-header">
		<header class="top-nav">
			<a href="home" class="logo"> 🛒 ShopHub </a>
			<div class="nav-right">
				<a href="cart" class="cart-link"> 🛍 Cart: <span id="cartCount">
						${cartCount} </span>
				</a> <span class="user"> Hi, <%=user.getName()%>
				</span> <a href="logout" class="login-btn"> Logout </a>
			</div>
		</header>
	</div>

	<div class="container">

		<!-- LEFT IMAGE -->
		<div class="image-box">
			<img src="<%=p.getImageUrl()%>" alt="">
		</div>

		<!-- RIGHT INFO -->
		<div class="info-box">

			<h1><%=p.getName()%></h1>

			<p class="price">
				$<%=p.getPrice()%></p>

			<p class="stock">
				Stock:
				<%=p.getStockQuantity()%>
			</p>

			<p class="desc">
				<%=p.getDescription()%>
			</p>

			<!-- ACTION FORM -->

			<form action="cart" method="post" class="action-form">

				<input type="hidden" name="productId" value="<%=p.getProductId()%>">

				<label>Cart Quantity</label> <input type="number" name="quantity"
					value="1" min="1" max="<%=p.getStockQuantity()%>">

				<button type="submit" name="action" value="add" class="cart-btn">
					Add To Cart</button>
			</form>
			<form action="checkout" method="post" class="action-form">

				<input type="hidden" name="type" value="buyNow"> <input
					type="hidden" name="productId" value="<%=p.getProductId()%>">

				<label>Product Quantity</label> <input type="number" name="quantity"
					value="1" min="1" max="<%=p.getStockQuantity()%>">

				<button type="submit" class="buy-btn">Buy Now</button>

			</form>

		</div>

	</div>

	<!-- FOOTER -->
	<footer>
		<p>© 2026 ShopHub</p>
	</footer>

</body>
</html>