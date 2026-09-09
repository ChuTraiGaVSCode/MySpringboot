package vn.iotstar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.ValidateUtil;

@Controller
public class RegisterController {

	private final IUserService userService;

	public RegisterController(IUserService userService) {
		this.userService = userService;
	}

	@GetMapping("/register")
	public String showRegisterForm() {
		return "register";
	}

	@PostMapping("/register")
	public String register(@RequestParam String username, @RequestParam String password,
			@RequestParam String confirmPassword, @RequestParam(required = false) String fullname,
			@RequestParam String email, @RequestParam(required = false) String phone, Model model) {

		
		model.addAttribute("username", username);
		model.addAttribute("fullname", fullname);
		model.addAttribute("email", email);
		model.addAttribute("phone", phone);

		String error = validate(username, password, confirmPassword, email, phone);
		if (error != null) {
			model.addAttribute("alert", error);
			return "register";
		}

		User user = new User();
		user.setUsername(username.trim());
		user.setPassword(password);
		user.setFullname(fullname);
		user.setEmail(email.trim());
		user.setPhone(phone);
		user.setImages("avata.png");

		try {
			userService.register(user);
			return "redirect:/verify-otp?username=" + username;
		} catch (Exception e) {
			model.addAttribute("alert", e.getMessage());
			return "register";
		}
	}

	private String validate(String username, String password, String confirmPassword, String email, String phone) {
		if (ValidateUtil.isBlank(username) || ValidateUtil.isBlank(password) || ValidateUtil.isBlank(email)) {
			return "Vui lòng nhập đầy đủ Tên đăng nhập, Mật khẩu và Email";
		}
		if (!ValidateUtil.isValidUsername(username)) {
			return "Tên đăng nhập phải có ít nhất 4 ký tự";
		}
		if (!ValidateUtil.isValidPassword(password)) {
			return "Mật khẩu phải có ít nhất 6 ký tự";
		}
		if (!password.equals(confirmPassword)) {
			return "Mật khẩu xác nhận không khớp";
		}
		if (!ValidateUtil.isValidEmail(email)) {
			return "Email không đúng định dạng";
		}
		if (!ValidateUtil.isValidPhone(phone)) {
			return "Số điện thoại không đúng định dạng (VD: 0912345678)";
		}
		return null;
	}
}
