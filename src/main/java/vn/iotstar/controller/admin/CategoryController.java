package vn.iotstar.controller.admin;

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

import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.util.FileUploadUtil;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

	private final ICategoryService categoryService;
	private final FileUploadUtil fileUploadUtil;

	public CategoryController(ICategoryService categoryService, FileUploadUtil fileUploadUtil) {
		this.categoryService = categoryService;
		this.fileUploadUtil = fileUploadUtil;
	}

	
	@GetMapping
	public String list(@RequestParam(name = "keyword", required = false) String keyword, Model model) {
		List<Category> listcate = categoryService.search(keyword);
		model.addAttribute("listcate", listcate);
		model.addAttribute("keyword", keyword);
		return "admin/category-list";
	}

	@GetMapping("/add")
	public String showAddForm(Model model) {
		if (!model.containsAttribute("category")) {
			model.addAttribute("category", new Category());
		}
		return "admin/category-add";
	}

	@PostMapping("/add")
	public String add(@ModelAttribute Category category,
			@RequestParam(name = "imageFile", required = false) MultipartFile imageFile,
			RedirectAttributes redirectAttributes) {

		if (category.getCategoryname() == null || category.getCategoryname().trim().isEmpty()) {
			redirectAttributes.addFlashAttribute("alert", "Tên danh mục không được để trống");
			redirectAttributes.addFlashAttribute("category", category);
			return "redirect:/admin/categories/add";
		}
		if (categoryService.existsByName(category.getCategoryname().trim())) {
			redirectAttributes.addFlashAttribute("alert", "Tên danh mục đã tồn tại");
			redirectAttributes.addFlashAttribute("category", category);
			return "redirect:/admin/categories/add";
		}

		category.setImages(fileUploadUtil.save(imageFile, null));
		categoryService.save(category);
		redirectAttributes.addFlashAttribute("notice", "Thêm danh mục thành công");
		return "redirect:/admin/categories";
	}

	@GetMapping("/edit/{id}")
	public String showEditForm(@PathVariable int id, Model model) {
		if (!model.containsAttribute("category")) {
			Category category = categoryService.findById(id);
			if (category == null) {
				return "redirect:/admin/categories";
			}
			model.addAttribute("category", category);
		}
		return "admin/category-edit";
	}

	@PostMapping("/edit/{id}")
	public String update(@PathVariable int id, @ModelAttribute Category category,
			@RequestParam(name = "imageFile", required = false) MultipartFile imageFile,
			RedirectAttributes redirectAttributes) {

		Category old = categoryService.findById(id);
		if (old == null) {
			return "redirect:/admin/categories";
		}
		if (category.getCategoryname() == null || category.getCategoryname().trim().isEmpty()) {
			redirectAttributes.addFlashAttribute("alert", "Tên danh mục không được để trống");
			redirectAttributes.addFlashAttribute("category", category);
			return "redirect:/admin/categories/edit/" + id;
		}
		if (categoryService.existsByNameExcludeId(category.getCategoryname().trim(), id)) {
			redirectAttributes.addFlashAttribute("alert", "Tên danh mục đã tồn tại");
			redirectAttributes.addFlashAttribute("category", category);
			return "redirect:/admin/categories/edit/" + id;
		}

		category.setCategoryid(id);
		category.setImages(fileUploadUtil.save(imageFile, old.getImages()));
		categoryService.save(category);
		redirectAttributes.addFlashAttribute("notice", "Cập nhật danh mục thành công");
		return "redirect:/admin/categories";
	}

	@GetMapping("/delete/{id}")
	public String delete(@PathVariable int id, RedirectAttributes redirectAttributes) {
		categoryService.delete(id);
		redirectAttributes.addFlashAttribute("notice", "Đã xóa danh mục");
		return "redirect:/admin/categories";
	}
}
