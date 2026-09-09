package vn.iotstar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.iotstar.service.IUserService;
import vn.iotstar.util.ValidateUtil;

@Controller
public class VerifyOtpController {

	private final IUserService userService;

	public VerifyOtpController(IUserService userService) {
		this.userService = userService;
	}

	@GetMapping("/verify-otp")
	public String showForm(@RequestParam String username, Model model) {
		model.addAttribute("username", username);
		return "verify-otp";
	}

	@GetMapping("/resend-otp")
	public String resend(@RequestParam String username, Model model) {
		boolean ok = userService.resendActiveOtp(username);
		model.addAttribute("username", username);
		if (ok) {
			model.addAttribute("notice", "Đã gửi lại mã OTP mới vào email của bạn");
		} else {
			model.addAttribute("alert", "Không thể gửi lại OTP");
		}
		return "verify-otp";
	}

	@PostMapping("/verify-otp")
	public String verify(@RequestParam String username, @RequestParam String otp, Model model) {
		if (!ValidateUtil.isValidOtp(otp)) {
			model.addAttribute("username", username);
			model.addAttribute("alert", "Mã OTP phải gồm đúng 6 chữ số");
			return "verify-otp";
		}

		boolean ok = userService.verifyActiveOtp(username, otp);
		if (ok) {
			return "redirect:/login";
		}
		model.addAttribute("username", username);
		model.addAttribute("alert", "Mã OTP không đúng hoặc đã hết hạn");
		return "verify-otp";
	}
}
