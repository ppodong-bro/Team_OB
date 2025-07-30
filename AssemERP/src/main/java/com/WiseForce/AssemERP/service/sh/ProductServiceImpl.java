package com.WiseForce.AssemERP.service.sh;

import java.time.LocalDateTime;
import java.util.List;


import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.sh.PartsDao;
import com.WiseForce.AssemERP.dao.sh.ProductDao;
import com.WiseForce.AssemERP.domain.sh.Product;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.dto.sh.ProductBomDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;
import com.WiseForce.AssemERP.repository.sh.ProductRepository;


import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ProductServiceImpl implements ProductService {

	private final ProductRepository productRepository;
	private final ProductDao productDao;
	private final PartsDao partsDao;
	
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
		case 0 : return "데스크탑";
		case 1 : return "노트북";
		case 2 : return "워크스테이션";
		default: return "";
		}
	}

	@Override
	public List<PartsDTO> getPartsList() {
		
		
		return partsDao.findAllPartsList();
	}

	@Override
	public int productsave(ProductDTO productDTO) {
		// emp 임시적용
		productDTO.setEmp_no(1001);
		if(productDTO.getIn_date()==null) productDTO.setIn_date(LocalDateTime.now());
		productDTO.setDel_status(0);
		Product product = productDTO.changeProduct();
		
		Product product2 = productRepository.save(product);
		productRepository.flush();
		int saveresult = 0;
		
		List<ProductBomDTO> productBomDTOs = productDTO.getProductBOM();
		for(ProductBomDTO bomDTO : productBomDTOs) {
			bomDTO.setProduct_no(product2.getProduct_no());
			System.out.println("ProductServiceImpl productsave bomDTO  => "+bomDTO);
			saveresult = productDao.save(bomDTO);
			saveresult++;
		}
		
		
		return saveresult;
	}

}
