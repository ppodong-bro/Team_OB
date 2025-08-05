package com.WiseForce.AssemERP.domain.dg;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Common {
	@EmbeddedId
	// 대분류
	// 중분류
	Common_ID common_ID;

	private String context;// 내용
}

/* 250805 DB 저장 데이터 */
//100	999	삭제구분
//100	0	활성
//100	1	삭제
//200	999	권한
//200	0	ROLE_ADMIN
//200	1	ROLE_MANAGER
//200	2	ROLE_USER
//300	999	거래처유형
//300	0	구매처
//300	1	판매처
//400	999	발주상태
//400	0	요청
//400	1	승인
//400	2	완료
//400	3	마감
//500	999	수주상태
//500	0	요청
//500	1	승인
//500	2	완료
//500	3	마감
//600	999	부품/제품 구분
//600	0	부품
//600	1	제품
//700	999	마감 구분
//700	0	마감시작
//700	1	마감완료
//700	2	월마감완료
//800	999	제품 분류
//800	0	데스크탑
//800	1	노트북
//800	2	워크스테이션
//900	999	부품 분류
//900	0	메인보드
//900	1	CPU
//900	2	GPU
//900	3	메모리;
//900	4	POWER
//900	5	HDD
//900	6	SSD
//900	7	CASE
//900	8	COOLER
//1000	999	호환성 여부
//1000	0	미확인
//1000	1	호환가능
//1000	2	호환불가능
//1100	999	수주/발주 구분
//1100	0	수주