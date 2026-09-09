package vn.iotstar.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.util.Constant;

@Component
public class AdminInterceptor implements HandlerInterceptor {

	private static final int ADMIN_ROLE_ID = 2;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession(false);
		Object accountObj = (session != null) ? session.getAttribute(Constant.SESSION_ACCOUNT) : null;

		if (accountObj == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return false;
		}

		User account = (User) accountObj;
		if (account.getRoleid() != ADMIN_ROLE_ID) {
			response.sendRedirect(request.getContextPath() + "/home");
			return false;
		}

		return true;
	}
}
