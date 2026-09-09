package vn.iotstar.service;

import java.util.List;

import vn.iotstar.entity.Category;

public interface ICategoryService {

	List<Category> findAll();

	List<Category> search(String keyword);

	Category findById(int id);

	boolean existsByName(String categoryname);

	boolean existsByNameExcludeId(String categoryname, int categoryid);

	void save(Category category);

	void delete(int id);
}
