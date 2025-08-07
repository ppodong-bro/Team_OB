package com.WiseForce.AssemERP.service.sh;

import java.util.List;

import com.WiseForce.AssemERP.domain.sh.Product;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.dto.sh.ProductBomDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;



public interface ProductService {

	int getTotalCount();

	List<ProductDTO> getProductList(ProductDTO productDTO);

	List<PartsDTO> getPartsList();

	int productsave(ProductDTO productDTO);

	List<ProductDTO> getproductSearchList(ProductDTO productDTO);

	int getproductSearchcount(ProductDTO productDTO);

	ProductDTO getfindById(int product_no);

	List<ProductBomDTO> getBomInfo(int product_no);

	List<PartsDTO> findPartsByStatus(int status);

	Product productUpdate(Product product);

	void productBOMUpdate(ProductDTO productDTO);

	void deleteProduct(int product_no);

}
