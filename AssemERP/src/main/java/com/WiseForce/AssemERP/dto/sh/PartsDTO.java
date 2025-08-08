package com.WiseForce.AssemERP.dto.sh;

import java.time.LocalDate;

import org.springframework.web.multipart.MultipartFile;

import com.WiseForce.AssemERP.domain.sh.Parts;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class PartsDTO {
	private int				parts_no;
    private	Integer			parts_status;
	private	String			parts_name;
	private	String			parts_context;
	private	String			manufacture;
	private	String			filename;
	private int				del_status;
    private int				emp_no;
    private LocalDate		in_date;

    //paging
    private int start;
    private int end;
    private String currentPage;
    private	String pageNum;

    // 분류명가져오기
    private String parts_statusName;

    // search
    private LocalDate startDate;
    private LocalDate endDate;

    // 이미지
    private MultipartFile file;
    
    // 사원명가져오기
    private String emp_name;
    
    public static PartsDTO chagePartsDTO(Parts parts) {
    	return PartsDTO.builder()
    			.parts_no(parts.getParts_no())
    			.parts_status(parts.getParts_status())
    			.parts_name(parts.getParts_name())
    			.parts_context(parts.getParts_context())
    			.manufacture(parts.getManufacture())
    			.filename(parts.getFilename())
    			.del_status(parts.getDel_status())
    			.emp_no(parts.getEmp_no())
    			.in_date(parts.getIn_date())
    			.build();
    }

    public Parts changeParts() {
    	return Parts.builder()
    			.parts_no(this.parts_no)
    			.parts_status(this.parts_status)
    			.parts_name(this.parts_name)
    			.parts_context(this.parts_context)
    			.manufacture(this.manufacture)
    			.filename(this.filename)
    			.del_status(this.del_status)
    			.emp_no(this.emp_no)
    			.in_date(this.in_date)
    			.build();
	}
    
 }
