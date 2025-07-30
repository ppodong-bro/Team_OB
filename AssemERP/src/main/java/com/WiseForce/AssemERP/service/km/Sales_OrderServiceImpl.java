package com.WiseForce.AssemERP.service.km;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.km.Sales_OrderDao;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Transactional
@Service
public class Sales_OrderServiceImpl implements Sales_OrderService {
	private final Sales_OrderDao sales_OrderDao;
}
