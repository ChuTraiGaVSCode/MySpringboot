package vn.iotstar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.iotstar.entity.Category;

public interface CategoryRepository extends JpaRepository<Category, Integer> {

	List<Category> findByCategorynameContainingIgnoreCase(String keyword);

	boolean existsByCategorynameIgnoreCase(String categoryname);

	boolean existsByCategorynameIgnoreCaseAndCategoryidNot(String categoryname, int categoryid);
}
