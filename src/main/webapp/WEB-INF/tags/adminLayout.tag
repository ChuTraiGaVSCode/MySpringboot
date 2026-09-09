<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ attribute name="title" required="true" rtexprvalue="true" description="Tieu de hien thi tren tab trinh duyet va topbar" %>
<%@ attribute name="active" required="false" rtexprvalue="true" description="Muc dang chon tren sidebar: category | product | user" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title} - Trang quản trị</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
	:root { --sidebar-w: 235px; }
	body { background: #f3f5f9; }
	#sidebar {
		position: fixed; top: 0; left: 0; bottom: 0; width: var(--sidebar-w);
		background: #1c2b39; color: #fff; overflow-y: auto; z-index: 1030;
	}
	#sidebar .brand {
		padding: 1.1rem 1.2rem; font-size: 1.1rem; font-weight: 700;
		border-bottom: 1px solid rgba(255,255,255,.08); display: flex; align-items: center; gap: .5rem;
	}
	#sidebar nav { padding: .75rem 0; }
	#sidebar nav a {
		display: flex; align-items: center; gap: .65rem; color: #b9c4d0;
		padding: .65rem 1.2rem; text-decoration: none; font-size: .93rem;
		border-left: 3px solid transparent;
	}
	#sidebar nav a:hover { background: #24384a; color: #fff; }
	#sidebar nav a.active { background: #24384a; color: #fff; border-left-color: #4e8cff; font-weight: 600; }
	#sidebar hr { border-color: rgba(255,255,255,.08); margin: .6rem 1.2rem; }
	#main { margin-left: var(--sidebar-w); min-height: 100vh; }
	#topbar {
		background: #fff; border-bottom: 1px solid #e5e8ee; padding: .8rem 1.5rem;
		position: sticky; top: 0; z-index: 1020;
	}
	.card { border: none; box-shadow: 0 1px 3px rgba(0,0,0,.06); }
	table.table thead { background: #f8f9fb; }
	@media (max-width: 768px) {
		#sidebar { width: 100%; position: static; }
		#main { margin-left: 0; }
	}
</style>
</head>
<body>

	<div id="sidebar">
		<div class="brand"><i class="bi bi-boxes"></i> Springboot1 Admin</div>
		<nav>
			<a href="${pageContext.request.contextPath}/admin/products" class="${active == 'product' ? 'active' : ''}">
				<i class="bi bi-box-seam"></i> Sản phẩm
			</a>
			<a href="${pageContext.request.contextPath}/admin/categories" class="${active == 'category' ? 'active' : ''}">
				<i class="bi bi-tags"></i> Danh mục
			</a>
			<a href="${pageContext.request.contextPath}/admin/users" class="${active == 'user' ? 'active' : ''}">
				<i class="bi bi-people"></i> Người dùng
			</a>
			<hr>
			<a href="${pageContext.request.contextPath}/home"><i class="bi bi-house"></i> Về trang chủ</a>
			<a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
		</nav>
	</div>

	<div id="main">
		<div id="topbar" class="d-flex justify-content-between align-items-center">
			<h5 class="mb-0">${title}</h5>
			<span class="text-muted small">
				<i class="bi bi-person-circle"></i>
				Xin chào,
				<strong>
					${not empty sessionScope.account.fullname ? sessionScope.account.fullname : sessionScope.account.username}
				</strong>
			</span>
		</div>

		<div class="container-fluid p-4">
			<c:if test="${not empty notice}">
				<div class="alert alert-success alert-dismissible fade show" role="alert">
					<i class="bi bi-check-circle"></i> ${notice}
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
			</c:if>
			<c:if test="${not empty alert}">
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
					<i class="bi bi-exclamation-triangle"></i> ${alert}
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
			</c:if>

			<jsp:doBody />
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
