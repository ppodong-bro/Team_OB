package com.WiseForce.AssemERP.dao.dg;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InventoryDaoImpl implements InventoryDao {
	private final SqlSession session;

	// 현재 재고 전체 종류수 조회 함수 실행
	@Override
	public int getLastestMonthInventoryCnt(Real_InventoryDTO real_InventoryDTO) {
		// 현재 재고 전체 조회 함수 실행
		int totalTypeCount = session
				.selectOne("com.WiseForce.AssemERP.dg.InventoryMapper.callCalcRealInventoryAllCnt", real_InventoryDTO);
		
		return totalTypeCount;
	}
	
	// 현재 재고 전체 조회 함수 실행
	@Override
	public List<Real_InventoryDTO> getRealInventory(Real_InventoryDTO real_InventoryDTO) {
		// 현재 재고 전체 조회 함수 실행
		List<Real_InventoryDTO> real_InventoryDTOs = session
				.selectList("com.WiseForce.AssemERP.dg.InventoryMapper.callCalcRealInventoryAll", real_InventoryDTO);
		
		return real_InventoryDTOs;
	}

	// 현재 재고 조회 함수 실행
	@Override
	public Real_InventoryDTO getRealInventoryById(Real_InventoryDTO real_InventoryDTO) {
		Real_InventoryDTO target_Real_InventoryDTO = session.selectOne("com.WiseForce.AssemERP.dg.InventoryMapper.callCalcRealInventoryById", real_InventoryDTO);
		
		return target_Real_InventoryDTO;
	}
	
	// 월마감 패키지 실행
	@Override
	public boolean doMonthClose(String yearMonth, int empno, int realStatus) {
		//월마감 패키지 파라미터 등록
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("yearmonth", yearMonth);//IN
		paramMap.put("emp_no", empno);//IN
		paramMap.put("realStatus", realStatus);//IN
		paramMap.put("result", "");//OUT
		// 월마감 패키지 실행
		session.selectOne("com.WiseForce.AssemERP.dg.InventoryMapper.callMonthClose", paramMap);

	    // OUT 파라미터 값 읽기
	    String resultMsg = (String) paramMap.get("result");
	    if ("true".equalsIgnoreCase(resultMsg)) {
	        return true;
	    } else {
	        return false;
	    }
	}
}
