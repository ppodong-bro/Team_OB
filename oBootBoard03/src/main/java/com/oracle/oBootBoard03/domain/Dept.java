package com.oracle.oBootBoard03.domain;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.hibernate.annotations.ColumnDefault;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import jakarta.persistence.Column;
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
		name = "deptcode_seq",    // Seq 객체
		sequenceName = "deptcode_seq_gen",
		initialValue = 1000,
		allocationSize = 1
		
		
		)
@EntityListeners(AuditingEntityListener.class) // Auditing 리스너 활성화 -> LocalDate 기본값
public class Dept {
	@Id
	@GeneratedValue(
				strategy = GenerationType.SEQUENCE,
				generator = "deptcode_seq"
			)
	private int 			dept_code;
	private String 			dept_name;
	private int 			dept_captain;
	private String 			dept_tel;
	private String 			dept_loc;
	@ColumnDefault("0") // 기본값 0 설정
	@Column(nullable = false) // null을 허용하지 않음 (선택 사항이지만 0을 기본값으로 할 때 좋음)
	private Boolean 		dept_gubun;
	@CreatedDate       		 // 엔티티 생성 시 자동으로 현재 날짜/시간 입력
	private LocalDateTime   in_date;

	public void changeDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public void changeDept_captain(int dept_captain) {
		this.dept_captain = dept_captain;
	}
	public void changeDept_tel(String dept_tel) {
		this.dept_tel = dept_tel;
	}
	public void changeDept_loc(String dept_loc) {
		this.dept_loc = dept_loc;
	}
	public void changeDept_gubun(Boolean dept_gubun) {
		this.dept_gubun = dept_gubun;
	}
	public void changeIn_date(LocalDateTime in_date) {
		this.in_date = in_date;
	}
}
