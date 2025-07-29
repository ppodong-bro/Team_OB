package com.WiseForce.AssemERP.domain.sh;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.SequenceGenerator;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
@SequenceGenerator(
					name = "product_seq_generator",
					sequenceName = "product_seq",
					initialValue = 1,
					allocationSize = 1
					)
public class Product {
	@Id
	@GeneratedValue(
					strategy = GenerationType.SEQUENCE,
					generator = "product_seq_generator"
					)
	private int			product_no;
	private int 		product_status;
	private String 		product_name;
	@Column(length = 1000)
	private String 		product_context;
	private String 		filename;
    private int 		del_status;
    private int			emp_no;
    private LocalDateTime	in_date;
    
}