package com.WiseForce.AssemERP.dao.km;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.WiseForce.AssemERP.dto.km.Sales_ItemDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderSearchDto;
import com.WiseForce.AssemERP.dto.sh.ProductBomDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;

public interface Sales_OrderDao {

	int 					totSales(Sales_OrderSearchDto sales_OrderSearchDto);

	List<Sales_OrderDto> 	listSales(Sales_OrderSearchDto sales_OrderSearchDto);

	Sales_OrderDto 			detailSales(Sales_OrderDto sales_OrderDto1);

	List<ProductDTO> 	    productList(String product_Name);

	int						createSales(Sales_OrderDto sales_OrderDto);

	int 					modifySales(Sales_OrderDto sales_OrderDto, List<Sales_ItemDto> salesItemList);

	int 					deleteSales(Sales_OrderDto sales_OrderDto);

	List<Sales_ItemDto> 	salesItemList(int sales_No);

	int 					modifyStatus(int sales_No, int status);

	void 					completeStatus(Sales_OrderDto sales_OrderDto, List<Sales_ItemDto> salesItemList);

	int 					selectOutStatus(int sales_No);

	void 					completeStatus (int sales_No, int status, List<Sales_ItemDto> salesItemList);

	void 					closeStatus(int sales_No, int status);

	Sales_OrderDto 			getCompleteDateAndClientNo(int sales_No);

	int 					closeCheck();

	int 					returnComplete(Integer out_Status, int sales_No, List<Sales_ItemDto> listSalesItem);

	List<ProductBomDTO> 	findBomByProduct(int productNo, int version);

	List<Map<String, Object>> findPartsStocks(List<Integer> partsNos);

//	List<Map<String, Object>> findProductStocks(@Param("productNos") List<Integer> productNos);



}
