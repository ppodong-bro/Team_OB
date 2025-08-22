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
			
			System.out.println("cnt="+cnt);
			System.out.println("incnt="+inCnt);
			int waitingCnt = cnt - inCnt;
			System.out.println("cnt-inCnt="+waitingCnt);
			Long cost1 = cnt*cost; 
			Long cost2 = inCnt*cost;
			
			purchase_ItemDto.setPurchase_Item_TotCost(cost1);
			purchase_ItemDto.setPurchase_Item_TotInCost(cost2);
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
	public List<PartsDTO> partsPop(String parts_Name){
		List<PartsDTO> listParts = purchase_OrderDao.partsPop(parts_Name);
		return listParts;
	}

	@Override
	public String createPurchase(Purchase_OrderDto purchase_OrderDto) {
		
		int result = purchase_OrderDao.createPurchase(purchase_OrderDto);
		
		if(result == 1) {
			String success = "발주 등록 성공";
			return success;
		} else if(result == 0) {
			String fail = "발주 등록 실패";
			return fail;
		} else {
			throw new IllegalArgumentException("잘못된 요청");
		}
		
		/*
		 * List<Purchase_ItemDto> purchase_ItemDto =
		 * purchase_OrderDto.getPurchase_Item();
		 * purchase_OrderDao.createPurchaseItem(purchase_ItemDto);
		 */
		
		
	}

	@Override
	public void checkClose() {
		int checkClose = purchase_OrderDao.checkClose();
		if(checkClose == 1) {
			throw new IllegalArgumentException("금일 마감으로 인해 발주 등록, 수정, 취소 불가");
		}
	}

	@Override
	public String modifyPurchase(Purchase_OrderDto purchase_OrderDto) {
		int purchase_No = purchase_OrderDto.getPurchase_No();
		List<Purchase_ItemDto> purchaseItem = purchase_OrderDao.getPurchaseItem(purchase_No);
		purchase_OrderDao.deletePurchaseItem(purchaseItem);
		
		int result = purchase_OrderDao.modifyPurchase(purchase_OrderDto);
		
		if(result == 1) {
			String success = "발주 수정 성공";
			return success;
		} else if (result == 0) {
			String fail = "발주 수정 실패";
			return fail;
		} else {
			throw new IllegalArgumentException("잘못된 요청");
		}
	}

	@Override
	public String modifyStatus(int purchase_No) {
		int in_Status = purchase_OrderDao.getInStatus(purchase_No);
		List<Integer> parts_no = purchase_OrderDao.getPartsNo(purchase_No);
		System.out.println("in_Status"+in_Status);
		switch(in_Status) {
		
		case 0 -> in_Status = 1;
		
		case 1 -> in_Status = 2;
		
		}
		System.out.println("in_Status1"+in_Status);
		if (in_Status == 1) {
			int result = purchase_OrderDao.modifyStatus(purchase_No, in_Status);
			
			if(result == 1) {
				String success = "발주 승인 성공";
				return success;
			} else if(result == 0) {
				String fail = "발주 승인 실패";
				return fail;
			} else {
				throw new IllegalArgumentException("잘못된 요청");
			}
			
			
		} else if(in_Status == 2) {
			int result = purchase_OrderDao.modifyComplete(purchase_No, in_Status, parts_no);
			
			if(result == 1) {
				String success = "발주 완료 성공";
				return success;
			} else if(result == 0) {
				String fail = "발주 완료 실패";
				return fail;
			} else {
				throw new IllegalArgumentException("잘못된 요청");
			}
		} else {
			throw new IllegalArgumentException("잘못된 요청");
		}
		
	}

	@Override
	public String returnInStatus(int purchase_No) {
		Integer in_Status = purchase_OrderDao.getInStatus(purchase_No);
		
		if(in_Status != null) {
			switch(in_Status) {
			
			case 2 -> in_Status = 1;
			
			case 1 -> in_Status = 0;
			
			
			}
			
		}else {
			throw new IllegalArgumentException("잘못된 입고 상태값");
		}
			
		if(in_Status == 1) {
			List<Purchase_ItemDto> listPurchaseItem = purchase_OrderDao.getPurchaseItem(purchase_No);
			System.out.println("List<Purchase_ItemDto> listPurchaseItem"+listPurchaseItem);
			
			int result = purchase_OrderDao.returnInStatus(purchase_No, in_Status);
			int itemReusult = purchase_OrderDao.returnPurchaseItem(purchase_No, listPurchaseItem);
			
			if(result == 1) {
				String success = "발주 완료 취소 성공";
				return success;
			} else if(result == 0) {
				String fail = "발주 완료 취소 실패";
				return fail;
			} else {
				throw new IllegalArgumentException("잘못된 요청");
			}
			
		} else if(in_Status ==0) {
			int result = purchase_OrderDao.returnInStatus(purchase_No, in_Status);
			
			if(result == 1) {
				String success = "발주 승인 취소 성공";
				return success;
			} else if (result == 0) {
				String fail = "발주 승인 취소 실패";
				return fail;
			} else {
				throw new IllegalArgumentException("잘못된 요청");
			}
			
		} else {
			throw new IllegalArgumentException("잘못된 입고 상태값");
		}
	}

	@Override
	public String deletePurchase(int purchase_No) {
//		List<Purchase_ItemDto> purchaseItemList = purchase_OrderDao.getPurchaseItem(purchase_No);
		Purchase_OrderDto purchase_OrderDto = purchase_OrderDao.detailPurchase(purchase_No);
		
		System.out.println("purchase_OrderDto->"+purchase_OrderDto);
		
		int result = purchase_OrderDao.deletePurchase(purchase_No);
		
		if(result == 1) {
			String success = "발주 삭제 성공";
			return success;
		} else if(result == 0) {
			String fail = "발주 삭제 실패";
			return fail;
		} else {
			throw new IllegalArgumentException("잘못된 요청");
		}
		
	}

}
