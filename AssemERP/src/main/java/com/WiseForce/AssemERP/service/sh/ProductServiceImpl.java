package com.WiseForce.AssemERP.service.sh;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.WiseForce.AssemERP.dao.sh.PartsDao;
import com.WiseForce.AssemERP.dao.sh.ProductDao;
import com.WiseForce.AssemERP.domain.sh.Product;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.dto.sh.ProductBomDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;
import com.WiseForce.AssemERP.repository.dg.EmpRepository;
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
	private final PlatformTransactionManager platformTransactionManager;
	private final EmpRepository empRepository;

	@Override
	public int getTotalCount() {
		int totalCount = productDao.getTotalProduct();
		System.out.println("ProductServiceImpl getTotalCount totalCount => " + totalCount);

		return totalCount;
	}

	@Override
	public List<ProductDTO> getProductList(ProductDTO productDTO) {
		List<ProductDTO> productDTOs = productDao.findPageList(productDTO);

		for (ProductDTO dto : productDTOs) {
			// 사원상태 코드를 이름으로 변환
			dto.setEmp_name(empRepository.getEmpNameFromEmpNo(dto.getEmp_no()));
			// 제품상태 코드를 이름으로 변환
			dto.setProduct_statusName(productStatus_IntToString(dto.getProduct_status()));
		}

		return productDTOs;
	}

	@Override
	public List<PartsDTO> getPartsList() {
		List<PartsDTO> partsDTOs = partsDao.findAllPartsList();
		
		// 부품상태 코드를 이름으로 변환
		for (PartsDTO dto : partsDTOs) {
			dto.setParts_statusName(partsStatus_IntToString(dto.getParts_status()));
		}
		return partsDTOs;
	}

	@Override
	public int productsave(ProductDTO productDTO) {
		
		// DATE설정값이 null일경우 당일날짜 저장
		if (productDTO.getIn_date() == null) {
			productDTO.setIn_date(LocalDate.now());
		}
				
		productDTO.setDel_status(0);
		
		// ProductDTO -> product 변경(ProductDTO.class 참조)
		Product product = productDTO.changeProduct();

		// JPA 이용 Entity 저장
		product = productRepository.save(product);
		
		// BOM 저장 전 PK저장을 위한 쿼리전송 => product_no 생성
		productRepository.flush();
		
		int saveresult = 0;

		System.out.println(
				"ProductServiceImpl productsave productDTO.getproductBOMList => " + productDTO.getProductBOMList().size());
		
		// BomList null 일경우 건너뜀
		if (productDTO.getProductBOMList() != null) {
			List<ProductBomDTO> bomDTOs = productDTO.getProductBOMList();
			// productBom 저장
			for (ProductBomDTO dto : bomDTOs) {
				productDao.save(dto);
				System.out.println("ProductServiceImpl productsave ProductBomDTO => " + dto);
			}
		}

		return saveresult;
	}

	@Override
	public int getproductSearchcount(ProductDTO productDTO) {

		return productDao.getSearchCount(productDTO);
	}

	@Override
	public List<ProductDTO> getproductSearchList(ProductDTO productDTO) {
		
		List<ProductDTO> productDTOs = productDao.findSearchList(productDTO);
		
		// 제품분류번호에 맞는 제품분류명 가져오기
		for (ProductDTO dto : productDTOs) {
			dto.setProduct_statusName(productStatus_IntToString(dto.getProduct_status()));
		}

		return productDTOs;
	}

	@Override
	public ProductDTO getfindById(int product_no) {
		// null이 포함된 product 정보 가져오기
		Optional<Product> product = productRepository.findById(product_no);
		System.out.println("ProductServiceImpl getfindById product => " + product.get());
		System.out.println("ProductServiceImpl getfindById product.getProduct_no => " + product.get().getProduct_no());
		
		ProductDTO productDTO = new ProductDTO();
				
		if (product.isPresent()) {
			// Product -> productDTO 변경(ProductDTO.class 참조)
			productDTO = ProductDTO.chageProductDTO(product.get());
			// 제품분류번호에 맞는 제품분류명 가져오기
			productDTO.setProduct_statusName(productStatus_IntToString(productDTO.getProduct_status()));

		}
		System.out.println("ProductServiceImpl getfindById productDTO => " + productDTO);

		return productDTO;
	}

	@Override
	public List<ProductBomDTO> getBomInfo(int product_no) {
		List<ProductBomDTO> bomDTOs = productDao.getBomList(product_no);
		
		// 제품분류번호에 맞는 제품분류명 가져오기
		for (ProductBomDTO dto : bomDTOs) {
			dto.setParts_statusName(partsStatus_IntToString(dto.getParts_status()));
		}

		return bomDTOs;
	}

	@Override
	public List<PartsDTO> findPartsByStatus(int status) {

		return partsDao.findPartsByStatus(status);
	}

	@Override
	public Product productUpdate(Product product) {
		//제품 정보저장
		product = productRepository.save(product);

		return product;
	}

	@Override
	public void productBOMUpdate(ProductDTO productDTO) {

		// 기존 BOM정보 삭제 
		TransactionStatus transactionStatusDelete = platformTransactionManager
				.getTransaction(new DefaultTransactionDefinition());
		try {
			productDao.productBOMDelete(productDTO.getProduct_no());
			platformTransactionManager.commit(transactionStatusDelete);
		} catch (Exception e) {
			platformTransactionManager.rollback(transactionStatusDelete);
			System.out.println("ProductServiceImpl productBOMUpdate transactionStatus1 Exception => " + e.getMessage());
		}
		
		// BOM리스트가 null일경우 저장하지 않음
		if (productDTO.getProductBOMList() != null) {
			TransactionStatus transactionStatusUpdate = platformTransactionManager
					.getTransaction(new DefaultTransactionDefinition());
			try {
				productDao.productBOMUpdate(productDTO.getProductBOMList(), productDTO.getProduct_no());
				platformTransactionManager.commit(transactionStatusUpdate);
			} catch (Exception e) {
				platformTransactionManager.rollback(transactionStatusUpdate);
				System.out.println(
						"ProductServiceImpl productBOMUpdate transactionStatusUpdate Exception => " + e.getMessage());
			}
		}

	}

	@Override
	public void deleteProduct(int product_no) {
		productDao.deleteProduct(product_no);

	}

	// 부품상태 코드를 이름으로 변환메소드
	// common Table 변경시 수정 필요
	private String productStatus_IntToString(int status) {
		switch (status) {
		case 0:
			return "데스크탑";
		case 1:
			return "노트북";
		case 2:
			return "워크스테이션";
		default:
			return "";
		}
	}

	// 부품상태 코드를 이름으로 변환메소드
	// common Table 변경시 수정 필요
	private String partsStatus_IntToString(int status) {
		switch (status) {
		case 0:
			return "메인보드";
		case 1:
			return "CPU";
		case 2:
			return "GPU";
		case 3:
			return "메모리";
		case 4:
			return "POWER";
		case 5:
			return "HDD";
		case 6:
			return "SSD";
		case 7:
			return "CASE";
		case 8:
			return "COOLER";
		default:
			return "";
		}
	}

}