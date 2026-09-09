<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Tất cả sản phẩm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="_nav.jsp" />
<div class="container mt-2 mb-5">
	<h2 class="mb-4">Tất cả sản phẩm</h2>

	<c:if test="${empty listproduct}">
		<p>Chưa có sản phẩm nào.</p>
	</c:if>

	<div class="row row-cols-1 row-cols-md-4 g-4">
		<c:forEach items="${listproduct}" var="p">
			<div class="col">
				<div class="card h-100">
					<a href="${pageContext.request.contextPath}/product/detail?id=${p.productid}">
						<c:choose>
							<c:when test="${empty p.images}">
								<img class="card-img-top" src="" alt="${p.productname}" style="height:180px;object-fit:cover;background:#eee">
							</c:when>
							<c:otherwise>
								<img class="card-img-top" src="${pageContext.request.contextPath}/image/${p.images}"
									alt="${p.productname}" style="height:180px;object-fit:cover">
							</c:otherwise>
						</c:choose>
					</a>
					<div class="card-body">
						<a class="text-decoration-none" href="${pageContext.request.contextPath}/product/detail?id=${p.productid}">
							<h6 class="card-title">${p.productname}</h6>
						</a>
						<p class="card-text text-danger fw-bold">
							<fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ" />
						</p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>

	<nav class="mt-4">
		<ul class="pagination">
			<c:forEach begin="1" end="${totalPages}" var="i">
				<li class="page-item ${i == currentPage ? 'active' : ''}">
					<a class="page-link" href="${pageContext.request.contextPath}/product?page=${i}">${i}</a>
				</li>
			</c:forEach>
		</ul>
	</nav>
</div>
</body>
</html>
