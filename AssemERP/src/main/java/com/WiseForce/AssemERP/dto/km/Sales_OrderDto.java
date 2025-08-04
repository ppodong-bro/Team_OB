package com.WiseForce.AssemERP.dto.km;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.WiseForce.AssemERP.dto.sh.ProductDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Sales_OrderDto {
	private int sales_No;
	private EmpDTO empDTO;
	private String empName;
	private LocalDate sales_Date;
	private int out_Status;
	private int del_Status;
	private LocalDateTime in_Date;
	private List<Sales_ItemDto> sales_Item;
	private ClientDto clientDto;

	// paging
	private String currentPage;
	private int start;
	private int end;
	
	// 총 요청수량, 총 출고수량, 제품 총액
	private int  totCnt;     // 모든 품목에 대한 요청 수량 합
	private int  totOutCnt;  // 모든 품목에 대한 출고 수량 합
	private int  totWaitingCnt; // 모든 품목에 대한 출고 대기 수량 합
	private Long totCost;    // 모든 제품 총액
	private Long totOutCost; // 출고 제품 기준 총액
		// TODO Auto-generated method stub
		
	}
