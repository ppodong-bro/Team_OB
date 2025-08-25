package com.WiseForce.AssemERP.configuration;

import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration 
public class WebConfig implements WebMvcConfigurer 
{
	
    @Value("${file.upload-dir}")
    private String profileUploadDir;

    @Value("${com.WiseForce.AssemERP.upload.path}")
    private String generalUploadDir;

    @Bean
    public MultipartResolver multipartResolver() {
        return new StandardServletMultipartResolver();
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) 
    {
        if (profileUploadDir != null && !profileUploadDir.isBlank()) {
            registry.addResourceHandler("/profile-images/**")
                    .addResourceLocations(toFileUri(profileUploadDir));
        }

        if (generalUploadDir != null && !generalUploadDir.isBlank()) {
            registry.addResourceHandler("/upload/**")
                    .addResourceLocations(toFileUri(generalUploadDir));
        }
    }

    private String toFileUri(String path) {
        String uri = Paths.get(path).toAbsolutePath().toUri().toString();
        return uri.endsWith("/") ? uri : uri + "/";
    }
}
