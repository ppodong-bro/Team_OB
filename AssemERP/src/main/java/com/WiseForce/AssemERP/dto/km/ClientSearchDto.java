package com.WiseForce.AssemERP.dto.km;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ClientSearchDto {

    // 거래처명으로 부분 검색
    private String client_Name;

    // 유형: 0=구매, 1=판매
    private Integer client_Gubun;
    
    // 담당자 이름으로 부분 검색
    private String client_Man;

	/*
	 * // (선택) 등록일자 범위 검색용 private String inDate_Start;
	 * 
	 * private String inDate_End;
	 */
    
	private int				start;
	private int				end;
	private String 			currentPage;
}
