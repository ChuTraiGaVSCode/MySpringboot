package vn.iotstar.service.impl;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;

import org.springframework.stereotype.Service;

import vn.iotstar.entity.User;
import vn.iotstar.repository.UserRepository;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.MailUtil;
import vn.iotstar.util.OtpUtil;

@Service
public class UserServiceImpl implements IUserService {

	private final UserRepository userRepository;
	private final MailUtil mailUtil;

	public UserServiceImpl(UserRepository userRepository, MailUtil mailUtil) {
		this.userRepository = userRepository;
		this.mailUtil = mailUtil;
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

	@Override
	public User login(String username, String password) {
		User user = findByUsername(username);
		if (user != null && user.getPassword().equals(password) && user.getActive() == 1) {
			return user;
		}
		return null;
	}

	@Override
	public User findByEmail(String email) {
		return userRepository.findByEmail(email).orElse(null);
	}

	@Override
	public User register(User user) throws Exception {
		if (existsByUsername(user.getUsername())) {
			throw new Exception("Tên đăng nhập đã tồn tại");
		}
		if (existsByEmail(user.getEmail())) {
			throw new Exception("Email đã được sử dụng");
		}

		user.setActive(0);
		user.setRoleid(1);
		user.setCreateDate(Timestamp.from(Instant.now()));

		String otp = OtpUtil.generateOtp();
		user.setOtp(otp);
		user.setOtpExpiry(OtpUtil.generateExpiry());

		userRepository.save(user);

		mailUtil.sendOtpActiveAccount(user.getEmail(), otp);

		return user;
	}

	@Override
	public boolean verifyActiveOtp(String username, String otp) {
		User user = findByUsername(username);
		if (user == null || user.getActive() == 1) {
			return false;
		}
		if (user.getOtp() == null || !user.getOtp().equals(otp)) {
			return false;
		}
		if (OtpUtil.isExpired(user.getOtpExpiry())) {
			return false;
		}

		user.setActive(1);
		user.setOtp(null);
		user.setOtpExpiry(null);
		userRepository.save(user);
		return true;
	}

	@Override
	public boolean resendActiveOtp(String username) {
		User user = findByUsername(username);
		if (user == null || user.getActive() == 1) {
			return false;
		}
		String otp = OtpUtil.generateOtp();
		user.setOtp(otp);
		user.setOtpExpiry(OtpUtil.generateExpiry());
		userRepository.save(user);
		return mailUtil.sendOtpActiveAccount(user.getEmail(), otp);
	}

	@Override
	public boolean forgotPassword(String email) {
		User user = findByEmail(email);
		if (user == null) {
			return false;
		}
		String otp = OtpUtil.generateOtp();
		user.setOtp(otp);
		user.setOtpExpiry(OtpUtil.generateExpiry());
		userRepository.save(user);
		return mailUtil.sendOtpForgotPassword(email, otp);
	}

	@Override
	public boolean resetPassword(String email, String otp, String newPassword) {
		User user = findByEmail(email);
		if (user == null) {
			return false;
		}
		if (user.getOtp() == null || !user.getOtp().equals(otp)) {
			return false;
		}
		if (OtpUtil.isExpired(user.getOtpExpiry())) {
			return false;
		}

		user.setPassword(newPassword);
		user.setOtp(null);
		user.setOtpExpiry(null);
		userRepository.save(user);
		return true;
	}

	@Override
	public User updateProfile(int id, String fullname, String phone, String images) throws Exception {
		User user = findById(id);
		if (user == null) {
			throw new Exception("Người dùng không tồn tại");
		}

		if (fullname != null) {
			user.setFullname(fullname.trim());
		}
		if (phone != null) {
			user.setPhone(phone.trim());
		}
		if (images != null && !images.trim().isEmpty()) {
			user.setImages(images);
		}

		userRepository.save(user);
		return user;
	}
}
