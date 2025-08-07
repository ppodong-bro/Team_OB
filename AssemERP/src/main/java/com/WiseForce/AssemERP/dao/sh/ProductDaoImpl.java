package com.WiseForce.AssemERP.dao.sh;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.sh.ProductBomDTO;
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

	@Override
	public int save(ProductBomDTO bomDTO) {
		int saveresult = 0;

		try {
			saveresult = session.insert("shProductBomCreate", bomDTO);
			System.out.println("ProductDaoImpl save saveresult =>"+saveresult);
		} catch (Exception e) {
			System.out.println("ProductDaoImpl save Exception => "+e.getMessage());
		}
		return saveresult;
	}

	@Override
	public int getSearchCount(ProductDTO productDTO) {
		int totalCount = 0;
		try {
			totalCount = session.selectOne("shsearchProductCount", productDTO);
			System.out.println("ProductDaoImpl getSearchCount totalCount => "+totalCount);
		} catch (Exception e) {
			System.out.println("ProductDaoImpl getSearchCount Exception => "+e.getMessage());
		}
		return totalCount;
	}

	@Override
	public List<ProductDTO> findSearchList(ProductDTO productDTO) {
		List<ProductDTO> productDTOs = null;

		try {
			productDTOs = session.selectList("shProductSearchList", productDTO);
			System.out.println("ProductDaoImpl findSearchList productDTOs => "+productDTOs);
		} catch (Exception e) {
			System.out.println("ProductDaoImpl findSearchList Exception => "+e.getMessage());

		}

		return productDTOs;
	}

	@Override
	public List<ProductBomDTO> getBomList(int product_no) {
		List<ProductBomDTO> productBomDTOs = null;
		
		try {
			productBomDTOs = session.selectList("shGetBomList", product_no);
			System.out.println("ProductDaoImpl getBomList productBomDTOs => "+productBomDTOs);
		} catch (Exception e) {
			System.out.println("ProductDaoImpl getBomList Exception => "+e.getMessage());
		}
		
		
		return productBomDTOs;
	}

	@Override
	public void productBOMDelete(int product_no) {
		session.delete("shProductBOMDelete", product_no);
	}
	
	@Override
	public void productBOMUpdate(List<ProductBomDTO> list, int product_no) {
		
		System.out.println("ProductDaoImpl productBOMUpdate list =>"+list);
		
		for(ProductBomDTO bomDTO : list) {
			bomDTO.setProduct_no(product_no);
			System.out.println("ProductDaoImpl productBOMUpdate bomDTO => "+bomDTO);
			session.insert("shPrdouctBOMUpdate", bomDTO);
		}
		
	}

	@Override
	public void deleteProduct(int product_no) {
		session.update("shProductDelete", product_no);
		
	}

		

	

}
