package com.WiseForce.AssemERP.domain.dg;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Inventory_Close {
	@Id
	private String yearmonth;// 년월 : YYMM
	private int close_status;// 마감완료여부
	private LocalDateTime close_startdate; // 마감시작일시
	private LocalDateTime close_enddate;// 마감종료일시
	private int emp_no;// 마감처리담당자
}
