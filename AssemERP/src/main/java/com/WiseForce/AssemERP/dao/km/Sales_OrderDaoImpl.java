package com.WiseForce.AssemERP.dao.km;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class Sales_OrderDaoImpl implements Sales_OrderDao {
	private final SqlSession session;
}
