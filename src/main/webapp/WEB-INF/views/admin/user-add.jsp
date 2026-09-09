<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Thêm người dùng</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
	<h2 class="mb-3">Thêm người dùng</h2>
	<c:if test="${not empty alert}">
		<div class="alert alert-danger">${alert}</div>
	</c:if>
	<form action="${pageContext.request.contextPath}/admin/users/add" method="post" enctype="multipart/form-data">
		<div class="mb-3">
			<label class="form-label">Tên đăng nhập</label>
			<input type="text" class="form-control" name="username" required minlength="4">
		</div>
		<div class="mb-3">
			<label class="form-label">Mật khẩu</label>
			<input type="password" class="form-control" name="password" required minlength="6">
		</div>
		<div class="mb-3">
			<label class="form-label">Họ và tên</label>
			<input type="text" class="form-control" name="fullname">
		</div>
		<div class="mb-3">
			<label class="form-label">Email</label>
			<input type="email" class="form-control" name="email" required>
		</div>
		<div class="mb-3">
			<label class="form-label">Số điện thoại</label>
			<input type="text" class="form-control" name="phone" pattern="0\d{9,10}">
		</div>
		<div class="mb-3">
			<label class="form-label">Vai trò</label>
			<select class="form-select" name="roleid">
				<option value="1">User</option>
				<option value="2">Admin</option>
				<option value="3">Manager</option>
			</select>
		</div>
		<div class="mb-3">
			<label class="form-label">Ảnh đại diện</label>
			<input type="file" class="form-control" name="imageFile" accept="image/*">
		</div>
		<button type="submit" class="btn btn-primary">Lưu</button>
		<a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Hủy</a>
	</form>
</div>
</body>
</html>
