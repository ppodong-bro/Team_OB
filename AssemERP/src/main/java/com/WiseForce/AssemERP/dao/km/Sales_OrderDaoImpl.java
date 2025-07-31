package com.WiseForce.AssemERP.dao.km;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class Sales_OrderDaoImpl implements Sales_OrderDao {
	private final SqlSession session;

	@Override
	public int salesTotCnt() {
		int totCnt = session.selectOne("salesTotCnt");
		return totCnt;
	}

	@Override
	public List<Sales_OrderDto> salesList(Sales_OrderDto sales_OrderDto) {
		System.out.println("Sales_OrderDaoImpl salesList Start...");
		List<Sales_OrderDto> listSales = session.selectList("salesList", sales_OrderDto);
		System.out.println("Sales_OrderDaoImpl salesList listSales-->"+listSales);
		return listSales;
	}
}
