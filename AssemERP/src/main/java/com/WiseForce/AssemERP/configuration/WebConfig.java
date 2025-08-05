package com.WiseForce.AssemERP.configuration;

import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	@Value("${com.WiseForce.AssemERP.upload.path}")
	private String uploadPath;

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		String fullPath = Paths.get(uploadPath).toAbsolutePath().toUri().toString();
		registry.addResourceHandler("/upload/**")
				.addResourceLocations(fullPath);
	}
}