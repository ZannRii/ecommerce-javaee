<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

</head>
<body class="bg-light min-vh-100 d-flex flex-column">

	<header class="navbar navbar-dark bg-dark px-4 py-3 shadow-sm">
		<a href="home" class="navbar-brand fw-bold"><i class="bi bi-bag-check-fill text-warning me-2"></i>ShopHub</a>
	</header>
	<main class="container flex-grow-1 d-flex align-items-center justify-content-center py-5">
	<div class="col-12 col-sm-10 col-md-7 col-lg-5 col-xl-4">
	<div class="card border-0 shadow-sm">
		<div class="card-body p-4 p-md-5">
		<h2 class="fw-bold mb-1">Create Account</h2>
		<p class="text-secondary mb-4">Start shopping with a clean, secure profile.</p>

		<form action="user" method="post">
			<input type="hidden" name="action" value="register"> <input
				class="form-control mb-3" type="text" name="name" placeholder="Full Name" required> <input
				class="form-control mb-3" type="email" name="email" placeholder="Email" required> <input
				class="form-control mb-3" type="password" name="password" placeholder="Password" required>
			<input class="form-control mb-3" type="text" name="phone" placeholder="Phone Number" required>

			<button class="btn btn-success w-100 fw-semibold" type="submit">Register</button>
		</form>

		<a class="d-block text-center mt-3" href="login.jsp">Already have an account? Login</a>

		<div class="text-danger fw-semibold mt-3">${error}</div>
	</div>
	</div>
	</div>
	</main>
	<footer class="bg-dark text-white text-center py-4">
		<p class="mb-0">© 2026 ShopHub</p>
	</footer>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
