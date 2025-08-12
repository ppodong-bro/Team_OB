package com.WiseForce.AssemERP.service.km;

import java.util.List;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.km.Purchase_OrderDao;
import com.WiseForce.AssemERP.dto.km.Purchase_ItemDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderSearchDto;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Transactional
@Service
public class Purchase_OrderServiceImpl implements Purchase_OrderService {
	private final Purchase_OrderDao purchase_OrderDao;
	
	@Override
	public int totPurchase(Purchase_OrderSearchDto purchase_OrderSearchDto) {
		int totCnt = purchase_OrderDao.totPurchase(purchase_OrderSearchDto);
		return totCnt;
	}

	@Override
	public List<Purchase_OrderDto> listPurchaseOrder(Purchase_OrderSearchDto purchase_OrderSearchDto) {
		System.out.println("purchase_OrderSearchDto-->"+purchase_OrderSearchDto);
		List<Purchase_OrderDto> listPurchase = purchase_OrderDao.listPurchaseOrder(purchase_OrderSearchDto);
		System.out.println("listPurchase-->"+listPurchase);
		
		
		for(Purchase_OrderDto purchase_OrderDto : listPurchase) {
			List<Purchase_ItemDto> itemList = purchase_OrderDto.getPurchase_Item();
			
			Long totCost  = 0L;
			int	 totCnt   = 0;
			int	 totInCnt = 0;
			
			for(Purchase_ItemDto purchase_ItemDto : itemList) {
				int cnt = purchase_ItemDto.getPurchase_Item_Cnt();
				int inCnt = purchase_ItemDto.getPurchase_Item_InCnt();
				Long cost = purchase_ItemDto.getPurchase_Item_Cost();
				
				
				totCost += cnt*cost;
				totCnt  += cnt;
				totInCnt += inCnt;
			}
			purchase_OrderDto.setTotCost(totCost);
			purchase_OrderDto.setTotCnt(totCnt);
			purchase_OrderDto.setTotInCnt(totInCnt);
		}
		return listPurchase;
	}

}
