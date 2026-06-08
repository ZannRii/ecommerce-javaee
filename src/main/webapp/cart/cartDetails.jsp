<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.CartItem"%>
<%@ page import="model.User"%>

<%
User user = (User) session.getAttribute("user");
@SuppressWarnings("unchecked")
List<CartItem> items = (List<CartItem>) request.getAttribute("items");

double total = 0;

if (request.getAttribute("total") != null) {
	total = (double) request.getAttribute("total");
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Cart - ShopHub</title>
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
				<span class="user"> Hi, <%=user.getName()%>
				</span> <a href="logout" class="login-btn"> Logout </a>
			</div>
		</header>
	</div>

	<!-- CART -->
	<div class="cart-container">
		<h1 class="cart-title">Your Cart</h1>
		<%
		if (items != null && !items.isEmpty()) {
		%>

		<table class="cart-table">
			<tr>
				<th>Image</th>
				<th>Product</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Subtotal</th>
				<th>Action</th>
			</tr>
			<%
			for (CartItem item : items) {
			%>

			<tr>
				<!-- IMAGE -->
				<td><img src="<%=item.getProduct().getImageUrl()%>"
					class="cart-image"></td>
				<!-- NAME -->
				<td><%=item.getProduct().getName()%></td>
				<!-- PRICE -->
				<td>$<%=item.getProduct().getPrice()%></td>
				<!-- UPDATE -->
				<td>

					<form action="cart" method="post">
						<input type="hidden" name="action" value="update"> <input
							type="hidden" name="productId"
							value="<%=item.getProduct().getProductId()%>"> <input
							type="number" name="quantity" value="<%=item.getQuantity()%>"
							min="1" class="qty-input">

						<button type="submit" class="update-btn">Update</button>
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
						<button type="submit" class="remove-btn">Remove</button>
					</form>

				</td>
			</tr>
			<%
			}
			%>

		</table>
		<!-- TOTAL -->
		<div class="total-box">
			<h2>
				Total : $<%=total%>
			</h2>
			<form action="checkout" method="post">

				<input type="hidden" name="type" value="cart">

				<button type="submit" class="checkout-btn">Checkout</button>

			</form>
		</div>
		<%
		} else {
		%>

		<div class="empty-cart">
			<h2>Your cart is empty</h2>
			<a href="home" class="continue-btn"> Continue Shopping </a>
		</div>

		<%
		}
		%>

	</div>
	<!-- FOOTER -->
	<footer>
		<p>© 2026 ShopHub</p>
	</footer>

</body>
</html>