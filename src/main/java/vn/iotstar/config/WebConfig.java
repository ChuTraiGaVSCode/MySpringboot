package vn.iotstar.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	@Value("${app.upload.dir}")
	private String uploadDir;

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// Truy cap anh da upload qua URL: /image/<ten-file>
		String location = uploadDir.endsWith("/") ? uploadDir : uploadDir + "/";
		registry.addResourceHandler("/image/**").addResourceLocations("file:" + location);
	}
}
