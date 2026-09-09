<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<t:adminLayout title="Quản lý sản phẩm" active="product">

	<div class="d-flex justify-content-between align-items-center mb-3">
		<form class="d-flex" method="get" action="${pageContext.request.contextPath}/admin/products">
			<input type="text" class="form-control me-2" name="keyword" value="${keyword}" placeholder="Tìm theo tên sản phẩm...">
			<button type="submit" class="btn btn-outline-primary"><i class="bi bi-search"></i> Tìm kiếm</button>
		</form>
		<a class="btn btn-success text-nowrap ms-3" href="${pageContext.request.contextPath}/admin/products/add">
			<i class="bi bi-plus-lg"></i> Thêm sản phẩm
		</a>
	</div>

	<div class="card">
		<div class="card-body p-0">
			<table class="table table-hover align-middle mb-0">
				<thead>
					<tr>
						<th class="ps-3">STT</th>
						<th>Ảnh</th>
						<th>Tên sản phẩm</th>
						<th>Danh mục</th>
						<th>Giá</th>
						<th>Số lượng</th>
						<th>Trạng thái</th>
						<th class="text-end pe-3">Hành động</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listproduct}" var="p" varStatus="STT">
						<tr>
							<td class="ps-3">${STT.index + 1}</td>
							<td>
								<c:if test="${not empty p.images}">
									<img height="50" class="rounded" src="${pageContext.request.contextPath}/image/${p.images}">
								</c:if>
							</td>
							<td>${p.productname}</td>
							<td>${p.category.categoryname}</td>
							<td><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ" /></td>
							<td>${p.quantity}</td>
							<td>
								<c:if test="${p.status == 1}"><span class="badge bg-success">Hoạt động</span></c:if>
								<c:if test="${p.status != 1}"><span class="badge bg-secondary">Khóa</span></c:if>
							</td>
							<td class="text-end pe-3">
								<a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/admin/products/edit/${p.productid}">
									<i class="bi bi-pencil"></i> Sửa
								</a>
								<a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/products/delete/${p.productid}"
									onclick="return confirm('Xóa sản phẩm này?')">
									<i class="bi bi-trash"></i> Xóa
								</a>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty listproduct}">
						<tr><td colspan="8" class="text-center text-muted py-4">Không có sản phẩm nào</td></tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>

	<nav class="mt-3">
		<ul class="pagination">
			<c:forEach begin="1" end="${totalPages}" var="i">
				<li class="page-item ${i == currentPage ? 'active' : ''}">
					<a class="page-link"
						href="${pageContext.request.contextPath}/admin/products?page=${i}${not empty keyword ? '&keyword='.concat(keyword) : ''}">${i}</a>
				</li>
			</c:forEach>
		</ul>
	</nav>

</t:adminLayout>
