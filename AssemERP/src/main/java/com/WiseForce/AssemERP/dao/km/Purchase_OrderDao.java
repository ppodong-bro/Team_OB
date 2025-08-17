package com.WiseForce.AssemERP.dao.km;

import java.util.List;

import com.WiseForce.AssemERP.dto.km.Purchase_ItemDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderSearchDto;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;

public interface Purchase_OrderDao {

	int 					totPurchase(Purchase_OrderSearchDto purchase_OrderSearchDto);

	List<Purchase_OrderDto> listPurchaseOrder(Purchase_OrderSearchDto purchase_OrderSearchDto);

	Purchase_OrderDto 		detailPurchase(int purchase_No);

	List<PartsDTO> 			partsPop(String parts_Name);

	void 					createPurchase(Purchase_OrderDto purchase_OrderDto);

	int 					checkClose();

	void 					modifyPurchase(Purchase_OrderDto purchase_OrderDto);

	int 					getInStatus(int purchase_No);

	void 					modifyStatus(int purchase_No, int in_Status);

	void 					modifyComplete(int purchase_No, int in_Status, List<Integer> parts_no);

	List<Integer> 			getPartsNo(int purchase_No);

	List<Purchase_ItemDto>  getPurchaseItem(int purchase_No);

	int 					returnInStatus(int purchase_No, Integer in_Status);

	int 					returnPurchaseItem(int purchase_No, List<Purchase_ItemDto> listPurchaseItem);

	int 					deletePurchase(int purchase_No);



}
