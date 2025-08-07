package com.WiseForce.AssemERP.dao.sh;

import java.util.List;

import com.WiseForce.AssemERP.dto.sh.ProductBomDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;

public interface ProductDao {

	List<ProductDTO> findPageList(ProductDTO productDTO);

	int save(ProductBomDTO bomDTO);

	int getSearchCount(ProductDTO productDTO);

	List<ProductDTO> findSearchList(ProductDTO productDTO);

	List<ProductBomDTO> getBomList(int product_no);

	void productBOMDelete(int product_no);
	
	void productBOMUpdate(List<ProductBomDTO> list, int product_no);

	void deleteProduct(int product_no);

}
