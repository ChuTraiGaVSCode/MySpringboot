<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Xác thực OTP</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="_nav.jsp" />
<div class="container mt-2 mb-5">
	<div class="row justify-content-center">
		<div class="col-md-4">
			<div class="card">
				<div class="card-header">Xác thực OTP kích hoạt tài khoản</div>
				<div class="card-body">
					<p>Một mã OTP đã được gửi tới email đăng ký của bạn. Vui lòng nhập mã bên dưới.</p>
					<c:if test="${not empty alert}">
						<div class="alert alert-danger">${alert}</div>
					</c:if>
					<c:if test="${not empty notice}">
						<div class="alert alert-success">${notice}</div>
					</c:if>
					<form action="${pageContext.request.contextPath}/verify-otp" method="post">
						<input type="hidden" name="username" value="${username}">
						<div class="mb-3">
							<label class="form-label">Mã OTP</label>
							<input type="text" class="form-control" name="otp" required pattern="\d{6}" maxlength="6"
								inputmode="numeric" placeholder="Nhập 6 chữ số">
						</div>
						<button type="submit" class="btn btn-primary w-100">Xác thực</button>
					</form>
					<p class="mt-3 mb-0">
						<a href="${pageContext.request.contextPath}/resend-otp?username=${username}">Gửi lại mã OTP</a>
					</p>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
