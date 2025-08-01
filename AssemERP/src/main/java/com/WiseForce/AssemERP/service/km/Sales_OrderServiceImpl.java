package com.WiseForce.AssemERP.service.km;

import java.util.List;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.km.Sales_OrderDao;
import com.WiseForce.AssemERP.dto.km.Sales_ItemDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderSearchDto;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Transactional
@Service
public class Sales_OrderServiceImpl implements Sales_OrderService {
	private final Sales_OrderDao sales_OrderDao;

	@Override
	public int salesTotCnt() {
		int totCnt = sales_OrderDao.salesTotCnt();
		return totCnt;
	}

	@Override
	public List<Sales_OrderDto> salesList(Sales_OrderDto sales_OrderDto) {
		System.out.println("Sales_OrderServiceImpl salesList Start...");
		List<Sales_OrderDto> salesList = sales_OrderDao.salesList(sales_OrderDto);
	
		
		for(Sales_OrderDto sales_OrderDto1 : salesList) {
			
			List<Sales_ItemDto> itemList = sales_OrderDto1.getSales_Item();
			
			Long totCost = 0L;
			int totCnt = 0;
			int totOutCnt = 0;   
			
			for(Sales_ItemDto sales_ItemDto : itemList) {
				System.out.println("sales_ItemDto->"+sales_ItemDto);
				int cnt = sales_ItemDto.getSales_Item_Cnt();
				int out_Cnt = sales_ItemDto.getSales_Item_OutCnt();
				Long cost = sales_ItemDto.getSales_Item_Cost();
				
				totCnt += cnt;
				totOutCnt	+= out_Cnt;	
				totCost += cost*cnt;
				
			
			}
			
			sales_OrderDto1.setTotCnt(totCnt);
			sales_OrderDto1.setTotOutCnt(totOutCnt);
			sales_OrderDto1.setTotCost(totCost);
	
		}
		System.out.println("salesList------>"+salesList);

		return salesList;
	}

	@Override
	public int searchTotCnt(Sales_OrderSearchDto sales_OrderSearchDto) {
		System.out.println("Sales_OrderServiceImpl searchTotCnt Start...");
		int searchTotCnt = sales_OrderDao.searchTotCnt(sales_OrderSearchDto);
		return searchTotCnt;
	}

	@Override
	public List<Sales_OrderDto> searchSales(Sales_OrderSearchDto sales_OrderSearchDto) {
		System.out.println("Sales_OrderServiceImpl searchList Start...");
		List<Sales_OrderDto> salesList = sales_OrderDao.searchSales(sales_OrderSearchDto);
		
		return salesList;
	}
	
	
}
