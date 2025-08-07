package com.WiseForce.AssemERP.domain.km;

import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
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


@Entity
@Getter
@Setter
@ToString
@Builder
@NoArgsConstructor
@AllArgsConstructor
@SequenceGenerator(
		name 		 = 	"sales_seq",
		sequenceName = 	"sales_seq_gen",
		initialValue =  3011,
		allocationSize = 1
		)
public class Sales_Order {
	@Id
	@GeneratedValue(
			strategy  = GenerationType.SEQUENCE,
			generator = "sales_seq" 
			)
	private int sales_no;
	
	/*
	 * @ManyToOne(fetch = FetchType.LAZY)
	 * 
	 * @JoinColumn( name = "CLIENT_NO", nullable = false, foreignKey
	 * = @ForeignKey(name="FK_CLIENT_TO_SALES_ORDER") ) private Client client;
	 */
	
	
//	@ManyToOne(fetch = FetchType.LAZY)
//	@JoinColumn(
//			name     = "EMP_NO",
//			nullable = false,
//			foreignKey = @ForeignKey(name="FK_EMP_TO_SALES_ORDER")
//			)
//	private Emp 			emp;
//	
	private LocalDate 		sales_date;
	private int	  			out_status;
	private int   			del_status;
	private LocalDateTime 	in_date;
}
