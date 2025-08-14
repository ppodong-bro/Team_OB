package com.WiseForce.AssemERP.dao.km;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.km.Purchase_ItemDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderSearchDto;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class Purchase_OrderDaoImpl implements Purchase_OrderDao {
	private final SqlSession session;

	@Override
	public int totPurchase(Purchase_OrderSearchDto purchase_OrderSearchDto) {
			int totCnt = session.selectOne("totPurchase",purchase_OrderSearchDto);
			System.out.println("totCnt--->"+totCnt);
		return totCnt;
	}

	@Override
	public List<Purchase_OrderDto> listPurchaseOrder(Purchase_OrderSearchDto purchase_OrderSearchDto) {
		List<Purchase_OrderDto> listPurchase = session.selectList("listPurchaseOrder",purchase_OrderSearchDto);
		return listPurchase;
	}

	@Override
	public Purchase_OrderDto detailPurchase(int purchase_No) {
		Purchase_OrderDto purchase_OrderDto = session.selectOne("detailPurchase", purchase_No);
		
		return purchase_OrderDto;
	}

	@Override
	public List<PartsDTO> partsPop() {
		List<PartsDTO> listParts = session.selectList("partsPop");
		return listParts;
	}

	@Override
	public void createPurchase(Purchase_OrderDto purchase_OrderDto) {
		session.insert("createPurchase", purchase_OrderDto);
		session.insert("createPurchaseItem", purchase_OrderDto);
		System.out.println("purchase_OrderDto----------->"+purchase_OrderDto);
		
	}

	/*
	 * @Override public void createPurchaseItem(List<Purchase_ItemDto>
	 * purchase_ItemDto) { session.insert("createPurchaseItem", purchase_ItemDto);
	 * 
	 * }
	 */
}
