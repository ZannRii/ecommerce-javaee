<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin-dashboard.css">
</head>
<body>
	<aside class="sidebar">
		<ul class="menu">

			<li><a href="dashboard">Dashboard</a></li>

			<li class="dropdown"><a href="#"
				onclick="toggleMenu('products')">Products ▼</a>
				<ul id="products" class="submenu">
					<li><a href="${pageContext.request.contextPath}/admin/view-product">View Products</a></li>
					<li><a href="${pageContext.request.contextPath}/admin/add-product">Add Product</a></li>
				</ul></li>

			<li class="dropdown"><a href="#"
				onclick="toggleMenu('categories')">Categories ▼</a>
				<ul id="categories" class="submenu">
					<li><a href="categories">View Categories</a></li>
					<li><a href="add-category">Add Category</a></li>
				</ul></li>

			<li class="dropdown"><a href="#" onclick="toggleMenu('orders')">Orders
					▼</a>
				<ul id="orders" class="submenu">
					<li><a href="orders">View Orders</a></li>
				</ul></li>

			<li class="dropdown"><a href="#" onclick="toggleMenu('users')">Users
					▼</a>
				<ul id="users" class="submenu">
					<li><a href="users">View Users</a></li>
				</ul></li>

			<li><a class="logout" href="${pageContext.request.contextPath}/logout">Logout</a></li>

		</ul>
	</aside>
</body>
</html>