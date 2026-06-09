<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="model.*"%>


<!DOCTYPE html>
<html>
<head>
<title>Checkout</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/order.css">
</head>

<body>

	<!-- ================= HEADER ================= -->
	<div class="sticky-header">
		<header class="top-nav">

			<a href="home" class="logo">🛒 ShopHub</a>

			<div class="nav-right">
				<a href="cart" class="cart-link"> 🛍 Cart: <span id="cartCount">
						${cartCount} </span>
				</a> <a href="logout" class="login-btn">Logout</a>
			</div>

		</header>
	</div>

	<!-- SUCCESS CONTENT -->
	<div class="success-container">

		<div class="success-card">

			<h1>✅ Order Placed Successfully!</h1>

			<p>Thank you for shopping with ShopHub.</p>

			<p>Your order has been received and is being processed.</p>

			<div class="btn-group">

				<a href="home" class="home-btn"> Continue Shopping </a> <a
					href="my-orders" class="orders-btn"> View My Orders </a>

			</div>

		</div>

	</div>

	<!-- ================= FOOTER ================= -->
	<footer>
		<p>© 2026 ShopHub</p>
	</footer>

</body>
</html>