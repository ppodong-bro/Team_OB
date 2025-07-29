package com.WiseForce.AssemERP.service.sh;

import java.util.List;

import com.WiseForce.AssemERP.dto.sh.ProductDTO;

public interface ProductService {

	int getTotalCount();

	List<ProductDTO> getProductList(ProductDTO productDTO);

}
