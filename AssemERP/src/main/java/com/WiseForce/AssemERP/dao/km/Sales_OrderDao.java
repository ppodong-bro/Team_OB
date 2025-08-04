package com.WiseForce.AssemERP.dao.km;

import java.util.List;

import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderSearchDto;

public interface Sales_OrderDao {

//	int 					salesTotCnt();
//
//	List<Sales_OrderDto> 	salesList(Sales_OrderDto sales_OrderDto);

	int 					totSales(Sales_OrderSearchDto sales_OrderSearchDto);

	List<Sales_OrderDto> 	listSales(Sales_OrderSearchDto sales_OrderSearchDto);

	Sales_OrderDto 			detailSales(Sales_OrderDto sales_OrderDto1);

	List<Sales_OrderDto> 	createList();

}
