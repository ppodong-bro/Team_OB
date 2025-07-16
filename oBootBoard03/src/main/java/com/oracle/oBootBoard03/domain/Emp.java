package com.oracle.oBootBoard03.domain;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
@SequenceGenerator(
		name = "emp_seq_gen",    // seq 객체
		sequenceName = "emp_seq_generator",
		initialValue = 1000000,
		allocationSize = 1
		)
@EntityListeners(AuditingEntityListener.class)
public class Emp {
	@Id
	@GeneratedValue(
			strategy = GenerationType.SEQUENCE,
			generator = "emp_seq_gen"
			
			)
	private int 		emp_no;
	
	@Column(unique = true, length = 30)
	private String      emp_id;
	private String      emp_password;
	
	private String  	emp_name;
	private String  	email;
	private String  	emp_tel;
	private Long    	sal;
	private Boolean  	del_status;
	private int         dept_code;
	private LocalDate   in_date;
	
	// EmpImage는 @Embeddable로 정의된 값 타입 객체로, 독립적인 엔티티가 아니라 Emp에 종속
	// JPA는 자동으로 Emp 테이블과는 별도로 컬렉션을 저장할 테이블을 생성
	// 엔티티명_필드명' 형태의 테이블이 생성됨  EMP_IMAGELIST
	// 명시적으로 테이블 이름을 지정하려면 @CollectionTable 어노테이션을 추가로 사용
    @ElementCollection
    @Builder.Default
	private List<EmpImage> imageList = new ArrayList<>();
	
	// addImage(): ProductImage 객체를 리스트에 추가하고 순서(ord) 값을 설정
	public void addImage(EmpImage image) {
		image.setOrder_num(this.imageList.size());
		imageList.add(image);
	  	System.out.println("Product addImage Image->"+image);
	  	System.out.println("Product addImage imageList->"+imageList);
	}
	
    // 파일명만 받아서 ProductImage 객체를 생성하고 리스트에 추가
    public void addImageString(String fileName){
    	EmpImage empImage = EmpImage.builder()
    								.filename(fileName)
    								.build()
    								;
    	addImage(empImage);
    }

    // clearList(): 모든 이미지를 리스트에서 제거
    public void clearList() {
    	this.imageList.clear();
    }

	public void changeEmpno(int emp_no) {
		this.emp_no = emp_no;
	}
	public void changeEmpId(String emp_id) {
		this.emp_id = emp_id;
	}
	public void changeEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public void changeEmp_password(String emp_password) {
		this.emp_password = emp_password;
	}
	public void changeEmail(String email) {
		this.email = email;
	}
	public void changeEmp_tel(String emp_tel) {
		this.emp_tel = emp_tel;
	}
	public void changeDel_status(Boolean del_status) {
		this.del_status = del_status;
	}
	public void changeDept_code(int dept_code) {
		this.dept_code = dept_code;
	}
	public void changeSal(Long long1) {
		this.sal = long1;
	}

	
}
