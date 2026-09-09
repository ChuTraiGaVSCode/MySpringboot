package vn.iotstar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.iotstar.service.IProductService;

@Controller
public class HomeController {

	private final IProductService productService;

	public HomeController(IProductService productService) {
		this.productService = productService;
	}

	@GetMapping("/")
	public String root() {
		return "redirect:/home";
	}

	@GetMapping("/home")
	public String home(Model model) {
		model.addAttribute("latestProducts", productService.findLatest());
		return "home";
	}
}
