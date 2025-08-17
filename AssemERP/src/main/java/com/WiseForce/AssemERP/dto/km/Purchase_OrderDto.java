package com.WiseForce.AssemERP.dto.km;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.WiseForce.AssemERP.dto.sm.EmpDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@Data
@NoArgsConstructor  // JPA용 기본 생성자
public class Purchase_OrderDto {
	private int				purchase_No;
	private ClientDto		clientDto;
	private EmpDTO			empDTO;
	private LocalDate 		purchase_Date;
	private int		  		in_Status;
	private int		  		del_Status;
	private LocalDateTime   complete_Date;
	private LocalDateTime   modify_Date;
	private LocalDateTime	in_Date;
	private List<Purchase_ItemDto> purchase_Item;
	
	// paging
	private String currentPage;
	private int start;
	private int end;
	
	// 총 요청수량, 총 출고수량, 제품 총액
	private int  totCnt;     // 모든 품목에 대한 요청 수량 합
	private int  totInCnt;  // 모든 품목에 대한 출고 수량 합
	private int  totWaitingCnt; // 모든 품목에 대한 출고 대기 수량 합
	private Long totCost;    // 모든 제품 총액
	private Long totInCost; // 출고 제품 기준 총액

}
