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

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

</head>
<body class="bg-light">

	<jsp:include page="/admin/layout/header.jsp" />

	<div class="container-fluid py-4">
		<div class="row g-4">

		<jsp:include page="/admin/layout/sidebar.jsp" />

		<main class="col-lg-9 col-xl-10">

			<h1 class="fw-bold mb-4">Users</h1>

			<div class="card border-0 shadow-sm">
			<div class="table-responsive">
			<table class="table align-middle mb-0">
				<thead class="table-light">

				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Email</th>
					<th>Role</th>
					<th>Created At</th>
				</tr>
				</thead>
				<tbody>

				<%
				for (User u : users) {
				%>

				<tr>
					<td><%=u.getUserId()%></td>
					<td><%=u.getName()%></td>
					<td><%=u.getEmail()%></td>
					<td><span class="badge text-bg-success"> <%=u.getRole()%>
					</span></td>
					<td><%=u.getCreatedAt()%></td>
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
