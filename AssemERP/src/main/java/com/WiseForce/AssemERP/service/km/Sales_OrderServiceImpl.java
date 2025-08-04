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

//	@Override
//	public int salesTotCnt() {
//		int totCnt = sales_OrderDao.salesTotCnt();
//		return totCnt;
//	}
//
//	@Override
//	public List<Sales_OrderDto> salesList(Sales_OrderDto sales_OrderDto) {
//		System.out.println("Sales_OrderServiceImpl salesList Start...");
//		List<Sales_OrderDto> salesList = sales_OrderDao.salesList(sales_OrderDto);
//	
//		
//		for(Sales_OrderDto sales_OrderDto1 : salesList) {
//			
//			List<Sales_ItemDto> itemList = sales_OrderDto1.getSales_Item();
//			
//			Long totCost = 0L;
//			int totCnt = 0;
//			int totOutCnt = 0;   
//			
//			for(Sales_ItemDto sales_ItemDto : itemList) {
//				System.out.println("sales_ItemDto->"+sales_ItemDto);
//				int cnt = sales_ItemDto.getSales_Item_Cnt();
//				int out_Cnt = sales_ItemDto.getSales_Item_OutCnt();
//				Long cost = sales_ItemDto.getSales_Item_Cost();
//				
//				totCnt += cnt;
//				totOutCnt	+= out_Cnt;	
//				totCost += cost*cnt;
//				
//			
//			}
//			
//			sales_OrderDto1.setTotCnt(totCnt);
//			sales_OrderDto1.setTotOutCnt(totOutCnt);
//			sales_OrderDto1.setTotCost(totCost);
//	
//		}
//		System.out.println("salesList------>"+salesList);
//
//		return salesList;
//	}

	@Override
	public int totSales(Sales_OrderSearchDto sales_OrderSearchDto) {
		System.out.println("Sales_OrderServiceImpl totSales Start...");
		int totCnt = sales_OrderDao.totSales(sales_OrderSearchDto);
		return totCnt;
	}

	@Override
	public List<Sales_OrderDto> listSales(Sales_OrderSearchDto sales_OrderSearchDto) {
		System.out.println("Sales_OrderServiceImpl salesList Start...");
		List<Sales_OrderDto> salesList = sales_OrderDao.listSales(sales_OrderSearchDto);
	
		
		for(Sales_OrderDto sales_OrderDto : salesList) {
			
			List<Sales_ItemDto> itemList = sales_OrderDto.getSales_Item();
			
			Long totCost = 0L;
			Long totOutCost = 0L;
			int totCnt = 0;
			int totOutCnt = 0;   
			
			
			for(Sales_ItemDto sales_ItemDto : itemList) {
				System.out.println("sales_ItemDto->"+sales_ItemDto);
				int cnt = sales_ItemDto.getSales_Item_Cnt();
				int out_Cnt = sales_ItemDto.getSales_Item_OutCnt();
				Long cost = sales_ItemDto.getSales_Item_Cost();
				
				totCnt    += cnt;
				totOutCnt += out_Cnt;	
				totCost   += cost*cnt;
				totOutCost += cost*out_Cnt;
				
			}
			
			sales_OrderDto.setTotCnt(totCnt);
			sales_OrderDto.setTotOutCnt(totOutCnt);
			sales_OrderDto.setTotCost(totCost);
			sales_OrderDto.setTotOutCost(totOutCost);
	
		}
		System.out.println("salesList------>"+salesList);

		return salesList;
	}

	@Override
	public Sales_OrderDto detailSales(Sales_OrderDto sales_OrderDto1) {
		Sales_OrderDto sales_OrderDto = sales_OrderDao.detailSales(sales_OrderDto1);
		
		Long totCost 		= 0L;
		Long totOutCost 	= 0L;
		int totCnt 			= 0;
		int totOutCnt 		= 0;
		int totWaitingCnt 	= 0;
		
		for(Sales_ItemDto sales_ItemDto : sales_OrderDto.getSales_Item()) {
			
			
			Long cost 		= sales_ItemDto.getSales_Item_Cost();
			int	 cnt  		= sales_ItemDto.getSales_Item_Cnt();
			int  out_Cnt 	= sales_ItemDto.getSales_Item_OutCnt();
			
			Long itemTotCost 	= cost*cnt;
			Long itemTotOutCost = cost*out_Cnt;
			int  itemWaitingCnt = cnt - out_Cnt;
			
			sales_ItemDto.setSales_Item_TotCost(itemTotCost);
			sales_ItemDto.setSales_Item_TotOutCost(itemTotOutCost);
			sales_ItemDto.setSales_Item_WaitingCnt(itemWaitingCnt);
			
			totCost    		+= cost*cnt;
			totOutCost 		+= cost*out_Cnt;
			totCnt     		+= cnt;
			totOutCnt  		+= out_Cnt;
			totWaitingCnt 	+= itemWaitingCnt;
			
			
		}
		
		sales_OrderDto.setTotCost(totCost);
		sales_OrderDto.setTotOutCost(totOutCost);
		sales_OrderDto.setTotCnt(totCnt);
		sales_OrderDto.setTotOutCnt(totOutCnt);
		sales_OrderDto.setTotWaitingCnt(totWaitingCnt);
		
		System.out.println("Sales_OrderServiceImpl detailSales sales_OrderDto-->"+sales_OrderDto);
		
		return sales_OrderDto;
	}
	
	
}
