package com.WiseForce.AssemERP.dao.km;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.km.Purchase_OrderDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderSearchDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class Purchase_OrderDaoImpl implements Purchase_OrderDao {
	private final SqlSession session;

	@Override
	public int totPurchase(Purchase_OrderSearchDto purchase_OrderSearchDto) {
			int totCnt = session.selectOne("totPurchase",purchase_OrderSearchDto);
		return totCnt;
	}

	@Override
	public List<Purchase_OrderDto> listPurchaseOrder(Purchase_OrderSearchDto purchase_OrderSearchDto) {
		List<Purchase_OrderDto> listPurchase = session.selectList("listPurchaseOrder",purchase_OrderSearchDto);
		return listPurchase;
	}

}
