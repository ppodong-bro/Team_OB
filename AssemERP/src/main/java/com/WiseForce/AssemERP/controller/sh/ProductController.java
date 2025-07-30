package com.WiseForce.AssemERP.controller.sh;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.WiseForce.AssemERP.domain.sh.Parts;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;
import com.WiseForce.AssemERP.service.km.Paging;
import com.WiseForce.AssemERP.service.sh.ProductService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("product/")
public class ProductController {

	private final ProductService productService;

	@GetMapping("productList")
	public String productListPage(ProductDTO productDTO, Model model) {
		int totalCount = productService.getTotalCount();
		
		Paging page = new Paging(totalCount, productDTO.getCurrentPage());
		productDTO.setStart(page.getStart());
		productDTO.setEnd(page.getEnd());
		
		List<ProductDTO> productDTOs = productService.getProductList(productDTO);
		
		model.addAttribute("productDTOs", productDTOs);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("page", page);
		
		
		
		
		return "sh/productList";
	}
	
	@GetMapping("create")
	public String productCreateStart(Model model) {
		List<PartsDTO> partsDTOs = productService.getPartsList(); 		
		
		
		model.addAttribute("partsDTOs", partsDTOs);
		
		return "sh/productCreate";
	}
	
	
	@PostMapping("productCreate")
	public String productCreate(ProductDTO productDTO, Model model ) {
		 
		int saveResult = productService.productsave(productDTO);
		
		
		return "redirect:/product/productList";
		
	}
	
	
	
	
	
}
