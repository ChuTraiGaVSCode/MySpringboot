package vn.iotstar.controller;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.iotstar.entity.Product;
import vn.iotstar.service.IProductService;
import vn.iotstar.util.Constant;

@Controller("adminProductController")
@RequestMapping("/product")
public class ProductController {

	private final IProductService productService;

	public ProductController(IProductService productService) {
		this.productService = productService;
	}

	
	@GetMapping
	public String list(@RequestParam(name = "page", defaultValue = "1") int page, Model model) {
		if (page < 1) {
			page = 1;
		}
		Page<Product> pageResult = productService.findPage(null, page - 1, Constant.PRODUCT_PAGE_SIZE);
		int totalPages = Math.max(pageResult.getTotalPages(), 1);
		if (page > totalPages) {
			page = totalPages;
			pageResult = productService.findPage(null, page - 1, Constant.PRODUCT_PAGE_SIZE);
		}

		model.addAttribute("listproduct", pageResult.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		return "product-list";
	}

	@GetMapping("/detail")
	public String detail(@RequestParam(name = "id") int id, Model model) {
		Product product = productService.findById(id);
		model.addAttribute("product", product);
		return "product-detail";
	}
}
