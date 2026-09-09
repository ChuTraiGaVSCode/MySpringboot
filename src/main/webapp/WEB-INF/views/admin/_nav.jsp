<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand navbar-dark bg-dark mb-4">
	<div class="container">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/admin/products">Admin</a>
		<div class="navbar-nav me-auto">
			<a class="nav-link" href="${pageContext.request.contextPath}/admin/products">Sản phẩm</a>
			<a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">Danh mục</a>
			<a class="nav-link" href="${pageContext.request.contextPath}/admin/users">Người dùng</a>
		</div>
		<div class="navbar-nav">
			<a class="nav-link" href="${pageContext.request.contextPath}/home">Về trang chủ</a>
			<a class="nav-link" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
		</div>
	</div>
</nav>
