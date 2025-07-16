package com.oracle.oBootBoard03.repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Repository;
import com.oracle.oBootBoard03.domain.Dept;
import com.oracle.oBootBoard03.dto.DeptDto;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class DeptRepositoryImpl implements DeptRepository {

	private final EntityManager em;

	@Override
	public List<DeptDto> findAllDept() {
		Query query = em.createNativeQuery("select * from dept", Dept.class);
		List<Dept> deptList = query.getResultList();
		List<DeptDto> deptAllList = deptList.stream()
											.map(dept->new DeptDto(dept))
											.collect(Collectors.toList());
		System.out.println("DeptRepositoryImpl findAllDept deptAllList "+deptAllList);
		return deptAllList;
	}

	@Override
	public Dept deptSave(Dept dept) {
		System.out.println("DeptRepositoryImpl deptSave dept->"+dept);
		em.persist(dept);
		return dept;
	}

	@Override
	public Long deptTotalcount() {
		System.out.println("DeptRepositoryImpl dept/list Strart...");
		TypedQuery<Long> query = 
				em.createQuery("select count(d) from Dept d where dept_gubun = false", Long.class); // Dept.class 대신 Long.class
		Long totalCountLong = query.getSingleResult();

		return totalCountLong;
	}

	@Override
	public List<DeptDto> findPageDept(DeptDto deptDto) {
		// JPQL 쿼리
	    // Oracle 11g ROWNUM을 이용한 페이징 네이티브 쿼리
	    // d1_0 대신 dept_code, dept_captain 등 실제 컬럼명 사용 (엔티티 필드명이 아님!)
	    // SELECT 절에 엔티티의 모든 컬럼을 명시하거나, 엔티티 매핑 정보를 활용해야 함
	    // 여기서는 Dept 엔티티의 모든 컬럼을 명시한다고 가정
	    String nativeSql = "SELECT dept_code, dept_captain, dept_gubun, dept_loc, dept_name, dept_tel, in_date " // 실제 컬럼명들을 나열
	                     + "FROM ( "
	                     + "    SELECT ROWNUM rn, a.* "
	                     + "    FROM ( "
	                     + "        SELECT dept_code, dept_captain, dept_gubun, dept_loc, dept_name, dept_tel, in_date " // 실제 컬럼명들을 나열
	                     + "        FROM   Dept " // 테이블명은 엔티티명이 아닌 실제 DB 테이블명
	                     + "        WHERE  dept_gubun = 0"
	                     + "        ORDER BY dept_code "
	                     + "    ) a "
	                     + ") "
	                     + "WHERE rn BETWEEN :start AND :end";

	    // em.createNativeQuery()를 사용하고, 결과를 Dept.class로 매핑하도록 지정
	    Query query = em.createNativeQuery(nativeSql, Dept.class); // 두 번째 인자로 엔티티 클래스를 주면 자동으로 매핑 시도

	    // :start 파라미터에 값 넣기
	    query.setParameter("start", deptDto.getStart());
	    // :end 파라미터에 값 넣기
	    query.setParameter("end", deptDto.getEnd());

	    
	    List<Dept> deptEntityList = query.getResultList();
	    System.out.println("DeptRepositoryImplfindPageDept deptEntityList->"+deptEntityList);

        // 2. Stream API를 사용하여 Entity List를 DTO List로 변환
        List<DeptDto> deptDtoList = deptEntityList.stream()
								                // 각 dept 엔티티를 deptDto 객체로 매핑 (변환)
								                // deptDto::new는 deptDto(Dept dept) 생성자를 호출하는 것과 같아.
								                //.map(DeptDto::new)
								                .map(dept->new DeptDto(dept))
								                // 매핑된 DTO 객체들을 List로 다시 수집
        		                               .collect(Collectors.toList());
	    
	    System.out.println("DeptRepositoryImplfindPageDept deptDtoList->"+deptDtoList);
	    
	    // 쿼리 실행 및 결과 반환
	    return deptDtoList;	
	}

	@Override
	public Dept findById(int dept_code) {
		Dept dept = em.find(Dept.class, dept_code);
		return dept;
	}

	@Override
	public Optional<Dept> findById2(int dept_code) {
		// 1. 먼저 em.find()로 엔티티를 조회
		Dept foundDept = em.find(Dept.class, dept_code);

		// 2. 조회된 엔티티를 Optional.ofNullable()로 감싸기
		Optional<Dept> deptOptional = Optional.ofNullable(foundDept);

		return deptOptional;
	}

	@Override
	public void deleteById(int dept_code) {
		System.out.println("JpaMemberRepository deleteById before...");
		Dept dept = em.find(Dept.class, dept_code);
		dept.changeDept_gubun(true);
	}


}
