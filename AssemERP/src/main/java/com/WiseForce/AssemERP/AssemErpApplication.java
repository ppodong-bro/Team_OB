package com.WiseForce.AssemERP;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan(basePackages = {"com.WiseForce.AssemERP.mapper", 
							"com.WiseForce.AssemERP.account.mapper"} )
public class AssemErpApplication 
{
	public static void main(String[] args) { 
		SpringApplication.run(AssemErpApplication.class, args);
	} 
}
