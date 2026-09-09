package vn.iotstar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.iotstar.service.IUserService;
import vn.iotstar.util.ValidateUtil;

@Controller
public class ResetPasswordController {

	private final IUserService userService;

	public ResetPasswordController(IUserService userService) {
		this.userService = userService;
	}

	@GetMapping("/reset-password")
	public String showForm(@RequestParam(required = false) String email, Model model) {
		model.addAttribute("email", email);
		return "reset-password";
	}

	@PostMapping("/reset-password")
	public String submit(@RequestParam String email, @RequestParam String otp, @RequestParam String newPassword,
			@RequestParam String confirmPassword, Model model) {

		if (!ValidateUtil.isValidOtp(otp)) {
			model.addAttribute("email", email);
			model.addAttribute("alert", "Mã OTP phải gồm đúng 6 chữ số");
			return "reset-password";
		}
		if (!ValidateUtil.isValidPassword(newPassword)) {
			model.addAttribute("email", email);
			model.addAttribute("alert", "Mật khẩu mới phải có ít nhất 6 ký tự");
			return "reset-password";
		}
		if (newPassword == null || !newPassword.equals(confirmPassword)) {
			model.addAttribute("email", email);
			model.addAttribute("alert", "Mật khẩu xác nhận không khớp");
			return "reset-password";
		}

		boolean ok = userService.resetPassword(email, otp, newPassword);
		if (ok) {
			return "redirect:/login";
		}
		model.addAttribute("email", email);
		model.addAttribute("alert", "Mã OTP không đúng hoặc đã hết hạn");
		return "reset-password";
	}
}
