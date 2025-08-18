package com.WiseForce.AssemERP.dao.km;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.Sales_ItemDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderSearchDto;
import com.WiseForce.AssemERP.dto.sh.ProductBomDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class Sales_OrderDaoImpl implements Sales_OrderDao {
	private final SqlSession session;

	@Override
	public int totSales(Sales_OrderSearchDto sales_OrderSearchDto) {
		System.out.println("Sales_OrderDaoImpl totSales Start...");
		System.out.println("Sales_OrderDaoImpl totSales sales_OrderSearchDto->" + sales_OrderSearchDto);
		int searchTotCnt = session.selectOne("totSales", sales_OrderSearchDto);
		System.out.println("Sales_OrderDaoImpl totSales searchTotCnt-->" + searchTotCnt);
		return searchTotCnt;
	}

	@Override
	public List<Sales_OrderDto> listSales(Sales_OrderSearchDto sales_OrderSearchDto) {
		System.out.println("Sales_OrderDaoImpl listSales Start...");
		List<Sales_OrderDto> salesList = session.selectList("listSales", sales_OrderSearchDto);
		System.out.println("Sales_OrderDaoImpl listSales searchList-->" + salesList);
		return salesList;
	}

	@Override
	public Sales_OrderDto detailSales(Sales_OrderDto sales_OrderDto1) {
		System.out.println("Sales_OrderDao detailSales Start...");
		System.out.println("Sales_OrderDao detailSales sales_OrderDto1-->" + sales_OrderDto1);
		Sales_OrderDto sales_OrderDto = session.selectOne("detailSales", sales_OrderDto1.getSales_No());
		System.out.println("Sales_OrderDao detailSales sales_OrderDto-->" + sales_OrderDto);

		return sales_OrderDto;
	}

	@Override
	public List<ProductDTO> productList(String product_Name) {
		LocalDateTime time = LocalDateTime.now();
		List<ProductDTO> productList = session.selectList("salesProductList", product_Name);
		return productList;
	}

	@Override
	public int createSales(Sales_OrderDto sales_OrderDto) {

		session.insert("createSales", sales_OrderDto);
		int result = session.insert("createSales_Item", sales_OrderDto);
		
		return result;
	}

	@Override
	public int modifySales(Sales_OrderDto sales_OrderDto, List<Sales_ItemDto> salesItemList) {
		System.out.println("salesItemList->" + salesItemList);
		
		session.delete("deleteToUpdate", salesItemList);
		int result = session.update("modifySales", sales_OrderDto);
	    session.insert("createSales_Item", sales_OrderDto);
		
	    return result;
	}

	@Override
	public int deleteSales(Sales_OrderDto sales_OrderDto) {
		System.out.println("Sales_OrderDaoImpl deleteSales sales_OrderDto-->" + sales_OrderDto);
		int result = session.update("deleteSales", sales_OrderDto);
		return result;

	}

	@Override
	public List<Sales_ItemDto> salesItemList(int sales_No) {
		List<Sales_ItemDto> salesItemList = session.selectList("salesItemAll", sales_No);
		return salesItemList;
	}

	@Override
	public int modifyStatus(int sales_No, int status) {
		Map<String, Object> salesStatus = Map.of("sales_No",sales_No, "out_Status",status);
		int result = session.update("modifyOutStatus", salesStatus);
		return result;
	}

	@Override
	public void completeStatus(Sales_OrderDto sales_OrderDto, List<Sales_ItemDto> salesItemList) {
		session.update("modifySales", sales_OrderDto);
		session.update("modifyComplete", salesItemList);

	}

	@Override
	public int selectOutStatus(int sales_No) {
		int status = session.selectOne("selectOutStatus", sales_No);
		return status;
	}

	@Override
	public void completeStatus(int sales_No, int status, List<Sales_ItemDto> salesItemList) {
		Map<String, Object> salesStatus = Map.of("sales_No", sales_No, "out_Status", status);
		int result = session.update("completeStatus", salesStatus);
		System.out.println("result----------------->"+result);
		session.update("modifyComplete", salesItemList);
		
	}

	@Override
	public void closeStatus(int sales_No, int status) {
		Map<String, Object> closeStatus = Map.of("sales_No", sales_No, "out_Status", status);
		session.update("modifyOutStatus", closeStatus);
		
	}


	@Override
	public Sales_OrderDto getCompleteDateAndClientNo(int sales_No) {
		Sales_OrderDto sales_OrderDto = session.selectOne("getCompleteDateAndClientNo", sales_No);
		return sales_OrderDto;
	}

	@Override
	public int closeCheck() {
		int closeCheck = session.selectOne("closeCheckSales");
		return closeCheck;
	}

	@Override
	public int returnComplete(Integer out_Status, int sales_No, List<Sales_ItemDto> listSalesItem) {
		Map<String, Object> sales_OrderMap = Map.of("out_Status", out_Status, "sales_No", sales_No);
		int result =session.update("returnComplete", sales_OrderMap);
		session.update("returnSalesItem", listSalesItem);
		return result;
	}

	@Override
	public List<ProductBomDTO> findBomByProduct(int productNo, int version) {
		   Map<String, Object> params = new HashMap<>();
	        params.put("product_no", productNo);
	        params.put("product_version", version);
	        List<ProductBomDTO> list = session.selectList("findBomByProduct", params);
	        System.out.println("list------>"+list);
	        // selectList는 결과가 없으면 빈 리스트를 반환(null 아님)
	        return list;
//	        return session.selectList("findBomByProduct", params);
	}

	
	@Override
	public List<Map<String, Object>> findPartsStocks(List<Integer> partsNos) {
	    if (partsNos == null || partsNos.isEmpty()) return Collections.emptyList();
	    Map<String,Object> p = new HashMap<>();
	    p.put("partsNos", partsNos);
	    return session.selectList("findPartsStocks", p);
	}

//	@Override
//	public List<Map<String,Object>> findProductStocks(List<Integer> productNos) {
//	    if (productNos == null || productNos.isEmpty()) return Collections.emptyList();
//	    Map<String,Object> p = new HashMap<>();
//	    p.put("productNos", productNos);
//	    return session.selectList("findProductStocks", p);
//	}


}
