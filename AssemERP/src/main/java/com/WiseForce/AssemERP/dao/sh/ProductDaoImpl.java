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
			System.out.println("ProductDaoImpl findPageList productDTOs => " + productDTOs.size());
		} catch (Exception e) {
			System.out.println("ProductDaoImpl findPageList Exception => " + e.getMessage());
		}
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
			System.out.println("ProductDaoImpl findSearchList productDTOs => "+productDTOs.size());
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
			System.out.println("ProductDaoImpl getBomList productBomDTOs => "+productBomDTOs.size());
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
		
		System.out.println("ProductDaoImpl productBOMUpdate list =>"+list.size());
		
		try {
			// 제품BOM 버전찾기
			int product_version = session.selectOne("shProductBOMFindVersion", product_no);
			System.out.println(" ProductDaoImpl productBOMUpdate product_version => "+product_version);
			// 제품번호 / 버전주입
			for(ProductBomDTO bomDTO : list) {
				bomDTO.setProduct_no(product_no);
				bomDTO.setProduct_version(product_version+1);
				System.out.println("ProductDaoImpl productBOMUpdate bomDTO => "+bomDTO);
				session.insert("shPrdouctBOMUpdate", bomDTO);
			}
			
		} catch (Exception e) {
			System.out.println("ProductDaoImpl productBOMUpdate Exception => "+e.getMessage());
		}
		
	}

	@Override
	public void deleteProduct(int product_no) {
		session.update("shProductDelete", product_no);
		
	}

	@Override
	public int getTotalProduct() {
		int result = 0;
		
		try {
			result = session.selectOne("shProductTotalCount");
			System.out.println("ProductDaoImpl getTotalProduct result => "+result);
		} catch (Exception e) {
			System.out.println("ProductDaoImpl getTotalProduct Exception => "+e.getMessage());
		}
		
		return result;
	}

	@Override
	public int getProductRecentCost(int product_no) {
		double recent_cost = 0;
		
		try {
			recent_cost = session.selectOne("shProductRecentCost", product_no);
			System.out.println("ProductDaoImpl getProductRecentCost recent_cost => "+recent_cost);
		} catch (Exception e) {
			System.out.println("ProductDaoImpl getProductRecentCost Exception => "+e.getMessage());
		}
		
		return (int) recent_cost;
	}

	@Override
	public int getProductRecentTradeCnt(int product_no) {
		int tradeCnt = 0;
		
		try {
			tradeCnt = session.selectOne("shProductRecentTradeCnt", product_no);
			System.out.println("ProductDaoImpl getProductRecentTradeCnt tradeCnt => "+tradeCnt);
		} catch (Exception e) {
			System.out.println("ProductDaoImpl getProductRecentTradeCnt Exception => "+e.getMessage());
		}
		
		
		return tradeCnt;
	}

	@Override
	public List<ProductDTO> searchByName(String keyword) {
		List<ProductDTO> result = null;
		System.out.println("ProductDaoImpl searchByName keyword =>"+keyword);
		
		try {
			result = session.selectList("shSearchByProductName", keyword);
			System.out.println("ProductDaoImpl searchByName result => "+result);
		} catch (Exception e) {
			System.out.println("ProductDaoImpl searchByName Exception =>"+e.getMessage());
		}
		
		return result;
	}

	

	

}
