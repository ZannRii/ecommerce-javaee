<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.User"%>

<%
List<User> users = (List<User>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Users</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin-users-view.css">

</head>
<body>

	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container">

		<jsp:include page="/admin/layout/sidebar.jsp" />

		<main class="content">

			<h1>Users</h1>

			<table class="table">

				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Email</th>
					<th>Role</th>
					<th>Created At</th>
				</tr>

				<%
				for (User u : users) {
				%>

				<tr>
					<td><%=u.getUserId()%></td>
					<td><%=u.getName()%></td>
					<td><%=u.getEmail()%></td>
					<td><span class="role <%=u.getRole()%>"> <%=u.getRole()%>
					</span></td>
					<td><%=u.getCreatedAt()%></td>
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