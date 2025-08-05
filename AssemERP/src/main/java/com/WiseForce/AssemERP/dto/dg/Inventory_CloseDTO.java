package com.WiseForce.AssemERP.dto.dg;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Inventory_CloseDTO {
	// Entity
	private String yearmonth;// 년월 : YYMM
	private int close_status = 999;// 마감완료여부
	private String close_startdate; // 마감시작일시
	private String close_enddate;// 마감종료일시
	private int emp_no;// 마감처리담당자

	// 출력
	private String emp_no_text;// 마감처리담당자 이름
	private String result;// 월마감 패키지 결과

	// 검색
	private String yearmonth_start_text;// 년월 검색 시작
	private String yearmonth_end_text;// 년월 끝
	private LocalDate startDate; // 마감 검색 시작일
	private LocalDate endDate; // 마감 검색 종료일
//	private int close_status_select; // 마감 상태
	// 담당자

	// 검색 예시
	private String sample_yearmonth_start_text; // 년월 검색 시작 예시
	private String sample_yearmonth_end_text; // 년월 검색 끝 예시

	// 페이지
	private int start;// 재고 번호 시작
	private int end;// 재고 번호 끝
	private String currentPage;// 현제 페이지
	private String pageNum;// 전체 페이지 개수
}
