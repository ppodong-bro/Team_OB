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

	@Override
	public List<PartsDTO> getPartsList() {
		List<PartsDTO> partsDTOs = partsDao.findAllPartsList();
		for (PartsDTO dto : partsDTOs) {
			dto.setParts_statusName(partsStatus_IntToString(dto.getParts_status()));
		}
		return partsDTOs;
	}

	@Override
	public int productsave(ProductDTO productDTO) {
		// emp 임시적용
		productDTO.setEmp_no(1001);
		if (productDTO.getIn_date() == null) {
			productDTO.setIn_date(LocalDate.now());
		}
		productDTO.setDel_status(0);
		Product product = productDTO.changeProduct();

		product = productRepository.save(product);
		productRepository.flush();
		int saveresult = 0;


		System.out.println("ProductServiceImpl productsave productDTO.getproductBOMList => "+productDTO.getProductBOMList());
		List<ProductBomDTO> bomDTOs = productDTO.getProductBOMList();

		for(ProductBomDTO dto : bomDTOs) {
			productDao.save(dto);
			System.out.println("ProductServiceImpl productsave ProductBomDTO => "+dto);
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
		for (ProductDTO dto : productDTOs) {
			dto.setProduct_statusName(productStatus_IntToString(dto.getProduct_status()));
		}

		return productDTOs;
	}

	@Override
	public ProductDTO getfindById(int product_no) {

		Optional<Product> product = productRepository.findById(product_no);
		System.out.println("ProductServiceImpl getfindById product => " + product.get());
		System.out.println("ProductServiceImpl getfindById product.getProduct_no => " + product.get().getProduct_no());
		ProductDTO productDTO = new ProductDTO();

		if (product.isPresent()) {
			productDTO = ProductDTO.chageProductDTO(product.get());
			productDTO.setProduct_statusName(productStatus_IntToString(productDTO.getProduct_status()));

		}
		System.out.println("ProductServiceImpl getfindById productDTO => " + productDTO);

		return productDTO;
	}

	@Override
	public List<ProductBomDTO> getBomInfo(int product_no) {
		List<ProductBomDTO> bomDTOs = productDao.getBomList(product_no);

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

		product = productRepository.save(product);
		productRepository.flush();

		return product;
	}

	@Override
	public void productBOMUpdate(ProductDTO productDTO) {

		TransactionStatus transactionStatusDelete =  platformTransactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			productDao.productBOMDelete(productDTO.getProduct_no());
			platformTransactionManager.commit(transactionStatusDelete);
		} catch (Exception e) {
			platformTransactionManager.rollback(transactionStatusDelete);
			System.out.println("ProductServiceImpl productBOMUpdate transactionStatus1 Exception => "+e.getMessage());
		}

		TransactionStatus transactionStatusUpdate = platformTransactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			productDao.productBOMUpdate(productDTO.getProductBOMList(),productDTO.getProduct_no());
			platformTransactionManager.commit(transactionStatusUpdate);
		} catch (Exception e) {
			platformTransactionManager.rollback(transactionStatusUpdate);
			System.out.println("ProductServiceImpl productBOMUpdate transactionStatusUpdate Exception => "+e.getMessage());
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