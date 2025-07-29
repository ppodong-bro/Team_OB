package com.WiseForce.AssemERP.dao.sh;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.sh.ProductDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ProductDaoImpl implements ProductDao {

	private final SqlSession session;

	@Override
	public List<ProductDTO> findPageList(ProductDTO productDTO) {
		List<ProductDTO> productDTOs = null;

		try {
			productDTOs = session.selectList("shProductPageList", productDTO);
		} catch (Exception e) {
			System.out.println("ProductDaoImpl findPageList Exception => " + e.getMessage());
		}
		System.out.println("ProductDaoImpl findPageList productDTOs => " + productDTOs);
		return productDTOs;
	}
}
