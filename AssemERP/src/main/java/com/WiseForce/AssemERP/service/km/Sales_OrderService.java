package com.WiseForce.AssemERP.service.km;

import java.util.List;

import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;

public interface Sales_OrderService {

	int 					salesTotCnt();

	List<Sales_OrderDto> 	salesList(Sales_OrderDto sales_OrderDto);
	
}
