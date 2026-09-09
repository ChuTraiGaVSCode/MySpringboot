<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Sửa người dùng</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
	<h2 class="mb-3">Sửa người dùng</h2>
	<c:if test="${not empty alert}">
		<div class="alert alert-danger">${alert}</div>
	</c:if>
	<form action="${pageContext.request.contextPath}/admin/users/edit/${user.id}" method="post" enctype="multipart/form-data">
		<div class="mb-3">
			<label class="form-label">Tên đăng nhập</label>
			<input type="text" class="form-control" value="${user.username}" disabled>
		</div>
		<div class="mb-3">
			<label class="form-label">Đặt mật khẩu mới (để trống nếu không đổi)</label>
			<input type="password" class="form-control" name="newPassword" minlength="6">
		</div>
		<div class="mb-3">
			<label class="form-label">Họ và tên</label>
			<input type="text" class="form-control" name="fullname" value="${user.fullname}">
		</div>
		<div class="mb-3">
			<label class="form-label">Email</label>
			<input type="email" class="form-control" name="email" value="${user.email}" required>
		</div>
		<div class="mb-3">
			<label class="form-label">Số điện thoại</label>
			<input type="text" class="form-control" name="phone" value="${user.phone}" pattern="0\d{9,10}">
		</div>
		<div class="mb-3">
			<label class="form-label">Vai trò</label>
			<select class="form-select" name="roleid">
				<option value="1" ${user.roleid == 1 ? 'selected' : ''}>User</option>
				<option value="2" ${user.roleid == 2 ? 'selected' : ''}>Admin</option>
				<option value="3" ${user.roleid == 3 ? 'selected' : ''}>Manager</option>
			</select>
		</div>
		<div class="mb-3">
			<label class="form-label">Kích hoạt</label>
			<select class="form-select" name="active">
				<option value="1" ${user.active == 1 ? 'selected' : ''}>Đã kích hoạt</option>
				<option value="0" ${user.active != 1 ? 'selected' : ''}>Chưa kích hoạt</option>
			</select>
		</div>
		<div class="mb-3">
			<label class="form-label">Ảnh đại diện hiện tại</label><br>
			<c:if test="${not empty user.images}">
				<img height="100" src="${pageContext.request.contextPath}/image/${user.images}"><br>
			</c:if>
			<input type="file" class="form-control mt-2" name="imageFile" accept="image/*">
		</div>
		<button type="submit" class="btn btn-primary">Cập nhật</button>
		<a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Hủy</a>
	</form>
</div>
</body>
</html>
