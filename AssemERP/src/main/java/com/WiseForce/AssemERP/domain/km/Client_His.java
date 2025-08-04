package com.WiseForce.AssemERP.domain.km;

import java.time.LocalDateTime;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor  // JPA용 기본 생성자
public class Client_His {
	@EmbeddedId
	private Client_His_Id client_His_Id;
	private String end_Date;
	private String emp_No;
	private String client_Name;
	private int	   client_Gubun;
	private String client_Email;
	private String client_Man;
	private String client_Tel;
	private String client_Address;
	private LocalDateTime in_Date;
}
