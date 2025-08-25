package com.WiseForce.AssemERP.service.km;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.km.ClientDao;
import com.WiseForce.AssemERP.dao.km.Sales_OrderDao;
import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.Client_HisDto;
import com.WiseForce.AssemERP.dto.km.PartsShortageDto;
import com.WiseForce.AssemERP.dto.km.Sales_ItemDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderSearchDto;
import com.WiseForce.AssemERP.dto.sh.ProductBomDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;
import com.oracle.wls.shaded.org.apache.bcel.generic.RETURN;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Transactional
@Service
@Slf4j
public class Sales_OrderServiceImpl implements Sales_OrderService {
	private final Sales_OrderDao sales_OrderDao;
	private final ClientDao clinetDao;

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

		for (Sales_OrderDto sales_OrderDto : salesList) {

			List<Sales_ItemDto> itemList = sales_OrderDto.getSales_Item();

			Long totCost = 0L;
			Long totOutCost = 0L;
			int totCnt = 0;
			int totOutCnt = 0;

			for (Sales_ItemDto sales_ItemDto : itemList) {
				System.out.println("sales_ItemDto->" + sales_ItemDto);
				int cnt = sales_ItemDto.getSales_Item_Cnt();
				int out_Cnt = sales_ItemDto.getSales_Item_OutCnt();
				Long cost = sales_ItemDto.getSales_Item_Cost();

				totCnt += cnt;
				totOutCnt += out_Cnt;
				totCost += cost * cnt;
				totOutCost += cost * out_Cnt;

			}

			sales_OrderDto.setTotCnt(totCnt);
			sales_OrderDto.setTotOutCnt(totOutCnt);
			sales_OrderDto.setTotCost(totCost);
			sales_OrderDto.setTotOutCost(totOutCost);

		}
		System.out.println("salesList------>" + salesList);

		return salesList;
	}

	@Override
	public Sales_OrderDto detailSales(Sales_OrderDto sales_OrderDto1) {
		Sales_OrderDto sales_OrderDto = sales_OrderDao.detailSales(sales_OrderDto1);

		Long totCost = 0L;
		Long totOutCost = 0L;
		int totCnt = 0;
		int totOutCnt = 0;
		int totWaitingCnt = 0;

		for (Sales_ItemDto sales_ItemDto : sales_OrderDto.getSales_Item()) {

			Long cost = sales_ItemDto.getSales_Item_Cost();
			int cnt = sales_ItemDto.getSales_Item_Cnt();
			int out_Cnt = sales_ItemDto.getSales_Item_OutCnt();

			Long itemTotCost = cost * cnt;
			Long itemTotOutCost = cost * out_Cnt;
			int itemWaitingCnt = cnt - out_Cnt;

			sales_ItemDto.setSales_Item_TotCost(itemTotCost);
			sales_ItemDto.setSales_Item_TotOutCost(itemTotOutCost);
			sales_ItemDto.setSales_Item_WaitingCnt(itemWaitingCnt);

			totCost += cost * cnt;
			totOutCost += cost * out_Cnt;
			totCnt += cnt;
			totOutCnt += out_Cnt;
			totWaitingCnt += itemWaitingCnt;

		}

		sales_OrderDto.setTotCost(totCost);
		sales_OrderDto.setTotOutCost(totOutCost);
		sales_OrderDto.setTotCnt(totCnt);
		sales_OrderDto.setTotOutCnt(totOutCnt);
		sales_OrderDto.setTotWaitingCnt(totWaitingCnt);

		System.out.println("Sales_OrderServiceImpl detailSales sales_OrderDto-->" + sales_OrderDto);

		return sales_OrderDto;
	}

	@Override
	public List<ProductDTO> productList(String product_Name) {
		List<ProductDTO> productList = sales_OrderDao.productList(product_Name);

		return productList;
	}

	@Override
	public int createSales(Sales_OrderDto sales_OrderDto) {
		LocalDate localDate = LocalDate.now();

		if (sales_OrderDto.getSales_Date() == null) {
			throw new IllegalArgumentException("납기 일자는 필수로 선택해야 됩니다.");
		}

		if (localDate.isAfter(sales_OrderDto.getSales_Date())) {
			throw new IllegalArgumentException("납기일은 금일보다 이전으로 설정할 수 없습니다.");
		} else {
			int result = sales_OrderDao.createSales(sales_OrderDto);
			
			return result;
		}
	}

	@Override
	public String modifySales(Sales_OrderDto sales_OrderDto, List<Sales_ItemDto> salesItemList) {
		int status = sales_OrderDto.getOut_Status();
		LocalDate localDate = LocalDate.now();

		if (sales_OrderDto.getSales_Date() == null) {
			throw new IllegalArgumentException("납기 일자는 필수로 선택해야 됩니다.");
		}

		if (localDate.isAfter(sales_OrderDto.getSales_Date())) {
			throw new IllegalArgumentException("납기일은 금일보다 이전으로 설정할 수 없습니다.");
		}

		if (status == 0 || status == 1) {
			int result = sales_OrderDao.modifySales(sales_OrderDto, salesItemList);
			
			if(result == 1) {
				String success = "수주 수정 성공";
				return success;
			} else if (result == 0) {
				String fail = "수주 수정 실패";
				return fail;
			} else {
				throw new IllegalArgumentException("잘못된 요청");
			}
		} else {
			throw new IllegalArgumentException("이미 출고 처리된 수주는 수정이 불가합니다.");
		}
	}

	@Override
	public String deleteSales(Sales_OrderDto sales_OrderDto) {
		int result = sales_OrderDao.deleteSales(sales_OrderDto);
		if(result == 1) {
			String success = "수주 삭제 성공";
			return success;
		} else if (result == 0) {
			String fail = "수주 삭제 실패";
			return fail;
		} else {
			throw new IllegalArgumentException("잘못된 요청");
		}
		
	}

	@Override
	public List<Sales_ItemDto> salesItemList(int sales_No) {
		List<Sales_ItemDto> salesItemList = sales_OrderDao.salesItemList(sales_No);
		return salesItemList;
	}

	@Override
	public String modifyStatus(int sales_No, List<Sales_ItemDto> salesItemList) {
		int status = sales_OrderDao.selectOutStatus(sales_No);
		Long totCost = 0L;

		switch (status) {
		case 0 -> status = 1;

		case 1 -> status = 2;

		default -> throw new IllegalArgumentException("잘못된 상태값 : " + status);
		}

		if (status == 1) {
			
			int result = sales_OrderDao.modifyStatus(sales_No, status);
			
			if(result == 1) {
				String success = "수주 승인 성공";
				return success;
			} else if(result == 0) {
				String fail = "수주 승인 실패";
				return fail;
			} else {
				throw new IllegalArgumentException("잘못된 요청입니다");
			}
			
			} else if (status == 2) {
			
			int result = sales_OrderDao.completeStatus(sales_No, status, salesItemList);
			
//			
//			List<Sales_ItemDto> items = sales_OrderDao.salesItemList(sales_No);
//			
//			for (Sales_ItemDto sales_ItemDto : items) {
//
//				long cost = (long) sales_ItemDto.getSales_Item_Cost();
//				int	 outCnt  = sales_ItemDto.getSales_Item_OutCnt();
//				
//				totCost += cost*outCnt;
//				
//			}
//			System.out.println("totCost??????????????????????????->"+totCost);
//			Sales_OrderDto sales_OrderDto = sales_OrderDao.getCompleteDateAndClientNo(sales_No);
//			System.out.println("sales_OrderDto----------------------------------------->" + sales_OrderDto);
//			Client_PerformDto client_PerformDto = Client_PerformDto.builder()
//																   .dYearMonth(sales_OrderDto.getComplete_Date())
//																   .total_Amt(totCost)
//																   .client_No(sales_OrderDto.getClientDto().getClient_No())
//																   .build();
//
//			System.out.println("client_PerformDto ->" + client_PerformDto);
//
//			int result = clinetDao.perform(client_PerformDto);
			
			if(result == 1) {
				String success = "수주 완료 성공";
				return success;
			} else if(result == 0) {
				String fail = "수주 완료 실패";
				return fail;
			} else {
				throw new IllegalArgumentException("잘못된 요청입니다");
			}
			
			
		} else {
			throw new IllegalArgumentException("잘못된 요청입니다");
		}

	}

	@Override
	public void closeCheck() {
		int closeCheck = sales_OrderDao.closeCheck();
		if (closeCheck == 1) {
			throw new IllegalArgumentException("금일 마감으로 인해 수주 등록, 수정, 취소 불가");
		}
	}

	@Override
	public void accessModify(Sales_OrderDto sales_OrderDto) {
		int out_Status = sales_OrderDto.getOut_Status();
		int sales_No = sales_OrderDto.getSales_No();
		
		if (out_Status == 1) {

			switch (out_Status) {

			case 1 -> out_Status = 0;

			}

		} else {
			throw new IllegalArgumentException("잘못된 출고 상태");
		}

		sales_OrderDao.modifyStatus(sales_No, out_Status);
	}

	@Override
	public String returnStatus(int sales_No) {
		int out_Status = sales_OrderDao.selectOutStatus(sales_No);
		
		if(out_Status == 1 || out_Status == 2 ) {
			
			switch(out_Status) {
			
			case 2 -> out_Status = 1;
			
			case 1 -> out_Status = 0;
			
			}
		} else {
				throw new IllegalArgumentException("잘못된 출고 상태");
			}
				
		if(out_Status == 1) {
//			Sales_OrderDto sales_OrderDto = sales_OrderDao.getCompleteDateAndClientNo(sales_No);
			List<Sales_ItemDto> listSalesItem = sales_OrderDao.salesItemList(sales_No);
//			Long totCost = 0L;
			
//			System.out.println("Sales_OrderDto sales_OrderDto"+sales_OrderDto);
//			
//			for(Sales_ItemDto sales_ItemDto : listSalesItem) {
//				Long cost = sales_ItemDto.getSales_Item_Cost();
//				int	 outCnt = sales_ItemDto.getSales_Item_OutCnt();
//				
//				totCost += cost*outCnt;
//			}
//			Client_PerformDto client_PerformDto = Client_PerformDto.builder()
//																   .client_No(sales_OrderDto.getClientDto().getClient_No())
//																   .dYearMonth(sales_OrderDto.getComplete_Date())
//																   .total_Amt(totCost)
//																   .build()
//																   ;
//			clinetDao.returnPerform(client_PerformDto);
			
			int result = sales_OrderDao.returnComplete(out_Status, sales_No, listSalesItem);
			
			if (result == 1) {
				String success = "수주 완료 취소 성공";
				return success;
			} else if (result == 0) {
				String fail = "수주 완료 취소 실패";
				return fail;
			} else {
				throw new IllegalArgumentException("잘못된 요청");
			}
			
			
		} else if( out_Status == 0){
			
			int result = sales_OrderDao.modifyStatus(sales_No, out_Status);
			
			if(result == 1) {
				String success = "수주 승인 취소 성공";
				return success;
			} else if(result == 0) {
				String fail = "수주 승인 취소 실패";
				return fail;
			} else {
				throw new IllegalArgumentException("잘못된 요청");
			}
			
		
		} else {
			throw new IllegalArgumentException("잘못된 출고 상태 ");
		}

	}

	@Override
	public List<PartsShortageDto> shortages(Sales_OrderDto sales_OrderDto) {
		   Map<Integer, PartsShortageDto> requiredMap = new LinkedHashMap<>();

		    // 1) 수주 품목 없으면 끝
		    List<Sales_ItemDto> items = sales_OrderDto.getSales_Item();
		    if (items == null || items.isEmpty()) return Collections.emptyList();

		    // 2) 제품별 BOM 필요수량 누적
		    for (Sales_ItemDto li : items) {
		        int productNo = li.getProduct_No();
		        int version   = li.getProduct_Version();
		        int orderQty  = Math.max(0, li.getSales_Item_Cnt());

		        List<ProductBomDTO> bomLines = sales_OrderDao.findBomByProduct(productNo, version);
		        if (bomLines == null || bomLines.isEmpty()) continue;

		        for (ProductBomDTO bom : bomLines) {
		            Integer partsNoObj = bom.getParts_no();
		            if (partsNoObj == null) continue;

		            int partsNo = partsNoObj;
		            int bomCnt  = Math.max(0, (bom.getCnt() == null ? 0 : bom.getCnt()));
		            int need    = bomCnt * orderQty;

		            PartsShortageDto acc = requiredMap.get(partsNo);
		            if (acc == null) {
		                acc = PartsShortageDto.builder()
		                        .parts_no(partsNo)
		                        .parts_name(bom.getParts_name())
		                        .required_cnt(need)
		                        .available_cnt(0)
		                        .shortage_cnt(0)
		                        .build();
		                requiredMap.put(partsNo, acc);
		            } else {
		                acc.setRequired_cnt(acc.getRequired_cnt() + need);
		            }
		        }
		    }

		    // 필요량이 없으면 종료
		    if (requiredMap.isEmpty()) return Collections.emptyList();

		    // 3) 재고 조회
		    List<Integer> partsNos = new ArrayList<>(requiredMap.keySet());
		    List<Map<String, Object>> stockList = sales_OrderDao.findPartsStocks(partsNos);
		    if (stockList == null) stockList = Collections.emptyList();

		    Map<Integer, Integer> stocks = new HashMap<>();
		    for (Map<String, Object> m : stockList) {
		        int k = toInt(m.get("parts_no")); // XML에서 반드시 AS parts_no
		        int v = toInt(m.get("stock"));    // XML에서 반드시 AS stock
		        // 중복 키가 나오면 최초 값 유지(필요하면 v를 누적하도록 바꿔도 됨)
		        if (!stocks.containsKey(k)) stocks.put(k, v);
		    }

		    // 4) 부족 계산
		    List<PartsShortageDto> result = new ArrayList<>();
		    for (PartsShortageDto row : requiredMap.values()) {
		        int available = Math.max(0, stocks.getOrDefault(row.getParts_no(), 0)); // ✅ 한 번만 조회
		        row.setAvailable_cnt(available);

		        int shortage = row.getRequired_cnt() - available;
		        if (shortage > 0) {
		            row.setShortage_cnt(shortage);
		            result.add(row);
		        }
		    }
		    return result;
		}
	
//	@Override
//	public List<PartsShortageDto> shortages(Sales_OrderDto order) {
//	    Map<Integer, PartsShortageDto> requiredMap = new LinkedHashMap<>();
//	    List<Sales_ItemDto> items = order.getSales_Item();
//	    if (items == null || items.isEmpty()) return Collections.emptyList();
//
//	    // 주문에 포함된 제품 번호 수집
//	    Set<Integer> productNos = new LinkedHashSet<>();
//	    for (Sales_ItemDto li : items) {
//	        productNos.add(li.getProduct_No());
//	    }
//
//	    // 완제품 재고 조회(제품번호 단위, 버전 구분 없음)
//	    Map<Integer, Integer> fgStockRemain = new HashMap<>();
//	    for (Map<String,Object> m : sales_OrderDao.findProductStocks(new ArrayList<>(productNos))) {
//	        int productNo = toInt(m.get("product_no"));
//	        int stock     = Math.max(0, toInt(m.get("stock")));
//	        fgStockRemain.put(productNo, stock);
//	    }
//
//	    // 각 라인에 대해: 완제품 재고로 먼저 충당 → 남은 수량(toBuild)만 BOM 필요량으로 누적
//	    for (Sales_ItemDto li : items) {
//	        int productNo = li.getProduct_No();
//	        int version   = li.getProduct_Version();
//	        int orderQty  = Math.max(0, li.getSales_Item_Cnt());
//
//	        int haveFG   = Math.max(0, fgStockRemain.getOrDefault(productNo, 0));
//	        int allocate = Math.min(haveFG, orderQty); // 완제품으로 충당
//	        int toBuild  = orderQty - allocate;        // 만들어야 할 수량
//
//	        if (allocate > 0) fgStockRemain.put(productNo, haveFG - allocate);
//	        if (toBuild <= 0) continue; // 전량 완제품으로 커버됨 → 부품 필요 없음
//
//	        List<ProductBomDTO> bomLines = sales_OrderDao.findBomByProduct(productNo, version);
//	        if (bomLines == null || bomLines.isEmpty()) continue;
//
//	        for (ProductBomDTO bom : bomLines) {
//	            Integer partsNoObj = bom.getParts_no();
//	            if (partsNoObj == null) continue;
//	            int partsNo = partsNoObj;
//	            int bomCnt  = Math.max(0, (bom.getCnt() == null ? 0 : bom.getCnt()));
//	            int need    = bomCnt * toBuild; // ★ 주문수량이 아니라 toBuild만큼만
//
//	            PartsShortageDto acc = requiredMap.get(partsNo);
//	            if (acc == null) {
//	                acc = PartsShortageDto.builder()
//	                        .parts_no(partsNo)
//	                        .parts_name(bom.getParts_name())
//	                        .required_cnt(need)
//	                        .available_cnt(0)
//	                        .shortage_cnt(0)
//	                        .build();
//	                requiredMap.put(partsNo, acc);
//	            } else {
//	                acc.setRequired_cnt(acc.getRequired_cnt() + need);
//	            }
//	        }
//	    }
//
//	    if (requiredMap.isEmpty()) return Collections.emptyList();
//
//	    // 부품 재고 조회 후 부족 계산 (기존 로직 유지)
//	    List<Integer> partsNos = new ArrayList<>(requiredMap.keySet());
//	    List<Map<String, Object>> stockList = sales_OrderDao.findPartsStocks(partsNos);
//	    Map<Integer, Integer> partsStocks = new HashMap<>();
//	    if (stockList != null) {
//	        for (Map<String, Object> m : stockList) {
//	            partsStocks.put(toInt(m.get("parts_no")), Math.max(0, toInt(m.get("stock"))));
//	        }
//	    }
//
//	    List<PartsShortageDto> result = new ArrayList<>();
//	    for (PartsShortageDto row : requiredMap.values()) {
//	        int available = partsStocks.getOrDefault(row.getParts_no(), 0);
//	        row.setAvailable_cnt(available);
//	        int shortage = row.getRequired_cnt() - available;
//	        if (shortage > 0) {
//	            row.setShortage_cnt(shortage);
//	            result.add(row);
//	        }
//	    }
//	    return result;
//	}

	// 공통 변환
	private static int toInt(Object n) {
	    if (n == null) return 0;
	    if (n instanceof Number) return ((Number) n).intValue();
	    try { return Integer.parseInt(n.toString()); } catch (Exception e) { return 0; }
	}
}
