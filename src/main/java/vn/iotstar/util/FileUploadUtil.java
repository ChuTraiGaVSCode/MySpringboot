package vn.iotstar.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileUploadUtil {

	@Value("${app.upload.dir}")
	private String uploadDir;

	public static final String DEFAULT_IMAGE = "avata.png";

	public String save(MultipartFile file, String oldFileName) {
		if (file == null || file.isEmpty()) {
			return oldFileName != null ? oldFileName : DEFAULT_IMAGE;
		}
		try {
			File dir = new File(uploadDir);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			String original = Paths.get(file.getOriginalFilename()).getFileName().toString();
			String ext = original.contains(".") ? original.substring(original.lastIndexOf(".")) : "";
			String newFileName = System.currentTimeMillis() + ext;
			file.transferTo(new File(uploadDir, newFileName));
			return newFileName;
		} catch (IOException e) {
			e.printStackTrace();
			return oldFileName != null ? oldFileName : DEFAULT_IMAGE;
		}
	}
}
