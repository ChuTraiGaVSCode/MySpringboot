<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="_nav.jsp" />
<div class="container mt-2 mb-5">
	<h2 class="mb-4">Sản phẩm mới nhất</h2>

	<c:if test="${empty latestProducts}">
		<p>Chưa có sản phẩm nào.</p>
	</c:if>

	<div class="row row-cols-1 row-cols-md-4 g-4">
		<c:forEach items="${latestProducts}" var="p">
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

	<p class="mt-4">
		<a href="${pageContext.request.contextPath}/product">Xem tất cả sản phẩm &raquo;</a>
	</p>
</div>
</body>
</html>
