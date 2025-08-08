package com.WiseForce.AssemERP.controller.sh;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.WiseForce.AssemERP.domain.sh.Product;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.dto.sh.ProductBomDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;
import com.WiseForce.AssemERP.service.sh.ProductService;
import com.WiseForce.AssemERP.service.sm.EmpService;
import com.WiseForce.AssemERP.util.CustomFileUtil;
import com.WiseForce.AssemERP.util.Paging;
import com.fasterxml.jackson.core.JsonProcessingException;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("product/")
public class ProductController {

	private final ProductService productService;
	private final CustomFileUtil fileUtil;
	private final EmpService empService;

	@GetMapping("productList")
	public String productListPage(ProductDTO productDTO, Model model) {
		// Del_status가 0인 부품총량 가져오기
		int totalCount = productService.getTotalCount();
		
		// paging 설정
		Paging page = new Paging(totalCount, productDTO.getCurrentPage());
		productDTO.setStart(page.getStart());
		productDTO.setEnd(page.getEnd());

		// 페이징적용 제품리스트 가져오기
		List<ProductDTO> productDTOs = productService.getProductList(productDTO);

		model.addAttribute("productDTOs", productDTOs);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("page", page);

		return "sh/productList";
	}

	@GetMapping("create")
	public String productCreateStart(Model model) throws JsonProcessingException {

		// Emp 총원가져오기
		EmpDTO dto = new EmpDTO();
		int empTotalCount = empService.getTotalCount(dto);

		// Emp 검색범위 세팅하기(총인원 가져오기)
		dto.setStart(0);
		dto.setEnd(empTotalCount);

		// EmpList 가져오기
		List<EmpDTO> EmpList = empService.empListForm(dto);

		model.addAttribute("EmpList", EmpList);

		return "sh/productCreate";
	}

	@PostMapping("productCreate")
	public String productCreate(ProductDTO productDTO, Model model) {
		System.out.println("ProductController productCreate getProductBOMList => " + productDTO.getProductBOMList());

		// 파일생성하기(서버 저장 및 썸네일 생성)
		productDTO.setFilename(fileUtil.saveFile(productDTO.getFile()));

		// 제품정보 DB저장
		int saveResult = productService.productsave(productDTO);

		return "redirect:/product/productList";

	}

	@GetMapping("searchProductList")
	public String searchProductList(ProductDTO productDTO, Model model) {
		System.out.println("ProductController searchProductList productDTO => " + productDTO);
		// 검색조건에 부합하는 제품총량
		int totalCount = productService.getproductSearchcount(productDTO);

		// 페이징 설정
		Paging page = new Paging(totalCount, productDTO.getCurrentPage());
		productDTO.setStart(page.getStart());
		productDTO.setEnd(page.getEnd());

		// 검색조건에 맞는 리스트가져오기
		List<ProductDTO> productDTOs = productService.getproductSearchList(productDTO);

		model.addAttribute("totalCount", totalCount);
		model.addAttribute("page", page);
		model.addAttribute("productDTOs", productDTOs);

		return "sh/productList";
	}

	@GetMapping("productModify/{product_no}")
	public String productModify(@PathVariable(name = "product_no") int product_no, Model model) {
		System.out.println("ProductController productModify product_no => " + product_no);
		// 부품리스트 가져오기
		List<PartsDTO> partsDTOs = productService.getPartsList();
		
		// PK값을 이용한 제품정보 가져오기
		ProductDTO productDTO = productService.getfindById(product_no);
		List<ProductBomDTO> productBomDTOs = productService.getBomInfo(product_no);

		// Emp 총원가져오기
		EmpDTO dto = new EmpDTO();
		int empTotalCount = empService.getTotalCount(dto);

		// Emp 검색범위 세팅하기(총인원 가져오기)
		dto.setStart(0);
		dto.setEnd(empTotalCount);

		// EmpList 가져오기
		List<EmpDTO> EmpList = empService.empListForm(dto);

		System.out.println("ProductController productModify productBomDTOs => " + productBomDTOs.size());

		model.addAttribute("EmpList", EmpList);
		model.addAttribute("partsDTOs", partsDTOs);
		model.addAttribute("productDTO", productDTO);
		model.addAttribute("productBomDTOs", productBomDTOs);

		return "sh/productModifyForm";
	}

	@GetMapping("/getPartsByStatus/{parts_status}")
	@ResponseBody
	public List<PartsDTO> getPartsByStatus(@PathVariable("parts_status") int status) {
		// 부품분류에 해당하는 부품리스트가져오기
		return productService.findPartsByStatus(status);

	}

	@PostMapping("productUpdate")
	public String productUpdate(ProductDTO productDTO, Model model) {

		productDTO.setFilename(fileUtil.saveFile(productDTO.getFile()));
		System.out.println(
				"ProductController productUpdate productDTO.getProductBOMList => " + productDTO.getProductBOMList());

		Product product = productDTO.changeProduct();
		product = productService.productUpdate(product);

		
		productService.productBOMUpdate(productDTO);
		
		return "redirect:/product/productList";
	}

	@DeleteMapping("deleteFile/{product_no}")
	public ResponseEntity<String> deleteFile(@PathVariable(name = "product_no") int product_no) {
		try {
			// DB에서 파일명 가져오기
			ProductDTO productDTO = productService.getfindById(product_no);
			if (productDTO == null) {
				return ResponseEntity.status(HttpStatus.NOT_FOUND).body("해당제품이 존재하지 않습니다.");
			}
			
			// 파일삭제
			fileUtil.deleteFiles(productDTO.getFilename());

			// DTO => Entity변환
			productDTO.setFilename(null);
			Product product = productDTO.changeProduct();
			
			// DB삭제
			productService.productUpdate(product);

			return ResponseEntity.ok("삭제 성공");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
		}
	}

	@PostMapping("productDeletePro")
	public String productDeletePro(ProductDTO productDTO) {

		productService.deleteProduct(productDTO.getProduct_no());

		return "redirect:/product/productList";
	}

}
