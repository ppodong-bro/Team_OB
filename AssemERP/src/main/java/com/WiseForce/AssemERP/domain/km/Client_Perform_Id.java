package com.WiseForce.AssemERP.domain.km;

import jakarta.persistence.Column;
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
public class Client_Perform_Id {
	@Column(name = "YEARMONTH")
	private String yearMonth;
	private int	   client_No;
}
