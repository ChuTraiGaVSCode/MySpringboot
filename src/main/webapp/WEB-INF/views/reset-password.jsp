<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Đặt lại mật khẩu</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="_nav.jsp" />
<div class="container mt-2 mb-5">
	<div class="row justify-content-center">
		<div class="col-md-4">
			<div class="card">
				<div class="card-header">Đặt lại mật khẩu</div>
				<div class="card-body">
					<c:if test="${not empty alert}">
						<div class="alert alert-danger">${alert}</div>
					</c:if>
					<form action="${pageContext.request.contextPath}/reset-password" method="post">
						<input type="hidden" name="email" value="${email}">
						<div class="mb-3">
							<label class="form-label">Mã OTP đã gửi tới email</label>
							<input type="text" class="form-control" name="otp" required pattern="\d{6}" maxlength="6" inputmode="numeric">
						</div>
						<div class="mb-3">
							<label class="form-label">Mật khẩu mới</label>
							<input type="password" class="form-control" name="newPassword" id="newPassword" required minlength="6">
						</div>
						<div class="mb-3">
							<label class="form-label">Xác nhận mật khẩu mới</label>
							<input type="password" class="form-control" name="confirmPassword" id="confirmPassword2" required minlength="6">
						</div>
						<button type="submit" class="btn btn-primary w-100">Đặt lại mật khẩu</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	(function () {
		var newPassword = document.getElementById('newPassword');
		var confirmPassword = document.getElementById('confirmPassword2');
		function checkMatch() {
			if (newPassword.value !== confirmPassword.value) {
				confirmPassword.setCustomValidity('Mật khẩu xác nhận không khớp');
			} else {
				confirmPassword.setCustomValidity('');
			}
		}
		newPassword.addEventListener('input', checkMatch);
		confirmPassword.addEventListener('input', checkMatch);
	})();
</script>
</body>
</html>
