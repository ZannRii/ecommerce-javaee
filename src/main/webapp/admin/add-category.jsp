<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Category</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/add-category.css">

</head>
<body>

	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container">

		<jsp:include page="/admin/layout/sidebar.jsp" />

		<main class="content">

			<h1>Add Category</h1>

			<form action="add-category" method="post" class="form-box">

				<label>Category Name</label> <input type="text" name="name" required>
				<label>Description</label> <input type="text" name="description" required>

				<button type="submit">Add Category</button>

			</form>

		</main>

	</div>

	<jsp:include page="/admin/layout/footer.jsp" />

</body>
</html>