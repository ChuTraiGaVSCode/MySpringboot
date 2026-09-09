package vn.iotstar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.Constant;

@Controller
public class LoginController {

	private final IUserService userService;

	public LoginController(IUserService userService) {
		this.userService = userService;
	}

	@GetMapping("/login")
	public String showLoginForm() {
		return "login";
	}

	@PostMapping("/login")
	public String login(@RequestParam String username, @RequestParam String password,
			@RequestParam(name = "remember", required = false) String remember, HttpServletRequest request,
			HttpServletResponse response, Model model) {

		if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
			model.addAttribute("alert", "Tài khoản hoặc mật khẩu không được rỗng");
			return "login";
		}

		User existed = userService.findByUsername(username);
		if (existed != null && existed.getActive() == 0) {
			model.addAttribute("alert", "Tài khoản chưa được kích hoạt. Vui lòng xác thực OTP đã gửi qua email.");
			return "login";
		}

		User user = userService.login(username, password);
		if (user != null) {
			HttpSession session = request.getSession(true);
			session.setAttribute(Constant.SESSION_ACCOUNT, user);

			if ("on".equals(remember)) {
				Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, username);
				cookie.setMaxAge(30 * 60);
				response.addCookie(cookie);
			}

			if (user.getRoleid() == 2) {
				return "redirect:/admin/products";
			}
			return "redirect:/home";
		}

		model.addAttribute("alert", "Tài khoản hoặc mật khẩu không đúng");
		return "login";
	}
}
