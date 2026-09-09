package vn.iotstar.service.impl;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import vn.iotstar.entity.Product;
import vn.iotstar.repository.ProductRepository;
import vn.iotstar.service.IProductService;

@Service
public class ProductServiceImpl implements IProductService {

	private final ProductRepository productRepository;

	public ProductServiceImpl(ProductRepository productRepository) {
		this.productRepository = productRepository;
	}

	@Override
	public List<Product> findAll() {
		return productRepository.findAll(Sort.by(Sort.Direction.DESC, "productid"));
	}

	@Override
	public Page<Product> findPage(String keyword, int page, int size) {
		PageRequest pageable = PageRequest.of(Math.max(page, 0), size, Sort.by(Sort.Direction.DESC, "productid"));
		if (keyword == null || keyword.trim().isEmpty()) {
			return productRepository.findAll(pageable);
		}
		return productRepository.findByProductnameContainingIgnoreCase(keyword.trim(), pageable);
	}

	@Override
	public List<Product> findLatest() {
		return productRepository.findTop10ByOrderByCreateDateDesc();
	}

	@Override
	public Product findById(int id) {
		return productRepository.findById(id).orElse(null);
	}

	@Override
	public void save(Product product) {
		productRepository.save(product);
	}

	@Override
	public void delete(int id) {
		productRepository.deleteById(id);
	}
}
