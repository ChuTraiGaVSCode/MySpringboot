<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Đăng ký tài khoản</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="_nav.jsp" />
<div class="container mt-2 mb-5">
	<div class="row justify-content-center">
		<div class="col-md-6">
			<div class="card">
				<div class="card-header">Đăng ký tài khoản</div>
				<div class="card-body">
					<c:if test="${not empty alert}">
						<div class="alert alert-danger">${alert}</div>
					</c:if>
					<form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
						<div class="mb-3">
							<label class="form-label">Tên đăng nhập</label>
							<input type="text" class="form-control" name="username" value="${username}" required minlength="4">
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label class="form-label">Mật khẩu</label>
								<input type="password" class="form-control" name="password" id="password" required minlength="6">
							</div>
							<div class="col-md-6 mb-3">
								<label class="form-label">Xác nhận mật khẩu</label>
								<input type="password" class="form-control" name="confirmPassword" id="confirmPassword" required minlength="6">
							</div>
						</div>
						<div class="mb-3">
							<label class="form-label">Họ và tên</label>
							<input type="text" class="form-control" name="fullname" value="${fullname}">
						</div>
						<div class="mb-3">
							<label class="form-label">Email (dùng để nhận mã OTP kích hoạt)</label>
							<input type="email" class="form-control" name="email" value="${email}" required>
						</div>
						<div class="mb-3">
							<label class="form-label">Số điện thoại</label>
							<input type="text" class="form-control" name="phone" value="${phone}" pattern="0\d{9,10}" placeholder="VD: 0912345678">
						</div>
						<button type="submit" class="btn btn-primary w-100">Đăng ký</button>
					</form>
					<p class="mt-3 mb-0"><a href="${pageContext.request.contextPath}/login">Đã có tài khoản? Đăng nhập</a></p>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	(function () {
		var password = document.getElementById('password');
		var confirmPassword = document.getElementById('confirmPassword');
		function checkMatch() {
			if (password.value !== confirmPassword.value) {
				confirmPassword.setCustomValidity('Mật khẩu xác nhận không khớp');
			} else {
				confirmPassword.setCustomValidity('');
			}
		}
		password.addEventListener('input', checkMatch);
		confirmPassword.addEventListener('input', checkMatch);
	})();
</script>
</body>
</html>
