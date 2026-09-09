package vn.iotstar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.iotstar.service.IUserService;
import vn.iotstar.util.ValidateUtil;

@Controller
public class ForgotPasswordController {

	private final IUserService userService;

	public ForgotPasswordController(IUserService userService) {
		this.userService = userService;
	}

	@GetMapping("/forgot-password")
	public String showForm() {
		return "forgot-password";
	}

	@PostMapping("/forgot-password")
	public String submit(@RequestParam String email, Model model) {
		if (email == null || email.trim().isEmpty()) {
			model.addAttribute("alert", "Vui lòng nhập email");
			return "forgot-password";
		}
		if (!ValidateUtil.isValidEmail(email)) {
			model.addAttribute("alert", "Email không đúng định dạng");
			return "forgot-password";
		}

		boolean ok = userService.forgotPassword(email.trim());
		if (ok) {
			return "redirect:/reset-password?email=" + email;
		}
		model.addAttribute("alert", "Email không tồn tại trong hệ thống");
		return "forgot-password";
	}
}
