<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="model.Category"%>

<%
Category category = (Category) request.getAttribute("category");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Category</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/add-category.css">

</head>
<body>

	<!-- HEADER -->
	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container">

		<!-- SIDEBAR -->
		<jsp:include page="/admin/layout/sidebar.jsp" />

		<!-- MAIN CONTENT -->
		<main class="content">

			<h1>Edit Category</h1>

			<form action="edit-category" method="post" class="form-box">

				<!-- Hidden ID -->
				<input type="hidden" name="id" value="<%=category.getCategoryId()%>">

				<!-- Category Name -->
				<label>Category Name</label> <input type="text" name="name"
					value="<%=category.getName()%>" required>
				<!-- Category Name -->
				<label>Description</label> <input type="text" name="description"
					value="<%=category.getDescription()%>" required>

				<button type="submit">Update Category</button>

			</form>

		</main>

	</div>

	<!-- FOOTER -->
	<jsp:include page="/admin/layout/footer.jsp" />

</body>
</html>