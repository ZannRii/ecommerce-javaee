<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	href="${pageContext.request.contextPath}/css/profile.css">
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
	<div class="profile-container">

		<h2>My Profile</h2>

		<div class="profile-card">

			<p>
				<strong>Name:</strong>
				<%=user.getName()%>
			</p>

			<p>
				<strong>Email:</strong>
				<%=user.getEmail()%>
			</p>

			<p>
				<strong>Phone:</strong>
				<%=user.getPhone()%>
			</p>

			<p>
				<strong>Role:</strong>
				<%=user.getRole()%>
			</p>

			<a href="edit-profile" class="edit-btn"> Edit Profile </a>

		</div>

	</div>
	<!-- ================= FOOTER ================= -->
	<footer>
		<p>© 2026 ShopHub</p>
	</footer>

	<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
</body>
</html>