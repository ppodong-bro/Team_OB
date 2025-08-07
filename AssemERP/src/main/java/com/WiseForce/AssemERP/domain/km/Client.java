package com.WiseForce.AssemERP.domain.km;

import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.annotation.Generated;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@SequenceGenerator(
		name = 			"client_seq",
		sequenceName = 	"client_seq_gen",
		initialValue = 1011,
		allocationSize = 1
		)
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Client {
	
	@Id
	@GeneratedValue(
			strategy  = GenerationType.SEQUENCE,
			generator = "client_seq"
			)
	private int client_no;
	
	/*
	 * @ManyToOne(fetch = FetchType.LAZY)
	 * 
	 * @JoinColumn( name = "EMP_NO", // DB 컬럼명 nullable = false, // NOT NULL 제약
	 * foreignKey = @For(name = "FK_CLIENT_EMP") ) 
	 * private Emp emp;
	 */	
	private String 			client_name;
	private int 			client_gubun;
	private String  		client_email;
	private String  		client_man;
	private String  		client_address;
	private String			client_Tel;
	private int				del_status;
	private LocalDateTime   modify_date;
	private LocalDateTime	in_date;
}
