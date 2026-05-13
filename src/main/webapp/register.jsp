<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<link rel="stylesheet" href="css/register.css">
<link rel="stylesheet" href="css/style.css">

</head>
<body>

	<header class="top-nav">
		<div class="logo">🛒 ShopHub</div>
	</header>
	<div class="container">
		<h2>Create Account</h2>

		<form action="user" method="post">
			<input type="hidden" name="action" value="register"> <input
				type="text" name="name" placeholder="Full Name" required> <input
				type="email" name="email" placeholder="Email" required> <input
				type="password" name="password" placeholder="Password" required>
			<input type="text" name="phone" placeholder="Phone Number" required>
			<!-- ✅ NEW -->

			<button type="submit">Register</button>
		</form>

		<a href="login.jsp">Already have an account? Login</a>

		<div class="error">${error}</div>
	</div>
	<footer>
		<p>© 2026 ShopHub</p>
	</footer>
</body>
</html>
