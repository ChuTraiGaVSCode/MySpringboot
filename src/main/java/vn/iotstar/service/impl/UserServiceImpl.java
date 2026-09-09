package vn.iotstar.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.iotstar.entity.User;
import vn.iotstar.repository.UserRepository;
import vn.iotstar.service.IUserService;

@Service
public class UserServiceImpl implements IUserService {

	private final UserRepository userRepository;

	public UserServiceImpl(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@Override
	public List<User> findAll() {
		return userRepository.findAll();
	}

	@Override
	public List<User> search(String keyword) {
		if (keyword == null || keyword.trim().isEmpty()) {
			return findAll();
		}
		return userRepository.search(keyword.trim());
	}

	@Override
	public User findById(int id) {
		return userRepository.findById(id).orElse(null);
	}

	@Override
	public User findByUsername(String username) {
		return userRepository.findByUsername(username).orElse(null);
	}

	@Override
	public boolean existsByUsername(String username) {
		return userRepository.findByUsername(username).isPresent();
	}

	@Override
	public boolean existsByEmail(String email) {
		return userRepository.findByEmail(email).isPresent();
	}

	@Override
	public void save(User user) {
		userRepository.save(user);
	}

	@Override
	public void delete(int id) {
		userRepository.deleteById(id);
	}
}
