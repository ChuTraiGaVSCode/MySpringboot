<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<t:adminLayout title="Quản lý người dùng" active="user">

	<div class="d-flex justify-content-between align-items-center mb-3">
		<form class="d-flex" method="get" action="${pageContext.request.contextPath}/admin/users">
			<input type="text" class="form-control me-2" name="keyword" value="${keyword}"
				placeholder="Tìm theo username / email / họ tên...">
			<button type="submit" class="btn btn-outline-primary"><i class="bi bi-search"></i> Tìm kiếm</button>
		</form>
		<a class="btn btn-success text-nowrap ms-3" href="${pageContext.request.contextPath}/admin/users/add">
			<i class="bi bi-plus-lg"></i> Thêm người dùng
		</a>
	</div>

	<div class="card">
		<div class="card-body p-0">
			<table class="table table-hover align-middle mb-0">
				<thead>
					<tr>
						<th class="ps-3">STT</th>
						<th>Ảnh</th>
						<th>Username</th>
						<th>Họ tên</th>
						<th>Email</th>
						<th>SĐT</th>
						<th>Vai trò</th>
						<th>Kích hoạt</th>
						<th class="text-end pe-3">Hành động</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listuser}" var="u" varStatus="STT">
						<tr>
							<td class="ps-3">${STT.index + 1}</td>
							<td>
								<c:if test="${not empty u.images}">
									<img height="45" class="rounded-circle" src="${pageContext.request.contextPath}/image/${u.images}">
								</c:if>
							</td>
							<td>${u.username}</td>
							<td>${u.fullname}</td>
							<td>${u.email}</td>
							<td>${u.phone}</td>
							<td>
								<c:if test="${u.roleid == 2}"><span class="badge bg-primary">Admin</span></c:if>
								<c:if test="${u.roleid == 3}"><span class="badge bg-info text-dark">Manager</span></c:if>
								<c:if test="${u.roleid != 2 && u.roleid != 3}"><span class="badge bg-light text-dark border">User</span></c:if>
							</td>
							<td>
								<c:if test="${u.active == 1}"><span class="badge bg-success">Đã kích hoạt</span></c:if>
								<c:if test="${u.active != 1}"><span class="badge bg-secondary">Chưa kích hoạt</span></c:if>
							</td>
							<td class="text-end pe-3">
								<a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/admin/users/edit/${u.id}">
									<i class="bi bi-pencil"></i> Sửa
								</a>
								<a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/users/delete/${u.id}"
									onclick="return confirm('Xóa người dùng này?')">
									<i class="bi bi-trash"></i> Xóa
								</a>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty listuser}">
						<tr><td colspan="9" class="text-center text-muted py-4">Không có người dùng nào</td></tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>

</t:adminLayout>
