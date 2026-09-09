<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Quản lý danh mục</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="_nav.jsp" />
<div class="container mt-4">
	<h2 class="mb-3">Quản lý danh mục (Spring Boot)</h2>

	<c:if test="${not empty notice}">
		<div class="alert alert-success">${notice}</div>
	</c:if>
	<c:if test="${not empty alert}">
		<div class="alert alert-danger">${alert}</div>
	</c:if>

	<div class="d-flex justify-content-between mb-3">
		<form class="d-flex" method="get" action="${pageContext.request.contextPath}/admin/categories">
			<input type="text" class="form-control me-2" name="keyword" value="${keyword}" placeholder="Tìm theo tên danh mục...">
			<button type="submit" class="btn btn-outline-primary">Tìm kiếm</button>
		</form>
		<a class="btn btn-success" href="${pageContext.request.contextPath}/admin/categories/add">+ Thêm danh mục</a>
	</div>

	<table class="table table-bordered bg-white">
		<tr>
			<th>STT</th>
			<th>Ảnh</th>
			<th>Tên danh mục</th>
			<th>Trạng thái</th>
			<th>Hành động</th>
		</tr>
		<c:forEach items="${listcate}" var="cate" varStatus="STT">
			<tr>
				<td>${STT.index + 1}</td>
				<td>
					<c:if test="${not empty cate.images}">
						<img height="60" src="${pageContext.request.contextPath}/image/${cate.images}">
					</c:if>
				</td>
				<td>${cate.categoryname}</td>
				<td>
					<c:if test="${cate.status == 1}"><span class="badge bg-success">Hoạt động</span></c:if>
					<c:if test="${cate.status != 1}"><span class="badge bg-secondary">Khóa</span></c:if>
				</td>
				<td>
					<a href="${pageContext.request.contextPath}/admin/categories/edit/${cate.categoryid}">Sửa</a>
					|
					<a href="${pageContext.request.contextPath}/admin/categories/delete/${cate.categoryid}"
						onclick="return confirm('Xóa danh mục này?')">Xóa</a>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${empty listcate}">
			<tr><td colspan="5" class="text-center">Không có danh mục nào</td></tr>
		</c:if>
	</table>
</div>
</body>
</html>
