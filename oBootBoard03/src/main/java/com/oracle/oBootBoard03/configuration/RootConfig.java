package com.oracle.oBootBoard03.configuration;

import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class RootConfig implements WebMvcConfigurer{
	
    @Bean
	public ModelMapper getMapper() {
		ModelMapper modelMapper = new ModelMapper();
		modelMapper.getConfiguration()
		 		   .setFieldMatchingEnabled(true)	
		 		   .setFieldAccessLevel(org.modelmapper.config.Configuration.AccessLevel.PRIVATE)
		 		   .setMatchingStrategy(MatchingStrategies.LOOSE);
		
		return modelMapper;
	}
    @Value("${com.oracle.oBootBoard03.upload.path}")
    private String uploadPath;
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
    	registry.addResourceHandler("/upload/**")
        .addResourceLocations("file:///" + uploadPath + "/");
    }
    

}
