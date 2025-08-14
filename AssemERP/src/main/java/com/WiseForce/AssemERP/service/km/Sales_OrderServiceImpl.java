package com.WiseForce.AssemERP.service.km;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.km.ClientDao;
import com.WiseForce.AssemERP.dao.km.Sales_OrderDao;
import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.Client_HisDto;
import com.WiseForce.AssemERP.dto.km.Client_PerformDto;
import com.WiseForce.AssemERP.dto.km.Sales_ItemDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderSearchDto;
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
	public List<ProductDTO> productList() {
		List<ProductDTO> productList = sales_OrderDao.productList();

		return productList;
	}

	@Override
	public void createSales(Sales_OrderDto sales_OrderDto) {
		LocalDate localDate = LocalDate.now();

		if (sales_OrderDto.getSales_Date() == null) {
			throw new IllegalArgumentException("납기 일자는 필수로 선택해야 됩니다.");
		}

		if (localDate.isAfter(sales_OrderDto.getSales_Date())) {
			throw new IllegalArgumentException("납기일은 금일보다 이전으로 설정할 수 없습니다.");
		} else {
			sales_OrderDao.createSales(sales_OrderDto);
		}
	}

	@Override
	public void modifySales(Sales_OrderDto sales_OrderDto, List<Sales_ItemDto> salesItemList) {
		int status = sales_OrderDto.getOut_Status();
		LocalDate localDate = LocalDate.now();

		if (sales_OrderDto.getSales_Date() == null) {
			throw new IllegalArgumentException("납기 일자는 필수로 선택해야 됩니다.");
		}
		
		if (localDate.isAfter(sales_OrderDto.getSales_Date())) {
			throw new IllegalArgumentException("납기일은 금일보다 이전으로 설정할 수 없습니다.");
		}

		if (status == 0 || status == 1) {
			sales_OrderDao.modifySales(sales_OrderDto, salesItemList);
		} else {
			throw new IllegalArgumentException("이미 출고 처리된 수주는 수정이 불가합니다.");
		}
	}

	@Override
	public void deleteSales(Sales_OrderDto sales_OrderDto) {
		sales_OrderDao.deleteSales(sales_OrderDto);
	}

	@Override
	public List<Sales_ItemDto> salesItemList(int sales_No) {
		List<Sales_ItemDto> salesItemList = sales_OrderDao.salesItemList(sales_No);
		return salesItemList;
	}

	@Override
	public void modifyStatus(int sales_No, List<Sales_ItemDto> salesItemList) {
		int status = sales_OrderDao.selectOutStatus(sales_No);
		Long totCost = 0L;

		switch (status) {
		case 0 -> status = 1;

		case 1 -> status = 2;

		default -> throw new IllegalArgumentException("잘못된 상태값 : " + status);
		}

		if (status == 1) {
			sales_OrderDao.modifyStatus(sales_No, status);
		} else if (status == 2) {
			sales_OrderDao.completeStatus(sales_No, status, salesItemList);
			for (Sales_ItemDto sales_ItemDto : salesItemList) {
				long cost = (long) sales_ItemDto.getSales_Item_Cost();
				totCost += cost;
			}
			Sales_OrderDto sales_OrderDto = sales_OrderDao.getCompleteDateAndClientNo(sales_No);
			System.out.println("sales_OrderDto----------------------------------------->" + sales_OrderDto);
			Client_PerformDto client_PerformDto = Client_PerformDto.builder()
					.dYearMonth(sales_OrderDto.getComplete_Date()).total_Amt(totCost)
					.client_No(sales_OrderDto.getClientDto().getClient_No()).total_Amt(totCost).build();

			System.out.println("client_PerformDto ->" + client_PerformDto);

			clinetDao.perform(client_PerformDto);
		} else {
			throw new IllegalArgumentException("잘못된 요청입니다");
		}

	}

	@Override
	public void closeCheck() {
		int closeCheck = sales_OrderDao.closeCheck();
		if (closeCheck == 1) {
			throw new IllegalArgumentException("금일 마감으로 인해 등록, 수정, 취소 불가");
		}
	}

}
