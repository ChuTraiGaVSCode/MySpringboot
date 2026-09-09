<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Đăng nhập</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="_nav.jsp" />
<div class="container mt-2 mb-5">
	<div class="row justify-content-center">
		<div class="col-md-4">
			<div class="card">
				<div class="card-header">Đăng nhập</div>
				<div class="card-body">
					<c:if test="${not empty alert}">
						<div class="alert alert-danger">${alert}</div>
					</c:if>
					<form action="${pageContext.request.contextPath}/login" method="post">
						<div class="mb-3">
							<label class="form-label">Tên đăng nhập</label>
							<input type="text" class="form-control" name="username" required>
						</div>
						<div class="mb-3">
							<label class="form-label">Mật khẩu</label>
							<input type="password" class="form-control" name="password" required minlength="6">
						</div>
						<div class="mb-3 form-check">
							<input type="checkbox" class="form-check-input" name="remember" checked>
							<label class="form-check-label">Ghi nhớ đăng nhập</label>
						</div>
						<button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
					</form>
					<p class="mt-3 mb-0">
						<a href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu?</a>
						&nbsp;|&nbsp;
						<a href="${pageContext.request.contextPath}/register">Chưa có tài khoản? Đăng ký</a>
					</p>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
