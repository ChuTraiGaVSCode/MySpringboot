package vn.iotstar.controller.admin;

import java.sql.Timestamp;
import java.time.Instant;

import org.springframework.data.domain.Page;
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
import vn.iotstar.entity.Product;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;
import vn.iotstar.util.Constant;
import vn.iotstar.util.FileUploadUtil;

@Controller
@RequestMapping("/admin/products")
public class ProductController {

	private final IProductService productService;
	private final ICategoryService categoryService;
	private final FileUploadUtil fileUploadUtil;

	public ProductController(IProductService productService, ICategoryService categoryService,
			FileUploadUtil fileUploadUtil) {
		this.productService = productService;
		this.categoryService = categoryService;
		this.fileUploadUtil = fileUploadUtil;
	}

	@GetMapping
	public String list(@RequestParam(name = "keyword", required = false) String keyword,
			@RequestParam(name = "page", defaultValue = "1") int page, Model model) {
		if (page < 1) {
			page = 1;
		}
		Page<Product> pageResult = productService.findPage(keyword, page - 1, Constant.PRODUCT_PAGE_SIZE);
		model.addAttribute("listproduct", pageResult.getContent());
		model.addAttribute("keyword", keyword);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", Math.max(pageResult.getTotalPages(), 1));
		return "admin/product-list";
	}

	@GetMapping("/add")
	public String showAddForm(Model model) {
		if (!model.containsAttribute("product")) {
			model.addAttribute("product", new Product());
		}
		model.addAttribute("listcate", categoryService.findAll());
		return "admin/product-add";
	}

	@PostMapping("/add")
	public String add(@ModelAttribute Product product, @RequestParam(name = "categoryid") int categoryid,
			@RequestParam(name = "imageFile", required = false) MultipartFile imageFile,
			RedirectAttributes redirectAttributes) {

		String error = validate(product);
		if (error != null) {
			redirectAttributes.addFlashAttribute("alert", error);
			redirectAttributes.addFlashAttribute("product", product);
			return "redirect:/admin/products/add";
		}

		Category category = categoryService.findById(categoryid);
		product.setCategory(category);
		product.setCreateDate(Timestamp.from(Instant.now()));
		product.setImages(fileUploadUtil.save(imageFile, null));

		productService.save(product);
		redirectAttributes.addFlashAttribute("notice", "Thêm sản phẩm thành công");
		return "redirect:/admin/products";
	}

	@GetMapping("/edit/{id}")
	public String showEditForm(@PathVariable int id, Model model) {
		
		if (!model.containsAttribute("product")) {
			Product product = productService.findById(id);
			if (product == null) {
				return "redirect:/admin/products";
			}
			model.addAttribute("product", product);
		}
		model.addAttribute("listcate", categoryService.findAll());
		return "admin/product-edit";
	}

	@PostMapping("/edit/{id}")
	public String update(@PathVariable int id, @ModelAttribute Product product,
			@RequestParam(name = "categoryid") int categoryid,
			@RequestParam(name = "imageFile", required = false) MultipartFile imageFile,
			RedirectAttributes redirectAttributes) {

		Product old = productService.findById(id);
		if (old == null) {
			return "redirect:/admin/products";
		}

		String error = validate(product);
		if (error != null) {
			redirectAttributes.addFlashAttribute("alert", error);
			redirectAttributes.addFlashAttribute("product", product);
			return "redirect:/admin/products/edit/" + id;
		}

		Category category = categoryService.findById(categoryid);

		product.setProductid(id);
		product.setCategory(category);
		product.setCreateDate(old.getCreateDate());
		product.setImages(fileUploadUtil.save(imageFile, old.getImages()));

		productService.save(product);
		redirectAttributes.addFlashAttribute("notice", "Cập nhật sản phẩm thành công");
		return "redirect:/admin/products";
	}

	@GetMapping("/delete/{id}")
	public String delete(@PathVariable int id, RedirectAttributes redirectAttributes) {
		productService.delete(id);
		redirectAttributes.addFlashAttribute("notice", "Đã xóa sản phẩm");
		return "redirect:/admin/products";
	}

	private String validate(Product product) {
		if (product.getProductname() == null || product.getProductname().trim().isEmpty()) {
			return "Tên sản phẩm không được để trống";
		}
		if (product.getPrice() < 0) {
			return "Giá sản phẩm không được âm";
		}
		if (product.getQuantity() < 0) {
			return "Số lượng không được âm";
		}
		return null;
	}
}
