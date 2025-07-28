package com.WiseForce.AssemERP.domain.km;

import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
@AllArgsConstructor
@NoArgsConstructor
@SequenceGenerator(
		name 		 	= "purchase_seq",
		sequenceName 	= "purchase_seq_gen",
		initialValue 	= 4101,
		allocationSize 	= 1
		)
public class Purchase_Order {
	@Id
	@GeneratedValue(
			strategy  = GenerationType.SEQUENCE,
			generator = "purchase_seq_gen"
			)
	private int purchase_no;
	
//	@ManyToOne(fetch = FetchType.LAZY)
//	@JoinColumn(
//			name     = "EMP_NO",
//			nullable = false,
//			foreignKey = @ForeignKey(name="FK_EMP_TO_SALES_ORDER")
//			)
//	private Emp emp;
	
	private LocalDate 		purchase_date;
	private int		  		in_status;
	private int		  		del_status;
	private LocalDateTime	in_date;
}
