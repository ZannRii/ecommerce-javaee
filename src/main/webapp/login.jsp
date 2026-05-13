<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/style.css">
</head>
<body>

	<header class="top-nav">
		<div class="logo">🛒 ShopHub</div>
	</header>
	<div class="container">
		<h2>Login</h2>

		<form action="user" method="post">
			<input type="hidden" name="action" value="login"> <input
				type="email" name="email" placeholder="Email" required> <input
				type="password" name="password" placeholder="Password" required>

			<button type="submit">Login</button>
		</form>

		<a href="register.jsp">Create Account</a>

		<div class="error">${error}</div>
	</div>
	<footer>
		<p>© 2026 ShopHub</p>
	</footer>
</body>
</html>