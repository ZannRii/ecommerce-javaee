<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.Category"%>

<%
List<Category> categories = (List<Category>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Categories</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container-fluid py-4">
		<div class="row g-4">

		<jsp:include page="/admin/layout/sidebar.jsp" />

		<main class="col-lg-9 col-xl-10">

			<div class="d-flex justify-content-between align-items-center mb-4">
				<h1 class="fw-bold mb-0">Categories</h1>
				<a class="btn btn-success" href="${pageContext.request.contextPath}/admin/add-category"><i class="bi bi-plus-lg me-1"></i>Add Category</a>
			</div>

			<div class="card border-0 shadow-sm">
			<div class="table-responsive">
			<table class="table align-middle mb-0">
				<thead class="table-light">

				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Description</th>
					<th>Actions</th>
				</tr>
				</thead>
				<tbody>

				<%
				for (Category c : categories) {
				%>

				<tr>
					<td><%=c.getCategoryId()%></td>
					<td><%=c.getName()%></td>
					<td><%=c.getDescription()%></td>

					<td><a class="btn btn-sm btn-outline-success"
						href="edit-category?id=<%=c.getCategoryId()%>"> Edit </a>

						<form action="delete-category" method="post"
							class="d-inline">

							<input type="hidden" name="id" value="<%=c.getCategoryId()%>">

							<button class="btn btn-sm btn-outline-danger"
								onclick="return confirm('Delete category?')">Delete</button>

						</form></td>
				</tr>

				<%
				}
				%>

				</tbody>
			</table>
			</div>
			</div>

		</main>

		</div>
	</div>

	<jsp:include page="/admin/layout/footer.jsp" />
</body>
</html>
