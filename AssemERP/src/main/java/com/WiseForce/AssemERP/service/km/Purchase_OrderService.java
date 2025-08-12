package com.WiseForce.AssemERP.service.km;

import java.util.List;

import com.WiseForce.AssemERP.dto.km.Purchase_OrderDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderSearchDto;

public interface Purchase_OrderService {

	int 					totPurchase(Purchase_OrderSearchDto purchase_OrderSearchDto);

	List<Purchase_OrderDto> listPurchaseOrder(Purchase_OrderSearchDto purchase_OrderSearchDto);

}
