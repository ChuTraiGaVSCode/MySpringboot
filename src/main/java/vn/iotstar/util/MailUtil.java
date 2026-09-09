package vn.iotstar.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import jakarta.mail.internet.MimeMessage;

@Component
public class MailUtil {

	private final JavaMailSender mailSender;

	@Value("${spring.mail.username}")
	private String fromEmail;

	private static final String FROM_NAME = "Springboot1 Shop";

	public MailUtil(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	public boolean sendMail(String toEmail, String subject, String content) {
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(fromEmail, FROM_NAME);
			helper.setTo(toEmail);
			helper.setSubject(subject);
			helper.setText(content, true);
			mailSender.send(message);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean sendOtpActiveAccount(String toEmail, String otp) {
		String subject = "Mã OTP kích hoạt tài khoản";
		String content = "<p>Xin chào,</p>"
				+ "<p>Mã OTP để kích hoạt tài khoản của bạn là: <b style=\"font-size:20px\">" + otp + "</b></p>"
				+ "<p>Mã có hiệu lực trong " + Constant.OTP_EXPIRE_MINUTES + " phút.</p>"
				+ "<p>Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email.</p>";
		return sendMail(toEmail, subject, content);
	}

	public boolean sendOtpForgotPassword(String toEmail, String otp) {
		String subject = "Mã OTP đặt lại mật khẩu";
		String content = "<p>Xin chào,</p>"
				+ "<p>Mã OTP để đặt lại mật khẩu của bạn là: <b style=\"font-size:20px\">" + otp + "</b></p>"
				+ "<p>Mã có hiệu lực trong " + Constant.OTP_EXPIRE_MINUTES + " phút.</p>"
				+ "<p>Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email.</p>";
		return sendMail(toEmail, subject, content);
	}
}
