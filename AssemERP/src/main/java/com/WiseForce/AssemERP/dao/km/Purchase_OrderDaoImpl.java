package com.WiseForce.AssemERP.dao.km;

import java.util.List;
import java.util.Map;

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
	public List<PartsDTO> partsPop(String parts_Name) {
		List<PartsDTO> listParts = session.selectList("partsPop", parts_Name);
		return listParts;
	}

	@Override
	public int createPurchase(Purchase_OrderDto purchase_OrderDto) {
		int result = session.insert("createPurchase", purchase_OrderDto);
		session.insert("createPurchaseItem", purchase_OrderDto);
		System.out.println("purchase_OrderDto----------->"+purchase_OrderDto);
		
		return result;
	}

	@Override
	public int checkClose() {
		int checkClose = session.selectOne("closeCheckPurchase");
		return checkClose;
	}

	@Override
	public int modifyPurchase(Purchase_OrderDto purchase_OrderDto) {
		System.out.println("modifyPurchase-> purchase_OrderDto -> "+ purchase_OrderDto);
//		List<Purchase_ItemDto> purchaseItem = purchase_OrderDto.getPurchase_Item();
//		System.out.println("purchaseItem"+purchaseItem);
		session.delete("deletePurchaseItem", purchase_OrderDto);
		int result = session.update("modifyPurchase",purchase_OrderDto);
		session.update("createPurchaseItem",purchase_OrderDto);
		
		return result;
	}

	@Override
	public int getInStatus(int purchase_No) {
		int in_Status = session.selectOne("getInStatus", purchase_No);
		return in_Status;
	}

	@Override
	public int modifyStatus(int purchase_No, int in_Status) {
	
		Map<String, Object> map = Map.of("purchase_No", purchase_No, "in_Status", in_Status);
		System.out.println("map->"+map);
		int result = session.update("modifyInStatus", map);
		
		return result;
	}

	@Override
	public int modifyComplete(int purchase_No, int in_Status, List<Integer> parts_no) {
		Map<String, Object> map = Map.of("purchase_No", purchase_No, "in_Status", in_Status);
		Map<String,Object> itemMap = Map.of("purchase_No", purchase_No, "in_Status", in_Status, "parts_no", parts_no);
		int result =session.update("modifyCompletePurchase", map);
					session.update("modifyCompletePurchaseItem", itemMap);
	
		return result;
	}

	@Override
	public List<Integer> getPartsNo(int purchase_No) {
		List<Integer> partsNo = session.selectList("getPartsNo",purchase_No);
		System.out.println("partsNo"+partsNo);
		return partsNo;
	}

	@Override
	public List<Purchase_ItemDto> getPurchaseItem(int purchase_No) {
		List<Purchase_ItemDto> listPurchaseItem = session.selectList("getPurchaseItem", purchase_No);
		return listPurchaseItem;
	}

	@Override
	public int returnInStatus(int purchase_No, Integer in_Status) {
		Map<String, Object> returnList = Map.of("purchase_No", purchase_No, "in_Status", in_Status);
		int result = session.update("returnInStatus", returnList);
		
		return result;
	}

	@Override
	public int returnPurchaseItem(int purchase_No, List<Purchase_ItemDto> listPurchaseItem) {
		
		int result = session.update("returnPurchaseItem", listPurchaseItem);
		return result;
	}


	@Override
	public int deletePurchase(int purchase_No) {
		int result = session.update("deletePurchase", purchase_No);
		return result;
	}

}
