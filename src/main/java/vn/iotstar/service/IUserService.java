package vn.iotstar.service;

import java.util.List;

import vn.iotstar.entity.User;

public interface IUserService {

	List<User> findAll();

	List<User> search(String keyword);

	User findById(int id);

	User findByUsername(String username);

	boolean existsByUsername(String username);

	boolean existsByEmail(String email);

	void save(User user);

	void delete(int id);
}
