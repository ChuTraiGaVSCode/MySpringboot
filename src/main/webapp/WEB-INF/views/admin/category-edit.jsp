<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<t:adminLayout title="Sửa danh mục" active="category">

	<div class="card" style="max-width: 560px;">
		<div class="card-body">
			<form action="${pageContext.request.contextPath}/admin/categories/edit/${category.categoryid}" method="post" enctype="multipart/form-data">
				<div class="mb-3">
					<label class="form-label">Tên danh mục</label>
					<input type="text" class="form-control" name="categoryname" value="${category.categoryname}" required minlength="2">
				</div>
				<div class="mb-3">
					<label class="form-label">Ảnh hiện tại</label><br>
					<img id="previewImg" height="100" class="rounded mb-2"
						<c:if test="${not empty category.images}">src="${pageContext.request.contextPath}/image/${category.images}"</c:if>
						<c:if test="${empty category.images}">style="display:none"</c:if>><br>
					<input type="file" class="form-control" name="imageFile" accept="image/*"
						onchange="if(this.files&&this.files[0]){document.getElementById('previewImg').src=URL.createObjectURL(this.files[0]);document.getElementById('previewImg').style.display='inline-block';}">
				</div>
				<div class="mb-3">
					<label class="form-label">Trạng thái</label>
					<select class="form-select" name="status">
						<option value="1" ${category.status == 1 ? 'selected' : ''}>Hoạt động</option>
						<option value="0" ${category.status != 1 ? 'selected' : ''}>Khóa</option>
					</select>
				</div>
				<button type="submit" class="btn btn-primary"><i class="bi bi-check-lg"></i> Cập nhật</button>
				<a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">Hủy</a>
			</form>
		</div>
	</div>

</t:adminLayout>
