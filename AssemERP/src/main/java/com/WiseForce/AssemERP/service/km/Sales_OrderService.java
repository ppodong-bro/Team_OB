package com.WiseForce.AssemERP.service.km;

import java.time.LocalDateTime;
import java.util.List;


import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.PartsShortageDto;
import com.WiseForce.AssemERP.dto.km.Sales_ItemDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderSearchDto;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;

public interface Sales_OrderService {

//	int 					salesTotCnt();
//
//	List<Sales_OrderDto> 	salesList(Sales_OrderDto sales_OrderDto);

	int 					totSales(Sales_OrderSearchDto sales_OrderSearchDto);

	List<Sales_OrderDto> 	listSales(Sales_OrderSearchDto sales_OrderSearchDto);

	Sales_OrderDto 			detailSales(Sales_OrderDto sales_OrderDto1);

	List<ProductDTO> 		productList(String product_Name);

	int 					createSales(Sales_OrderDto sales_OrderDto);

	String 					modifySales(Sales_OrderDto sales_OrderDto, List<Sales_ItemDto> salesItemList);

	String 					deleteSales(Sales_OrderDto sales_OrderDto);

	List<Sales_ItemDto> 	salesItemList(int sales_No);

	String 					modifyStatus(int sales_No, List<Sales_ItemDto> salesItemList);

	void closeCheck();

	void 					accessModify(Sales_OrderDto sales_OrderDto);

	String 					returnStatus (int sales_No);

	List<PartsShortageDto>  shortages(Sales_OrderDto sales_OrderDto);

	
}
