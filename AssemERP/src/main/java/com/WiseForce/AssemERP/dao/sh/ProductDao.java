package com.WiseForce.AssemERP.dao.sh;

import java.util.List;

import com.WiseForce.AssemERP.dto.sh.ProductBomDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;

public interface ProductDao {

	List<ProductDTO> findPageList(ProductDTO productDTO);

	int save(ProductBomDTO bomDTO);

	int getSearchCount(ProductDTO productDTO);

	List<ProductDTO> findSearchList(ProductDTO productDTO);

}
