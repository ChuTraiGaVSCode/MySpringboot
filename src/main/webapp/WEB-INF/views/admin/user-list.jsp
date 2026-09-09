<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Quản lý người dùng</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
	<h2 class="mb-3">Quản lý người dùng (Spring Boot)</h2>

	<c:if test="${not empty notice}">
		<div class="alert alert-success">${notice}</div>
	</c:if>
	<c:if test="${not empty alert}">
		<div class="alert alert-danger">${alert}</div>
	</c:if>

	<div class="d-flex justify-content-between mb-3">
		<form class="d-flex" method="get" action="${pageContext.request.contextPath}/admin/users">
			<input type="text" class="form-control me-2" name="keyword" value="${keyword}"
				placeholder="Tìm theo username / email / họ tên...">
			<button type="submit" class="btn btn-outline-primary">Tìm kiếm</button>
		</form>
		<a class="btn btn-success" href="${pageContext.request.contextPath}/admin/users/add">+ Thêm người dùng</a>
	</div>

	<table class="table table-bordered bg-white">
		<tr>
			<th>STT</th>
			<th>Ảnh</th>
			<th>Username</th>
			<th>Họ tên</th>
			<th>Email</th>
			<th>SĐT</th>
			<th>Vai trò</th>
			<th>Kích hoạt</th>
			<th>Hành động</th>
		</tr>
		<c:forEach items="${listuser}" var="u" varStatus="STT">
			<tr>
				<td>${STT.index + 1}</td>
				<td>
					<c:if test="${not empty u.images}">
						<img height="50" src="${pageContext.request.contextPath}/image/${u.images}">
					</c:if>
				</td>
				<td>${u.username}</td>
				<td>${u.fullname}</td>
				<td>${u.email}</td>
				<td>${u.phone}</td>
				<td>
					<c:if test="${u.roleid == 2}">Admin</c:if>
					<c:if test="${u.roleid == 3}">Manager</c:if>
					<c:if test="${u.roleid != 2 && u.roleid != 3}">User</c:if>
				</td>
				<td>
					<c:if test="${u.active == 1}"><span class="badge bg-success">Đã kích hoạt</span></c:if>
					<c:if test="${u.active != 1}"><span class="badge bg-secondary">Chưa kích hoạt</span></c:if>
				</td>
				<td>
					<a href="${pageContext.request.contextPath}/admin/users/edit/${u.id}">Sửa</a>
					|
					<a href="${pageContext.request.contextPath}/admin/users/delete/${u.id}"
						onclick="return confirm('Xóa người dùng này?')">Xóa</a>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${empty listuser}">
			<tr><td colspan="9" class="text-center">Không có người dùng nào</td></tr>
		</c:if>
	</table>
</div>
</body>
</html>
