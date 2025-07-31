package com.WiseForce.AssemERP.dao.km;

import java.util.List;

import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;

public interface Sales_OrderDao {

	int 					salesTotCnt();

	List<Sales_OrderDto> 	salesList(Sales_OrderDto sales_OrderDto);

}
