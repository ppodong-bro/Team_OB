package com.WiseForce.AssemERP.dto.sh;

import java.time.LocalDate;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.WiseForce.AssemERP.domain.sh.Product;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDTO {
	private int			product_no;
	private Integer		product_status;
	private String 		product_name;
	private String 		product_context;
	private String 		filename;
    private int 		del_status;
    private int			emp_no;
    private LocalDate	in_date;

    //paging
    private int start;
    private int end;
    private String currentPage;
    private	String pageNum;

    // 분류명가져오기
    private String product_statusName;

    // BOM LIST
    private List<ProductBomDTO> productBOM;

    // Searching
    private LocalDate startDate;
    private LocalDate endDate;


    private MultipartFile file;


    public static ProductDTO chageProductDTO(Product product) {
    	return ProductDTO.builder()
    			.product_no(product.getProduct_no())
    			.product_status(product.getProduct_status())
    			.product_name(product.getProduct_name())
    			.product_context(product.getProduct_context())
    			.filename(product.getFilename())
    			.del_status(product.getDel_status())
    			.emp_no(product.getEmp_no())
    			.in_date(product.getIn_date())
    			.build();
    }

    public Product changeProduct() {
    	return Product.builder()
    			.product_no(this.product_no)
    			.product_status(this.product_status)
    			.product_name(this.product_name)
    			.product_context(this.product_context)
    			.filename(this.filename)
    			.del_status(this.del_status)
    			.emp_no(this.emp_no)
    			.in_date(this.in_date)
    			.build();
	}
}