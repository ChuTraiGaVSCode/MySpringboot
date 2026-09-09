<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<t:adminLayout title="Quản lý danh mục" active="category">

	<div class="d-flex justify-content-between align-items-center mb-3">
		<form class="d-flex" method="get" action="${pageContext.request.contextPath}/admin/categories">
			<input type="text" class="form-control me-2" name="keyword" value="${keyword}" placeholder="Tìm theo tên danh mục...">
			<button type="submit" class="btn btn-outline-primary"><i class="bi bi-search"></i> Tìm kiếm</button>
		</form>
		<a class="btn btn-success text-nowrap ms-3" href="${pageContext.request.contextPath}/admin/categories/add">
			<i class="bi bi-plus-lg"></i> Thêm danh mục
		</a>
	</div>

	<div class="card">
		<div class="card-body p-0">
			<table class="table table-hover align-middle mb-0">
				<thead>
					<tr>
						<th class="ps-3">STT</th>
						<th>Ảnh</th>
						<th>Tên danh mục</th>
						<th>Trạng thái</th>
						<th class="text-end pe-3">Hành động</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listcate}" var="cate" varStatus="STT">
						<tr>
							<td class="ps-3">${STT.index + 1}</td>
							<td>
								<c:if test="${not empty cate.images}">
									<img height="50" class="rounded" src="${pageContext.request.contextPath}/image/${cate.images}">
								</c:if>
							</td>
							<td>${cate.categoryname}</td>
							<td>
								<c:if test="${cate.status == 1}"><span class="badge bg-success">Hoạt động</span></c:if>
								<c:if test="${cate.status != 1}"><span class="badge bg-secondary">Khóa</span></c:if>
							</td>
							<td class="text-end pe-3">
								<a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/admin/categories/edit/${cate.categoryid}">
									<i class="bi bi-pencil"></i> Sửa
								</a>
								<a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/categories/delete/${cate.categoryid}"
									onclick="return confirm('Xóa danh mục này?')">
									<i class="bi bi-trash"></i> Xóa
								</a>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty listcate}">
						<tr><td colspan="5" class="text-center text-muted py-4">Không có danh mục nào</td></tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>

</t:adminLayout>
