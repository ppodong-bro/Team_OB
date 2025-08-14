package com.WiseForce.AssemERP.service.km;

import java.util.List;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.km.Purchase_OrderDao;
import com.WiseForce.AssemERP.dto.km.Purchase_ItemDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderSearchDto;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;

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

	@Override
	public Purchase_OrderDto detailPurchase(int purchase_No) {
		Purchase_OrderDto purchase_OrderDto = purchase_OrderDao.detailPurchase(purchase_No);
		
		int totCnt = 0;
		int	totInCnt = 0;
		int totWaitingCnt = 0;
		Long totCost = 0L;
		Long totInCost = 0L;
		
		
		for(Purchase_ItemDto purchase_ItemDto : purchase_OrderDto.getPurchase_Item()) {
			int cnt = purchase_ItemDto.getPurchase_Item_Cnt();
			int inCnt = purchase_ItemDto.getPurchase_Item_InCnt();
			Long cost = purchase_ItemDto.getPurchase_Item_Cost();
			
			int waitingCnt = cnt - inCnt;
			Long cost1 = cnt*cost; 
			Long cost2 = inCnt*cost;
			
			purchase_ItemDto.setPurchase_Item_TotCost(cost1);
			purchase_ItemDto.setPurchase_Item_TotInCost(cost2);
			purchase_ItemDto.setPurchase_Item_WaitingCnt(purchase_No);
			purchase_ItemDto.setPurchase_Item_WaitingCnt(waitingCnt);
			
			
			totCnt += cnt;
			totInCnt += inCnt;
			totCost += cost*cnt;
			totInCost += cost*inCnt;
			totWaitingCnt += waitingCnt;
			
		}
		
		purchase_OrderDto.setTotCnt(totCnt);
		purchase_OrderDto.setTotInCnt(totInCnt);
		purchase_OrderDto.setTotWaitingCnt(totWaitingCnt);
		purchase_OrderDto.setTotCost(totCost);
		purchase_OrderDto.setTotInCost(totInCost);
		
		
		
		
		return purchase_OrderDto;
	}

	@Override
	public List<PartsDTO> partsPop() {
		List<PartsDTO> listParts = purchase_OrderDao.partsPop();
		return listParts;
	}

	@Override
	public void createPurchase(Purchase_OrderDto purchase_OrderDto) {
		purchase_OrderDao.createPurchase(purchase_OrderDto);
		/*
		 * List<Purchase_ItemDto> purchase_ItemDto =
		 * purchase_OrderDto.getPurchase_Item();
		 * purchase_OrderDao.createPurchaseItem(purchase_ItemDto);
		 */
		
		
	}

}
