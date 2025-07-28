package com.WiseForce.AssemERP.domain.sh;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@SequenceGenerator(
					name = "parts_seq_generator",
					sequenceName = "parts_seq",
					initialValue = 1,
					allocationSize = 1
					)
public class Parts {
	@Id
	@GeneratedValue(
					strategy = GenerationType.SEQUENCE,
					generator = "parts_seq_generator"
					)
	private int				parts_no;
    private	int				parts_status;
	private	String			parts_name;
	@Column(columnDefinition = "VARCHAR2(1000 CHAR)")
	private	String			parts_context;
	private	int				relation_status;
	private	String			manufacture;
	private	String			filename;
	private int				del_status;
    @Column(name = "emp_no", nullable = false) // 도건 : 나중에 FK(EMP) 지정 필요
    private int				registrar;
    private LocalDateTime	in_date;
}