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

	User login(String username, String password);

	User findByEmail(String email);

	User register(User user) throws Exception;

	boolean verifyActiveOtp(String username, String otp);

	boolean resendActiveOtp(String username);

	boolean forgotPassword(String email);

	boolean resetPassword(String email, String otp, String newPassword);

	User updateProfile(int id, String fullname, String phone, String images) throws Exception;
}
