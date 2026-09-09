<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Sửa danh mục</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="_nav.jsp" />
<div class="container mt-4">
	<h2 class="mb-3">Sửa danh mục</h2>
	<c:if test="${not empty alert}">
		<div class="alert alert-danger">${alert}</div>
	</c:if>
	<form action="${pageContext.request.contextPath}/admin/categories/edit/${category.categoryid}" method="post" enctype="multipart/form-data">
		<div class="mb-3">
			<label class="form-label">Tên danh mục</label>
			<input type="text" class="form-control" name="categoryname" value="${category.categoryname}" required minlength="2">
		</div>
		<div class="mb-3">
			<label class="form-label">Ảnh hiện tại</label><br>
			<c:if test="${not empty category.images}">
				<img height="100" src="${pageContext.request.contextPath}/image/${category.images}"><br>
			</c:if>
			<input type="file" class="form-control mt-2" name="imageFile" accept="image/*">
		</div>
		<div class="mb-3">
			<label class="form-label">Trạng thái</label>
			<select class="form-select" name="status">
				<option value="1" ${category.status == 1 ? 'selected' : ''}>Hoạt động</option>
				<option value="0" ${category.status != 1 ? 'selected' : ''}>Khóa</option>
			</select>
		</div>
		<button type="submit" class="btn btn-primary">Cập nhật</button>
		<a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">Hủy</a>
	</form>
</div>
</body>
</html>
