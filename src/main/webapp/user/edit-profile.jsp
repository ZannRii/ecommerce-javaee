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
<title>Edit Profile - ShopHub</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">
</head>
<body class="bg-light">
	<!-- ================= HEADER ================= -->
	<div class="position-sticky top-0 z-3 shadow-sm">
		<header class="navbar navbar-dark bg-dark px-3 px-lg-4 py-3">

			<a href="home" class="navbar-brand fw-bold"><i
				class="bi bi-bag-check-fill text-warning me-2"></i>ShopHub</a>

			<div class="d-flex align-items-center gap-2 flex-wrap">
				<a href="cart" class="btn btn-outline-warning"><i
					class="bi bi-cart3 me-1"></i> Cart <span id="cartCount"
					class="badge text-bg-warning ms-1"> ${cartCount} </span></a> <span
					class="text-white fw-semibold"> Hi, <%=user.getName()%>
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
			</div>

		</header>
	</div>
	<main class="container py-5">

		<h2 class="fw-bold mb-4">Edit Profile</h2>

		<div class="card border-0 shadow-sm">
			<div class="card-body p-4">

				<form action="update-profile" method="post">

					<label class="form-label fw-semibold">Name</label> <input
						class="form-control mb-3" type="text" name="name"
						value="<%=user.getName()%>"> <label
						class="form-label fw-semibold">Phone</label> <input
						class="form-control mb-3" type="text" name="phone"
						value="<%=user.getPhone()%>"> <label
						class="form-label fw-semibold">Email</label> <input
						class="form-control mb-3" type="text" name="email"
						value="<%=user.getEmail()%>">

					<button class="btn btn-success" type="submit">Update
						Profile</button>

				</form>

			</div>
		</div>

	</main>
	<!-- ================= FOOTER ================= -->
	<footer class="bg-dark text-white text-center py-4">
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
