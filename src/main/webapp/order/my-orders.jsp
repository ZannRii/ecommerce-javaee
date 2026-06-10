<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="model.User"%>

<%
User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/my-orders.css">
</head>
<body>
	<!-- ================= HEADER ================= -->
	<div class="sticky-header">
		<header class="top-nav">

			<a href="home" class="logo">🛒 ShopHub</a>

			<div class="nav-right">
				<a href="cart" class="cart-link"> 🛍 Cart: <span id="cartCount">
						${cartCount} </span></a> <span class="user"> Hi, <%=user.getName()%>
				</span>
				<!-- DROPDOWN MENU -->
				<div class="user-menu">

					<div class="user-icon" onclick="toggleMenu()">☰</div>

					<div id="dropdownMenu" class="dropdown-menu">

						<a href="profile">👤 Profile</a> <a href="my-orders">📦 My
							Orders</a> <a href="logout">🚪 Logout</a>

					</div>

				</div>
			</div>

		</header>
	</div>

	<!-- SUCCESS ORDER HISTORY CONTENT BODY -->
	<div class="orders-container">
		<h2 class="page-title">📦 Your Order History</h2>

		<c:choose>
			<%-- Triggers when the database array is empty --%>
			<c:when test="${empty detailedOrders}">
				<div class="no-orders-box">
					<p class="no-orders-msg">You haven't placed any orders with
						ShopHub yet!</p>
					<a href="${pageContext.request.contextPath}/home"
						class="shop-now-btn">Shop Now</a>
				</div>
			</c:when>

			<c:otherwise>
				<%-- Outer iteration loop across customer order data rows --%>
				<c:forEach var="order" items="${detailedOrders}">
					<div class="order-card">

						<!-- Top Summary Segment -->
						<div class="order-header">
							<div class="meta-group">
								<span class="order-id">Order ID: #${order.orderId}</span> <span
									class="order-date">Date Placed: ${order.createdAt}</span>
							</div>
							<div>
								<!-- Dynamic class assignment parsing matching enum string styles -->
								<span class="status-badge badge-${order.status}">
									${order.status} </span>
							</div>
						</div>

						<!-- Middle Dynamic Item Row Generation -->
						<div class="order-items-list">
							<c:forEach var="item" items="${order.items}">
								<div class="item-row">
									<div class="item-product-details">
										<img class="product-thumb" src="${item.imageUrl}"
											alt="${item.productName}">
										<div class="product-meta">
											<span class="product-name">${item.productName}</span> <span
												class="product-qty">Quantity: ${item.quantity}</span>
										</div>
									</div>
									<div class="item-pricing">
										<span class="unit-price">Unit: $${item.priceAtPurchase}</span>
										<strong class="subtotal-price">Subtotal:
											$${item.priceAtPurchase * item.quantity}</strong>
									</div>
								</div>
							</c:forEach>
						</div>

						<!-- Bottom Delivery & Aggregation Row -->
						<div class="order-footer">
							<div class="delivery-block">
								<span class="footer-label">📍 Delivery Location</span> <span
									class="address-text">${order.address}</span>
							</div>
							<div class="total-block">
								<span class="footer-label">Grand Total</span> <span
									class="grand-total-amount">$${order.totalAmount}</span>
							</div>
							<div class="order-actions">

								<c:if test="${order.status == 'PENDING'}">

									<form action="cancel-order" method="post">

										<input type="hidden" name="orderId" value="${order.orderId}">

										<button type="submit" class="cancel-btn">Cancel Order
										</button>

									</form>

								</c:if>
							</div>
						</div>
						</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>

	<!-- ================= FOOTER ================= -->
	<footer>
		<p>© 2026 ShopHub</p>
	</footer>

	<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
</body>
</html>