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
public class Client_Perform {
	@EmbeddedId
	private Client_Perform_Id client_Perform_Id;
	private Long			  cnt;
	private Long			  total_Amt;
}
