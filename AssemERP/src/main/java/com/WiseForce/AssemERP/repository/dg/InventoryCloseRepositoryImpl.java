package com.WiseForce.AssemERP.repository.dg;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.format.datetime.DateFormatter;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.domain.dg.Inventory_Close;
import com.WiseForce.AssemERP.dto.dg.Inventory_CloseDTO;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InventoryCloseRepositoryImpl implements InventoryCloseRepository {
	private final EntityManager entityManager;

	// 월마감 이력 개수 조회
	@Override
	public int totalCount(Inventory_CloseDTO inventory_CloseDTO) {
		String totalCountSql = "SELECT COUNT(ic) FROM Inventory_Close ic "
				+ "WHERE ic.yearmonth >= :ym_start "
				+ "AND ic.yearmonth <= :ym_end "
				+ "AND ic.close_enddate >= :start_date "
				+ "AND ic.close_startdate <= :end_date "
				+ "AND (:close_status = 999 OR ic.close_status = :close_status) ";
		TypedQuery<Long> totalCountQuery = entityManager.createQuery(totalCountSql, Long.class)
				.setParameter("ym_start", inventory_CloseDTO.getYearmonth_start_text())
				.setParameter("ym_end", inventory_CloseDTO.getYearmonth_end_text())
				.setParameter("start_date", inventory_CloseDTO.getStartDate().atTime(0,0,0))
				.setParameter("end_date", inventory_CloseDTO.getEndDate().atTime(23,59,59))
				.setParameter("close_status", inventory_CloseDTO.getClose_status());
		
		return totalCountQuery.getSingleResult().intValue();
	}

	// 월마감 이력 목록 조회
	@Override
	public List<Inventory_Close> findAllBySearch(Inventory_CloseDTO inventory_CloseDTO) {
		// 기간에 따라 검색
		String startDate = inventory_CloseDTO.getStartDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		String endDate = inventory_CloseDTO.getEndDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		// 마감상태에 따라 검색
		String whereCloseStatus = (inventory_CloseDTO.getClose_status() != 999) ? 
				"AND close_status = " + inventory_CloseDTO.getClose_status() : "";
		// 담당자에 따라 검색
		
		// createNativeQuery : 실제 DB의 테이블명, 칼럼명을 사용하여 쿼리 진행
		String findAllBySearchSql =	"SELECT yearmonth, close_status, close_startdate, close_enddate, emp_no " 
				+ "FROM ( "
				+ "    SELECT ROWNUM rn, ic.* "
				+ "    FROM ( "
				+ "        	SELECT yearmonth, close_status, close_startdate, close_enddate, emp_no "
				+ "        	FROM   inventory_close "
				+ "			WHERE yearmonth >= '" + inventory_CloseDTO.getYearmonth_start_text() + "' "
				+ "			AND yearmonth <= '" + inventory_CloseDTO.getYearmonth_end_text() + "' "
				+ "			AND close_enddate >= '" + startDate + "' "
				+ "			AND close_startdate <= TO_DATE('" + endDate + " 23:59:59', 'YYYY-MM-DD HH24:MI:SS') " 
				+ 			whereCloseStatus
				+ "        	ORDER BY yearmonth DESC "
				+ "    ) ic "
				+ ") "
				+ "WHERE rn BETWEEN :start AND :end";
		
//		System.out.println(findAllBySearchSql);
		
		// 두 번째 인자로 엔티티 클래스를 주면 자동으로 매핑 시도
		Query findAllBySearchQuery = entityManager.createNativeQuery(findAllBySearchSql, Inventory_Close.class); 

	    // :start 파라미터에 값 넣기
		findAllBySearchQuery.setParameter("start", inventory_CloseDTO.getStart());
	    // :end 파라미터에 값 넣기
		findAllBySearchQuery.setParameter("end", inventory_CloseDTO.getEnd());

		// 결과
		@SuppressWarnings("unchecked") // findAllBySearchQuery의 결과가 Inventory_Close인지 확실하지 않다고 경고하는데 해결 방법이 없대요...
		List<Inventory_Close> inventory_Closes = findAllBySearchQuery.getResultList();

		return inventory_Closes;
	}
}
