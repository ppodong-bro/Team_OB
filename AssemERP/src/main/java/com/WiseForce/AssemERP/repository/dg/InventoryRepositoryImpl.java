package com.WiseForce.AssemERP.repository.dg;

import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.domain.dg.Inventory;
import com.WiseForce.AssemERP.dto.dg.InventoryDTO;
import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InventoryRepositoryImpl implements InventoryRepository {
	private final EntityManager entityManager;

	// 재고 입출고 이력의 총 수량 계산하는 프로시저 실행
	@Override
	public void execProcedureClacInventoryTot() {
		// 프로시저 실행
		entityManager.createNativeQuery(""
				+ "BEGIN "
				+ "	procedure_clac_inventory_tot; "
				+ "END;").executeUpdate();
	}
	
	// JPA에서는 NVL와 COALESCE를 사용하지 말라고 한다...
	// 재고 입출고 이력 목록 수 조회
	@Override
	public int getInventoryHistoryCnt(InventoryDTO inventoryDTO) {
		String totalCountSql = "SELECT COUNT(i) FROM Inventory i "
				+ "LEFT JOIN Parts pa ON i.item_status = 0 AND i.item_no = pa.parts_no "
				+ "LEFT JOIN Product pr ON i.item_status = 1 AND i.item_no = pr.product_no "
				+ "WHERE (:order_status = 999 OR i.order_status = :order_status) "
				+ "AND (:order_no IS NULL OR i.order_no = :order_no) "
				+ "AND (:item_status = 999 OR i.item_status = :item_status) "
				+ "AND ((pa.parts_name IS NOT NULL AND pa.parts_name LIKE :item_no_text) OR (pr.product_name IS NOT NULL AND pr.product_name LIKE :item_no_text)) ";
		TypedQuery<Long> totalCountQuery = entityManager.createQuery(totalCountSql, Long.class)
				.setParameter("order_status", inventoryDTO.getOrder_status_select())
				//공백일 경우 전체 검색하도록 NULL을 입력
				.setParameter("order_no", (inventoryDTO.getOrder_no_text() != "") ? inventoryDTO.getOrder_no_text() : null)
				.setParameter("item_status", inventoryDTO.getItem_status_select())
				.setParameter("item_no_text", (inventoryDTO.getItem_no_text() != null) ? "%" + inventoryDTO.getItem_no_text() + "%" : "%%");
		
		return totalCountQuery.getSingleResult().intValue();
	}
	
	// 재고 입출고 이력 목록 조회
	@Override
	public List<InventoryDTO> getInventoryHistory(InventoryDTO inventoryDTO) {
		System.out.println(inventoryDTO);

		// 거래 구분에 따라 검색
		String whereOrderStatus = (inventoryDTO.getOrder_status_select() != 999) ? 
				"WHERE i1.order_status = " + inventoryDTO.getOrder_status_select() : "WHERE i1.order_status <> 999";
		String whereOrderNo = (inventoryDTO.getOrder_no_text() == null || inventoryDTO.getOrder_no_text() == "") ? "" : "AND i1.order_no = " + inventoryDTO.getOrder_no_text();
		// 재고 구분에 따라 검색
		String whereItemStatus = (inventoryDTO.getItem_status_select() != 999) ? 
				"AND i1.item_status = " + inventoryDTO.getItem_status_select() : "AND i1.item_status <> 999";
		String whereItemName = "AND (NVL(pa.parts_name, '') LIKE :itemnotext OR NVL(pr.product_name, '') LIKE :itemnotext)";
		
		System.out.println("whereOrderNo: " + whereItemName);
		
		// createNativeQuery : 실제 DB의 테이블명, 칼럼명을 사용하여 쿼리 진행
		String findAllBySearchSql = "SELECT inventory_his_no, order_status, order_no, item_status, item_no, item_no_text, inout_status, inout_date, item_cnt, item_totalcnt, item_quality "
				+ "FROM ( "
				+ "    SELECT ROWNUM rn, i0.* "
				+ "    FROM ( "
				+ "        	SELECT inventory_his_no, order_status, order_no, item_status, item_no, NVL(parts_name, product_name) AS item_no_text, inout_status, inout_date, item_cnt, item_totalcnt, item_quality"
				+ "        	FROM inventory i1 "
				+ "			LEFT JOIN parts pa ON i1.item_status = 0 AND i1.item_no = pa.parts_no "
				+ "			LEFT JOIN product pr ON i1.item_status = 1 AND i1.item_no = pr.product_no "
				+ 			whereOrderStatus + " "
				+ 			whereOrderNo + " "
				+			whereItemStatus + " "
				+			whereItemName + " "
				+ "        	ORDER BY inventory_his_no DESC "
				+ "    ) i0 "
				+ ") "
				+ "WHERE rn BETWEEN :start AND :end";

		System.out.println(findAllBySearchSql);

		// 두 번째 인자로 엔티티 클래스를 주면 자동으로 매핑 시도
		Query findAllBySearchQuery = entityManager.createNativeQuery(findAllBySearchSql);

		// 재고 명 검색 파라미터
		findAllBySearchQuery.setParameter("itemnotext", inventoryDTO.getItem_no_text() != null ? "%"+inventoryDTO.getItem_no_text()+"%" : "%%");
		// :start 파라미터에 값 넣기
		findAllBySearchQuery.setParameter("start", inventoryDTO.getStart());
		// :end 파라미터에 값 넣기
		findAllBySearchQuery.setParameter("end", inventoryDTO.getEnd());

		// 결과
		@SuppressWarnings("unchecked") // findAllBySearchQuery의 결과가 Inventory_Close인지 확실하지 않다고 경고하는데 해결 방법이 없대요...
		List<Object[]> results = findAllBySearchQuery.getResultList();

		// results -> DTO
		List<InventoryDTO> inventoryDTOs = results.stream()
				.map(row -> InventoryDTO.builder()
						.inventory_his_no((int)row[0])
						.order_status((int)row[1])
						.order_no((int)row[2])
						.item_status((int)row[3])
						.item_no((int)row[4])
						.item_no_text((String)row[5])
						.inout_status((int)row[6])
						// Timestamp : JPA에서 기본 제공하는 DateTime
						// Date -> LocalDateTime(YYYY-MM-DD hh:mm:ss)
						.inout_date(((Timestamp)row[7]).toLocalDateTime())
						.inout_date_text(((Timestamp)row[7]).toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
						.item_cnt((int)row[8])
						.item_totalcnt((int)row[9])
						.item_quality((int)row[10])						
						.build())
				.collect(Collectors.toList());
		
		return inventoryDTOs;
	}
}
