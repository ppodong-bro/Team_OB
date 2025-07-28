package com.WiseForce.AssemERP.domain.km;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Embeddable
public class Client_His_Id {
	
	private int client_No;
	private String start_Date;
}
