<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
	<div class="container">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/home">Springboot1 Shop</a>
		<div class="navbar-nav me-auto">
			<a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
			<a class="nav-link" href="${pageContext.request.contextPath}/product">Sản phẩm</a>
		</div>
		<div class="navbar-nav">
			<c:choose>
				<c:when test="${not empty sessionScope.account}">
					<a class="nav-link" href="${pageContext.request.contextPath}/profile">
						Xin chào, ${sessionScope.account.fullname != null && sessionScope.account.fullname != '' ? sessionScope.account.fullname : sessionScope.account.username}
					</a>
					<c:if test="${sessionScope.account.roleid == 2}">
						<a class="nav-link" href="${pageContext.request.contextPath}/admin/products">Trang quản trị</a>
					</c:if>
					<a class="nav-link" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
				</c:when>
				<c:otherwise>
					<a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
					<a class="nav-link" href="${pageContext.request.contextPath}/register">Đăng ký</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</nav>
