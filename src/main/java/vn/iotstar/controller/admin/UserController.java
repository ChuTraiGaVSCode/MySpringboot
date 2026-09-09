package vn.iotstar.controller.admin;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.FileUploadUtil;

@Controller
@RequestMapping("/admin/users")
public class UserController {

	private final IUserService userService;
	private final FileUploadUtil fileUploadUtil;

	public UserController(IUserService userService, FileUploadUtil fileUploadUtil) {
		this.userService = userService;
		this.fileUploadUtil = fileUploadUtil;
	}

	
	@GetMapping
	public String list(@RequestParam(name = "keyword", required = false) String keyword, Model model) {
		List<User> listuser = userService.search(keyword);
		model.addAttribute("listuser", listuser);
		model.addAttribute("keyword", keyword);
		return "admin/user-list";
	}

	@GetMapping("/add")
	public String showAddForm(Model model) {
		
		if (!model.containsAttribute("user")) {
			model.addAttribute("user", new User());
		}
		return "admin/user-add";
	}

	@PostMapping("/add")
	public String add(@ModelAttribute User user,
			@RequestParam(name = "imageFile", required = false) MultipartFile imageFile,
			RedirectAttributes redirectAttributes) {

		String error = validate(user, true);
		if (error != null) {
			redirectAttributes.addFlashAttribute("alert", error);
			redirectAttributes.addFlashAttribute("user", user);
			return "redirect:/admin/users/add";
		}

		user.setActive(1); 
		user.setCreateDate(Timestamp.from(Instant.now()));
		user.setImages(fileUploadUtil.save(imageFile, null));
		userService.save(user);
		redirectAttributes.addFlashAttribute("notice", "Thêm người dùng thành công");
		return "redirect:/admin/users";
	}

	@GetMapping("/edit/{id}")
	public String showEditForm(@PathVariable int id, Model model) {
		
		if (!model.containsAttribute("user")) {
			User user = userService.findById(id);
			if (user == null) {
				return "redirect:/admin/users";
			}
			model.addAttribute("user", user);
		}
		return "admin/user-edit";
	}

	@PostMapping("/edit/{id}")
	public String update(@PathVariable int id, @ModelAttribute User user,
			@RequestParam(name = "imageFile", required = false) MultipartFile imageFile,
			@RequestParam(name = "newPassword", required = false) String newPassword,
			RedirectAttributes redirectAttributes) {

		User old = userService.findById(id);
		if (old == null) {
			return "redirect:/admin/users";
		}

		String error = validate(user, false);
		if (error != null) {
			redirectAttributes.addFlashAttribute("alert", error);
			redirectAttributes.addFlashAttribute("user", user);
			return "redirect:/admin/users/edit/" + id;
		}

		user.setId(id);
		user.setUsername(old.getUsername()); 
		user.setPassword(newPassword != null && !newPassword.trim().isEmpty() ? newPassword : old.getPassword());
		user.setCreateDate(old.getCreateDate());
		user.setOtp(old.getOtp());
		user.setOtpExpiry(old.getOtpExpiry());
		user.setImages(fileUploadUtil.save(imageFile, old.getImages()));
		userService.save(user);
		redirectAttributes.addFlashAttribute("notice", "Cập nhật người dùng thành công");
		return "redirect:/admin/users";
	}

	@GetMapping("/delete/{id}")
	public String delete(@PathVariable int id, RedirectAttributes redirectAttributes) {
		userService.delete(id);
		redirectAttributes.addFlashAttribute("notice", "Đã xóa người dùng");
		return "redirect:/admin/users";
	}

	private String validate(User user, boolean isNew) {
		if (user.getUsername() == null || user.getUsername().trim().length() < 4) {
			return "Tên đăng nhập phải có ít nhất 4 ký tự";
		}
		if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
			return "Email không được để trống";
		}
		if (isNew) {
			if (user.getPassword() == null || user.getPassword().length() < 6) {
				return "Mật khẩu phải có ít nhất 6 ký tự";
			}
			if (userService.existsByUsername(user.getUsername())) {
				return "Tên đăng nhập đã tồn tại";
			}
			if (userService.existsByEmail(user.getEmail())) {
				return "Email đã được sử dụng";
			}
		}
		return null;
	}
}
