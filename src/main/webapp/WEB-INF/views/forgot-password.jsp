<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Quên mật khẩu</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="_nav.jsp" />
<div class="container mt-2 mb-5">
	<div class="row justify-content-center">
		<div class="col-md-4">
			<div class="card">
				<div class="card-header">Quên mật khẩu</div>
				<div class="card-body">
					<p>Nhập email đã đăng ký, hệ thống sẽ gửi mã OTP để bạn đặt lại mật khẩu.</p>
					<c:if test="${not empty alert}">
						<div class="alert alert-danger">${alert}</div>
					</c:if>
					<form action="${pageContext.request.contextPath}/forgot-password" method="post">
						<div class="mb-3">
							<label class="form-label">Email</label>
							<input type="email" class="form-control" name="email" required>
						</div>
						<button type="submit" class="btn btn-primary w-100">Gửi mã OTP</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
