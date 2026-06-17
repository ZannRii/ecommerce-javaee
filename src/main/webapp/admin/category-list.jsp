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
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/category-list.css">
</head>
<body>
	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container">

		<jsp:include page="/admin/layout/sidebar.jsp" />

		<main class="content">

			<h1>Categories</h1>

			<table class="table">

				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Description</th>
					<th>Actions</th>
				</tr>

				<%
				for (Category c : categories) {
				%>

				<tr>
					<td><%=c.getCategoryId()%></td>
					<td><%=c.getName()%></td>
					<td><%=c.getDescription()%></td>

					<td><a class="btn edit"
						href="edit-category?id=<%=c.getCategoryId()%>"> Edit </a>

						<form action="delete-category" method="post"
							style="display: inline">

							<input type="hidden" name="id" value="<%=c.getCategoryId()%>">

							<button class="btn delete"
								onclick="return confirm('Delete category?')">Delete</button>

						</form></td>
				</tr>

				<%
				}
				%>

			</table>

		</main>

	</div>

	<jsp:include page="/admin/layout/footer.jsp" />
</body>
</html>