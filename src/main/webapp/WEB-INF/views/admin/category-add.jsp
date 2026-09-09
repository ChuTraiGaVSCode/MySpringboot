<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<t:adminLayout title="Thêm danh mục" active="category">

	<div class="card" style="max-width: 560px;">
		<div class="card-body">
			<form action="${pageContext.request.contextPath}/admin/categories/add" method="post" enctype="multipart/form-data">
				<div class="mb-3">
					<label class="form-label">Tên danh mục</label>
					<input type="text" class="form-control" name="categoryname" required minlength="2">
				</div>
				<div class="mb-3">
					<label class="form-label">Ảnh</label>
					<input type="file" class="form-control" name="imageFile" accept="image/*">
				</div>
				<div class="mb-3">
					<label class="form-label">Trạng thái</label>
					<select class="form-select" name="status">
						<option value="1">Hoạt động</option>
						<option value="0">Khóa</option>
					</select>
				</div>
				<button type="submit" class="btn btn-primary"><i class="bi bi-check-lg"></i> Lưu</button>
				<a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">Hủy</a>
			</form>
		</div>
	</div>

</t:adminLayout>
