<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<aside class="col-lg-3 col-xl-2">
	<div class="card border-0 shadow-sm">
	<div class="card-body p-3">
	<ul class="list-unstyled mb-0">
		<li><a class="btn btn-light w-100 text-start fw-semibold mb-2" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-grid me-2 text-success"></i>Dashboard</a></li>

		<li>
			<a class="btn btn-light w-100 text-start fw-semibold mb-2" data-bs-toggle="collapse" href="#products" role="button" aria-expanded="false" aria-controls="products"><i class="bi bi-box-seam me-2 text-success"></i>Products <span class="float-end">v</span></a>
			<ul id="products" class="collapse list-unstyled ms-3 mb-2">
				<li><a class="d-block py-1 text-secondary" href="${pageContext.request.contextPath}/admin/view-product">View Products</a></li>
				<li><a class="d-block py-1 text-secondary" href="${pageContext.request.contextPath}/admin/add-product">Add Product</a></li>
			</ul>
		</li>

		<li>
			<a class="btn btn-light w-100 text-start fw-semibold mb-2" data-bs-toggle="collapse" href="#categories" role="button" aria-expanded="false" aria-controls="categories"><i class="bi bi-tags me-2 text-success"></i>Categories <span class="float-end">v</span></a>
			<ul id="categories" class="collapse list-unstyled ms-3 mb-2">
				<li><a class="d-block py-1 text-secondary" href="${pageContext.request.contextPath}/admin/view-category">View Categories</a></li>
				<li><a class="d-block py-1 text-secondary" href="${pageContext.request.contextPath}/admin/add-category">Add Category</a></li>
			</ul>
		</li>

		<li>
			<a class="btn btn-light w-100 text-start fw-semibold mb-2" data-bs-toggle="collapse" href="#orders" role="button" aria-expanded="false" aria-controls="orders"><i class="bi bi-receipt me-2 text-success"></i>Orders <span class="float-end">v</span></a>
			<ul id="orders" class="collapse list-unstyled ms-3 mb-2">
				<li><a class="d-block py-1 text-secondary" href="${pageContext.request.contextPath}/admin/orders">View Orders</a></li>
			</ul>
		</li>

		<li>
			<a class="btn btn-light w-100 text-start fw-semibold mb-2" data-bs-toggle="collapse" href="#users" role="button" aria-expanded="false" aria-controls="users"><i class="bi bi-people me-2 text-success"></i>Users <span class="float-end">v</span></a>
			<ul id="users" class="collapse list-unstyled ms-3 mb-2">
				<li><a class="d-block py-1 text-secondary" href="${pageContext.request.contextPath}/admin/view-users">View Users</a></li>
			</ul>
		</li>

		<li><a class="btn btn-outline-danger w-100 text-start fw-semibold mt-2" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
	</ul>
	</div>
	</div>
</aside>
