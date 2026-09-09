<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<t:adminLayout title="Thêm sản phẩm" active="product">

	<div class="card" style="max-width: 700px;">
		<div class="card-body">
			<form action="${pageContext.request.contextPath}/admin/products/add" method="post" enctype="multipart/form-data">
				<div class="mb-3">
					<label class="form-label">Tên sản phẩm</label>
					<input type="text" class="form-control" name="productname" required>
				</div>
				<div class="mb-3">
					<label class="form-label">Danh mục</label>
					<select class="form-select" name="categoryid" required>
						<c:forEach items="${listcate}" var="c">
							<option value="${c.categoryid}">${c.categoryname}</option>
						</c:forEach>
					</select>
				</div>
				<div class="row">
					<div class="col-md-6 mb-3">
						<label class="form-label">Giá</label>
						<input type="number" step="0.01" min="0" class="form-control" name="price" required>
					</div>
					<div class="col-md-6 mb-3">
						<label class="form-label">Số lượng</label>
						<input type="number" min="0" class="form-control" name="quantity" required>
					</div>
				</div>
				<div class="mb-3">
					<label class="form-label">Mô tả</label>
					<textarea class="form-control" name="description" rows="4"></textarea>
				</div>
				<div class="mb-3">
					<label class="form-label">Ảnh</label>
					<img id="previewImg" height="100" class="rounded mb-2 d-block" style="display:none"><br>
					<input type="file" class="form-control" name="imageFile" accept="image/*"
						onchange="if(this.files&&this.files[0]){document.getElementById('previewImg').src=URL.createObjectURL(this.files[0]);document.getElementById('previewImg').style.display='block';}">
				</div>
				<div class="mb-3">
					<label class="form-label">Trạng thái</label>
					<select class="form-select" name="status">
						<option value="1">Hoạt động</option>
						<option value="0">Khóa</option>
					</select>
				</div>
				<button type="submit" class="btn btn-primary"><i class="bi bi-check-lg"></i> Lưu</button>
				<a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Hủy</a>
			</form>
		</div>
	</div>

</t:adminLayout>
