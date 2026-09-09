package vn.iotstar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.iotstar.entity.Category;

public interface CategoryRepository extends JpaRepository<Category, Integer> {

	// Spring Data JPA tu sinh cau lenh SQL dua tren ten method (query method)
	List<Category> findByCategorynameContainingIgnoreCase(String keyword);

	// Kiem tra trung ten danh muc (khi them moi)
	boolean existsByCategorynameIgnoreCase(String categoryname);

	// Kiem tra trung ten danh muc, loai tru chinh no (khi cap nhat)
	boolean existsByCategorynameIgnoreCaseAndCategoryidNot(String categoryname, int categoryid);
}
