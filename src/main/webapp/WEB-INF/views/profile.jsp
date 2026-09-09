<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Hồ sơ cá nhân</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="_nav.jsp" />
<div class="container mt-2 mb-5">
	<h2 class="mb-3">Hồ sơ cá nhân</h2>

	<c:if test="${not empty notice}">
		<div class="alert alert-success">${notice}</div>
	</c:if>
	<c:if test="${not empty alert}">
		<div class="alert alert-danger">${alert}</div>
	</c:if>

	<div class="card">
		<div class="card-header">Thông tin tài khoản</div>
		<div class="card-body">
			<form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
				<div class="mb-3">
					<label class="form-label">Tên đăng nhập</label>
					<input type="text" class="form-control" value="${user.username}" disabled>
				</div>
				<div class="mb-3">
					<label class="form-label">Email</label>
					<input type="text" class="form-control" value="${user.email}" disabled>
				</div>
				<div class="mb-3">
					<label class="form-label">Họ và tên</label>
					<input type="text" class="form-control" name="fullname" value="${user.fullname}" maxlength="200">
				</div>
				<div class="mb-3">
					<label class="form-label">Số điện thoại</label>
					<input type="text" class="form-control" name="phone" value="${user.phone}" maxlength="20"
						pattern="0\d{9,10}" placeholder="VD: 0912345678">
					<div class="form-text">Định dạng: bắt đầu bằng 0, 10-11 chữ số</div>
				</div>
				<div class="mb-3">
					<label class="form-label">Ảnh đại diện</label><br>
					<c:choose>
						<c:when test="${empty user.images}">
							<img alt="images" width="120" height="120" class="rounded-circle mb-2" style="object-fit:cover;background:#eee">
						</c:when>
						<c:otherwise>
							<img alt="images" src="${pageContext.request.contextPath}/image/${user.images}" width="120" height="120"
								class="rounded-circle mb-2" style="object-fit:cover">
						</c:otherwise>
					</c:choose>
					<br>
					<input type="file" name="imageFile" accept="image/*">
				</div>
				<button type="submit" class="btn btn-primary">
					<i class="fa fa-check"></i> Lưu thay đổi
				</button>
			</form>
		</div>
	</div>
</div>
</body>
</html>
