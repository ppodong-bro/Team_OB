package com.WiseForce.AssemERP.service.km;

import java.util.List;

import com.WiseForce.AssemERP.dto.km.Purchase_OrderDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderSearchDto;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;

public interface Purchase_OrderService {

	int 					totPurchase(Purchase_OrderSearchDto purchase_OrderSearchDto);

	List<Purchase_OrderDto> listPurchaseOrder(Purchase_OrderSearchDto purchase_OrderSearchDto);

	Purchase_OrderDto 		detailPurchase(int purchase_No);

	List<PartsDTO> 			partsPop(String parts_Name);

	void 					createPurchase(Purchase_OrderDto purchase_OrderDto);

	void 					checkClose();

	void 					modifyPurchase(Purchase_OrderDto purchase_OrderDto);

	void 					modifyStatus(int purchase_No);

	int 					returnInStatus(int purchase_No);

	int 					deletePurchase(int purchase_No);

}
