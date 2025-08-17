package com.WiseForce.AssemERP.dto.km;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class PartsShortageDto {
    private int    parts_no;        // 부품 번호
    private String parts_name;      // 부품명
    private int    required_cnt;    // 수주 전체 소요량(= BOM 소요량 * 주문수량 합)
    private int    available_cnt;   // 현재 가용 재고
    private int    shortage_cnt;    // 부족 수량(= required - available, 0보다 큰 값만 노출)
}
