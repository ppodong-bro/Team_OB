package com.WiseForce.AssemERP.dto.dg;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class InventoryInfoDTO {
	private int item_type; // 부품/제품 구분
	private int item_no; // 재고 번호
	private int item_status; // 재고 구분
	private String item_name; // 재고 명
	private int cnt; // 재고 수량 
	private String files_no; // 파일의 UUID
	
	private int item_adjustcnt; // 조정 재고 수량
	private List<MultipartFile> files; // 파일들
}
