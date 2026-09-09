package vn.iotstar.service;

import java.util.List;

import org.springframework.data.domain.Page;

import vn.iotstar.entity.Product;

public interface IProductService {

	List<Product> findAll();

	Page<Product> findPage(String keyword, int page, int size);

	List<Product> findLatest();

	Product findById(int id);

	void save(Product product);

	void delete(int id);
}
