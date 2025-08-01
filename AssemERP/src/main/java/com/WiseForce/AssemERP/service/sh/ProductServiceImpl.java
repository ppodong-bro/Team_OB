package com.WiseForce.AssemERP.service.sh;

import java.util.List;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.sh.ProductDao;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;
import com.WiseForce.AssemERP.repository.sh.ProductRepository;
import com.WiseForce.AssemERP.service.km.Paging;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ProductServiceImpl implements ProductService {

	private final ProductRepository productRepository;
	private final ProductDao productDao;

	@Override
	public int getTotalCount() {
		int totalCount = (int) productRepository.count();
		System.out.println("ProductServiceImpl getTotalCount totalCount => " + totalCount);

		return totalCount;
	}

	@Override
	public List<ProductDTO> getProductList(ProductDTO productDTO) {
		List<ProductDTO> productDTOs = productDao.findPageList(productDTO);
			
		for (ProductDTO dto : productDTOs) {
			// 제품상태 코드를 이름으로 변환
			dto.setProduct_statusName(productStatus_IntToString(dto.getProduct_status()));
		}

		return productDTOs;
	}
	
	// 부품상태 코드를 이름으로 변환메소드
	// common Table 변경시 수정 필요
	private String productStatus_IntToString(int status) {
		switch (status) {
		case 0 : return "DeskTop";
		case 1 : return "NoteBook";
		case 2 : return "WorkStation";
		default: return "";
		}
	}

}
