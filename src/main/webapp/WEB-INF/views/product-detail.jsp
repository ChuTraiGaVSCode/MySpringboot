<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Chi tiết sản phẩm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="_nav.jsp" />
<div class="container mt-2 mb-5">
	<c:if test="${empty product}">
		<p>Không tìm thấy sản phẩm.</p>
	</c:if>
	<c:if test="${not empty product}">
		<div class="card">
			<div class="card-body">
				<div class="row">
					<div class="col-md-4">
						<c:choose>
							<c:when test="${empty product.images}">
								<img src="" width="100%" alt="${product.productname}">
							</c:when>
							<c:otherwise>
								<img src="${pageContext.request.contextPath}/image/${product.images}" width="100%"
									alt="${product.productname}">
							</c:otherwise>
						</c:choose>
					</div>
					<div class="col-md-8">
						<h3>${product.productname}</h3>
						<p><b>Giá:</b> <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="đ" /></p>
						<p><b>Số lượng còn lại:</b> ${product.quantity}</p>
						<p><b>Danh mục:</b> ${product.category.categoryname}</p>
						<p><b>Mô tả:</b></p>
						<p>${product.description}</p>
					</div>
				</div>
			</div>
		</div>
	</c:if>
	<p class="mt-3"><a href="${pageContext.request.contextPath}/product">&laquo; Quay lại danh sách sản phẩm</a></p>
</div>
</body>
</html>
