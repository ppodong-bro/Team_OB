package com.WiseForce.AssemERP.dto.sh;

import java.time.LocalDateTime;

import com.WiseForce.AssemERP.domain.sh.Parts;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
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
    private	int				parts_status;
	private	String			parts_name;
	private	String			parts_context;
	private	int				relation_status;
	private	String			manufacture;
	private	String			filename;
	private int				del_status;
    private int				emp_no;
    private LocalDateTime	in_date;
    
    //paging
    private int start;
    private int end;
    private String currentpage;
    private	String pageNum;
    
    public static PartsDTO chagePartsDTO(Parts parts) {
    	return PartsDTO.builder()
    			.parts_no(parts.getParts_no())
    			.parts_status(parts.getParts_status())
    			.parts_name(parts.getParts_name())
    			.parts_context(parts.getParts_context())
    			.relation_status(parts.getRelation_status())
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
    			.relation_status(this.relation_status)
    			.manufacture(this.manufacture)
    			.filename(this.filename)
    			.del_status(this.del_status)
    			.emp_no(this.emp_no)
    			.in_date(this.in_date)
    			.build();
	}
}
