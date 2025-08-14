package com.WiseForce.AssemERP.domain.dg;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Files {
	@Id
	private String files_path;
	private String files_folder;
// 	private String files_no;
 	private String filesNo; // JPARepository를 사용해서 findByColumn을 사용하려면 _를 사용하지 않아야 인식한다...
	private String files_name;
}
