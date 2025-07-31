package com.WiseForce.AssemERP.service.km;

import java.util.List;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.km.Sales_OrderDao;
import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;

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
		System.out.println("Sales_OrderService salesList Start...");
		List<Sales_OrderDto> salesList = sales_OrderDao.salesList(sales_OrderDto);
		System.out.println("Sales_OrderService salesList salesList-->"+salesList);
		return salesList;
	}
}
