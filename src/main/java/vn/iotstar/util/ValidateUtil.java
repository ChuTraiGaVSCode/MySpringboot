package vn.iotstar.util;

import java.util.regex.Pattern;

public class ValidateUtil {

	private static final Pattern EMAIL_PATTERN = Pattern.compile("^[\\w.+-]+@[\\w-]+\\.[a-zA-Z]{2,}$");

	private static final Pattern PHONE_PATTERN = Pattern.compile("^0\\d{9,10}$");

	private static final Pattern OTP_PATTERN = Pattern.compile("^\\d{" + Constant.OTP_LENGTH + "}$");

	public static boolean isBlank(String s) {
		return s == null || s.trim().isEmpty();
	}

	public static boolean isValidEmail(String email) {
		return email != null && EMAIL_PATTERN.matcher(email.trim()).matches();
	}

	public static boolean isValidPhone(String phone) {
		if (isBlank(phone)) {
			return true;
		}
		return PHONE_PATTERN.matcher(phone.trim()).matches();
	}

	public static boolean isValidOtp(String otp) {
		return otp != null && OTP_PATTERN.matcher(otp.trim()).matches();
	}

	public static boolean isValidUsername(String username) {
		return username != null && username.trim().length() >= 4;
	}

	public static boolean isValidPassword(String password) {
		return password != null && password.length() >= 6;
	}
}
