package vn.iotstar.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import vn.iotstar.interceptor.AdminInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	@Value("${app.upload.dir}")
	private String uploadDir;

	private final AdminInterceptor adminInterceptor;

	public WebConfig(AdminInterceptor adminInterceptor) {
		this.adminInterceptor = adminInterceptor;
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {

		String location = uploadDir.endsWith("/") ? uploadDir : uploadDir + "/";
		registry.addResourceHandler("/image/**").addResourceLocations("file:" + location);
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(adminInterceptor).addPathPatterns("/admin/**");
	}
}
