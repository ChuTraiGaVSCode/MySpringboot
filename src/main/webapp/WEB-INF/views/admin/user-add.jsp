<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<t:adminLayout title="Thêm người dùng" active="user">

	<div class="card" style="max-width: 620px;">
		<div class="card-body">
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
				<button type="submit" class="btn btn-primary"><i class="bi bi-check-lg"></i> Lưu</button>
				<a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Hủy</a>
			</form>
		</div>
	</div>

</t:adminLayout>
