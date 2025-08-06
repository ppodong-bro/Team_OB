package com.WiseForce.AssemERP.dao.km;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderSearchDto;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class Sales_OrderDaoImpl implements Sales_OrderDao {
	private final SqlSession session;
//
//	@Override
//	public int salesTotCnt() {
//		int totCnt = session.selectOne("salesTotCnt");
//		return totCnt;
//	}
//
//	@Override
//	public List<Sales_OrderDto> salesList(Sales_OrderDto sales_OrderDto) {
//		System.out.println("Sales_OrderDaoImpl salesList Start...");
//		List<Sales_OrderDto> listSales = session.selectList("salesList", sales_OrderDto);
//		System.out.println("Sales_OrderDaoImpl salesList listSales-->"+listSales);
//		return listSales;
//	}

	@Override
	public int totSales(Sales_OrderSearchDto sales_OrderSearchDto){
		System.out.println("Sales_OrderDaoImpl totSales Start...");
		System.out.println("Sales_OrderDaoImpl totSales sales_OrderSearchDto->"+sales_OrderSearchDto);
		int searchTotCnt = session.selectOne("totSales", sales_OrderSearchDto);
		System.out.println("Sales_OrderDaoImpl totSales searchTotCnt-->"+ searchTotCnt);
		return searchTotCnt;
	}

	@Override
	public List<Sales_OrderDto> listSales(Sales_OrderSearchDto sales_OrderSearchDto) {
		System.out.println("Sales_OrderDaoImpl listSales Start...");
		List<Sales_OrderDto> salesList = session.selectList("listSales", sales_OrderSearchDto);
		System.out.println("Sales_OrderDaoImpl listSales searchList-->"+salesList);
		return salesList;
	}

	@Override
	public Sales_OrderDto detailSales(Sales_OrderDto sales_OrderDto1) {
		System.out.println("Sales_OrderDao detailSales Start...");
		System.out.println("Sales_OrderDao detailSales sales_OrderDto1-->"+sales_OrderDto1);
		Sales_OrderDto sales_OrderDto = session.selectOne("detailSales", sales_OrderDto1.getSales_No());
		System.out.println("Sales_OrderDao detailSales sales_OrderDto-->"+sales_OrderDto);
		
		return sales_OrderDto;
	}

	@Override
	public List<ProductDTO> productList() {
		List<ProductDTO> productList = session.selectList("salesProductList");
		return productList;
	}

	@Override
	public List<ClientDto> clientList() {
		List<ClientDto> clientList = session.selectList("salesClientList");
		return clientList;
	}
	
	@Override 
	public void createSales(Sales_OrderDto sales_OrderDto) {
	  session.insert("createSales",sales_OrderDto);
	 
	}
	



}
