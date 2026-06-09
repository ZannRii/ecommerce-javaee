<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="model.*"%>

<%
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

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/checkout.css">
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

	<!-- ================= CONTENT ================= -->
	<div class="checkout-container">

		<h2>Checkout</h2>

		<!-- BUY NOW SECTION -->
		<%
		if ("buyNow".equals(type) && product != null) {
		%>

		<div class="checkout-box">

			<h3><%=product.getName()%></h3>

			<p>
				Price: $<%=product.getPrice()%></p>

			<p>
				Quantity:
				<%=quantity%></p>

			<hr>

			<h3>
				Total: $<%=total%></h3>

		</div>

		<%
		}
		%>

		<!-- CART SECTION -->
		<%
		if ("cart".equals(type) && cartItems != null) {
		%>

		<div class="checkout-box">

			<%
			for (CartItem item : cartItems) {
			%>

			<div class="item">

				<p><%=item.getProduct().getName()%></p>

				<p>
					Quantity:
					<%=item.getQuantity()%></p>

				<p>
					$<%=item.getProduct().getPrice() * item.getQuantity()%>
				</p>

			</div>

			<%
			}
			%>

			<hr>

			<h3>
				Total: $<%=total%></h3>

		</div>

		<%
		}
		%>

		<!-- ================= ADDRESS FORM ================= -->
		<div class="address-box">

			<form action="place-order" method="post">

				<input type="hidden" name="type" value="<%=type%>">

				<!-- BUY NOW DATA -->
				<%
				if ("buyNow".equals(type)) {
				%>

				<input type="hidden" name="productId"
					value="<%=product.getProductId()%>"> <input type="hidden"
					name="quantity" value="<%=quantity%>">

				<%
				}
				%>

				<!-- ADDRESS -->
				<label>Delivery Address</label>
				<textarea name="address" required></textarea>

				<button type="submit" class="place-order-btn">Place Order</button>

			</form>

		</div>

	</div>

	<!-- ================= FOOTER ================= -->
	<footer>
		<p>© 2026 ShopHub</p>
	</footer>

</body>
</html>