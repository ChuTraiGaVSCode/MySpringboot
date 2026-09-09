package vn.iotstar.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import vn.iotstar.entity.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	Optional<User> findByUsername(String username);

	Optional<User> findByEmail(String email);

	@Query("SELECT u FROM User u WHERE lower(u.username) LIKE lower(concat('%', :kw, '%')) "
			+ "OR lower(u.email) LIKE lower(concat('%', :kw, '%')) "
			+ "OR lower(u.fullname) LIKE lower(concat('%', :kw, '%'))")
	List<User> search(@Param("kw") String keyword);
}
