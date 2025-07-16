package com.oracle.oBootBoard03.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Repository;

import com.oracle.oBootBoard03.domain.Emp;
import com.oracle.oBootBoard03.domain.EmpImage;
import com.oracle.oBootBoard03.dto.EmpDto;
import com.oracle.oBootBoard03.dto.Emp_picDto;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class EmpRepositoryImpl implements EmpRepository {

	private final EntityManager em;

	@Override
	public List<EmpDto> findAllEmp(EmpDto empDto) {
		String nativeSql = "SELECT emp_no, emp_name, email, emp_tel, sal, dept_code, in_date, emp_id, del_status, emp_password " // 실제
																																	// 컬럼명들을
																																	// 나열
				+ "FROM ( " + "    SELECT ROWNUM rn, a.* " + "    FROM ( "
				+ "        SELECT emp_no, emp_name, email, emp_tel, sal, dept_code, in_date, emp_id, del_status, emp_password " // 실제
																																// 컬럼명들을
																																// 나열
				+ "        FROM   Emp " // 테이블명은 엔티티명이 아닌 실제 DB 테이블명
				+ "        WHERE  del_status = 0 " + "        ORDER BY emp_no " + "    ) a " + ") "
				+ "WHERE rn BETWEEN :start AND :end ";

		Query query = em.createNativeQuery(nativeSql, Emp.class);
		query.setParameter("start", empDto.getStart());
		query.setParameter("end", empDto.getEnd());
		List<Emp> empList = query.getResultList();

		List<EmpDto> empDtoList = empList.stream().map(emp -> new EmpDto(emp)).collect(Collectors.toList());
		System.out.println("EmpRepositoryImpl findAllEmp => " + empDtoList);
		
		String imageSql = "SELECT filename FROM ( " +
                " SELECT filename FROM emp_image_list WHERE emp_emp_no = :emp_no ORDER BY order_num " +
                ") WHERE ROWNUM = 1";
		
		Query imageQuery = em.createNativeQuery(imageSql);

		for(EmpDto imageEmpDto : empDtoList) {
			imageQuery.setParameter("emp_no", imageEmpDto.getEmp_no());
			System.out.println("EmpRepositoryImpl findAllEmp imageEmpDto => "+imageEmpDto.getEmp_no());
			List<String> filenames = imageQuery.getResultList();

			if (!filenames.isEmpty()) {
				imageEmpDto.setSimage(filenames.get(0));  // 대표 이미지 설정
			    System.out.println("EmpRepositoryImpl findAllEmp imageEmpDto.getsimage90 => "+imageEmpDto.getSimage());
			}
		}
		System.out.println("EmpRepositoryImpl findAllEmp empDtoList After=> " + empDtoList);
		return empDtoList;
	}

	@Override
	public Emp empSave(Emp emp) {
		em.persist(emp);
		return emp;
	}

	@Override
	public int getTotalCount() {
		TypedQuery<Long> query = em.createQuery("Select Count(e) From Emp e where del_status = false", Long.class);
		int totalEmpCount = query.getSingleResult().intValue();

		return totalEmpCount;
	}

	@Override
	public Emp findById(int emp_no) {
		Emp emp = em.find(Emp.class, emp_no);
		
		return emp;
	}

	@Override
	public int updateEmp(EmpDto empDto) {
		String updateSql = "UPDATE emp " + "set emp_no 	 	 = :emp_no, " + "    emp_name 	 = :emp_name, "
				+ "    email 	 	 = :email, " + "	emp_tel  	 = :emp_tel, " + "	sal		 	 = :sal, "
				+ "	dept_code	 = :dept_code, " + "	in_date		 = :in_date, " + "	emp_id		 = :emp_id, "
				+ "	emp_password = :emp_password " + "WHERE emp_no = :emp_no";

		Query query = em.createNativeQuery(updateSql);
		query.setParameter("emp_no", empDto.getEmp_no());
		query.setParameter("emp_name", empDto.getEmp_name());
		query.setParameter("email", empDto.getEmail());
		query.setParameter("emp_tel", empDto.getEmp_tel());
		query.setParameter("sal", empDto.getSal());
		query.setParameter("dept_code", empDto.getDept_code());
		query.setParameter("in_date", empDto.getIn_date());
		query.setParameter("emp_id", empDto.getEmp_id());
		query.setParameter("emp_password", empDto.getEmp_password());
		int result = query.executeUpdate();
		
		List<String> uplaodfileNames = empDto.getUploadFileNames();
		
		
		return result;
	}

	@Override
	public void deleteEmp(int emp_no) {

		Emp emp = em.find(Emp.class, emp_no);
		emp.changeDel_status(true);

	}

	@Override
	public List<EmpDto> allEmpList() {
		Query query = em.createNativeQuery("select * from emp", Emp.class);
		

		List<Emp> emplist = query.getResultList();
		List<EmpDto> empDtoList = new ArrayList<>();
		
		for (Emp empchange : emplist) {
			EmpDto empDto = new EmpDto(empchange);
			empDtoList.add(empDto);
			}
		return empDtoList;
	}

	@Override
	public List<String> getEmpImgeLIst(int emp_no) {
		String imageSql = " SELECT filename FROM emp_image_list WHERE emp_emp_no = :emp_no ORDER BY order_num";
		Query imageQuery = em.createNativeQuery(imageSql);
		imageQuery.setParameter("emp_no", emp_no);
		List<String> filenames = imageQuery.getResultList();
		System.out.println("EmpRepositoryImpl getEmpImgeLIst filenames => "+filenames);
		return filenames;
	}

	@Override
	public void deleteEmpImages(List<String> removeFiles) {
		String sql ="delete From emp_image_list where filename = :filename";
		Query query = em.createNativeQuery(sql);
		for(String filename : removeFiles) {
			query.setParameter("filename",filename);
			query.executeUpdate();
		}
		
	}

}
