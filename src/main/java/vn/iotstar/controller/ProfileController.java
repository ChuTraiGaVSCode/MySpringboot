package vn.iotstar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.Constant;
import vn.iotstar.util.FileUploadUtil;
import vn.iotstar.util.ValidateUtil;

@Controller
public class ProfileController {

	private final IUserService userService;
	private final FileUploadUtil fileUploadUtil;

	public ProfileController(IUserService userService, FileUploadUtil fileUploadUtil) {
		this.userService = userService;
		this.fileUploadUtil = fileUploadUtil;
	}

	@GetMapping("/profile")
	public String view(HttpServletRequest request, Model model) {
		User account = getLoggedInUser(request);
		if (account == null) {
			return "redirect:/login";
		}
		
		User user = userService.findByUsername(account.getUsername());
		model.addAttribute("user", user);
		return "profile";
	}

	@PostMapping("/profile")
	public String update(HttpServletRequest request, @RequestParam(required = false) String fullname,
			@RequestParam(required = false) String phone,
			@RequestParam(name = "imageFile", required = false) MultipartFile imageFile, Model model) {

		User account = getLoggedInUser(request);
		if (account == null) {
			return "redirect:/login";
		}

		if (!ValidateUtil.isValidPhone(phone)) {
			model.addAttribute("alert", "Số điện thoại không đúng định dạng (VD: 0912345678)");
			model.addAttribute("user", account);
			return "profile";
		}

		try {
			String images = fileUploadUtil.save(imageFile, account.getImages());
			User updated = userService.updateProfile(account.getId(), fullname, phone, images);

			
			request.getSession(true).setAttribute(Constant.SESSION_ACCOUNT, updated);

			model.addAttribute("notice", "Cập nhật hồ sơ thành công");
			model.addAttribute("user", updated);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("alert", "Cập nhật hồ sơ thất bại: " + e.getMessage());
			model.addAttribute("user", account);
		}

		return "profile";
	}

	private User getLoggedInUser(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session == null) {
			return null;
		}
		return (User) session.getAttribute(Constant.SESSION_ACCOUNT);
	}
}
