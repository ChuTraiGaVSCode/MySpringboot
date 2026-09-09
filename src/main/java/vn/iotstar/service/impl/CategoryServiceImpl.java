package vn.iotstar.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.iotstar.entity.Category;
import vn.iotstar.repository.CategoryRepository;
import vn.iotstar.service.ICategoryService;

@Service
public class CategoryServiceImpl implements ICategoryService {

	private final CategoryRepository categoryRepository;

	// Spring tu dong tiem (dependency injection) CategoryRepository vao day
	public CategoryServiceImpl(CategoryRepository categoryRepository) {
		this.categoryRepository = categoryRepository;
	}

	@Override
	public List<Category> findAll() {
		return categoryRepository.findAll();
	}

	@Override
	public List<Category> search(String keyword) {
		if (keyword == null || keyword.trim().isEmpty()) {
			return findAll();
		}
		return categoryRepository.findByCategorynameContainingIgnoreCase(keyword.trim());
	}

	@Override
	public Category findById(int id) {
		return categoryRepository.findById(id).orElse(null);
	}

	@Override
	public boolean existsByName(String categoryname) {
		return categoryRepository.existsByCategorynameIgnoreCase(categoryname);
	}

	@Override
	public boolean existsByNameExcludeId(String categoryname, int categoryid) {
		return categoryRepository.existsByCategorynameIgnoreCaseAndCategoryidNot(categoryname, categoryid);
	}

	@Override
	public void save(Category category) {
		categoryRepository.save(category);
	}

	@Override
	public void delete(int id) {
		categoryRepository.deleteById(id);
	}
}
