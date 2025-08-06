package com.WiseForce.AssemERP.repository.dg;

import org.springframework.stereotype.Repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class EmpRepositoryImpl implements EmpRepository {
	private final EntityManager entityManager;
	
	@Override
	public String getEmpNameFromEmpNo(int emp_no) {
		// createNativeQuery : 실제 DB의 테이블명, 칼럼명을 사용하여 쿼리 진행
		String findByEmpNoSql = "SELECT emp_name FROM emp WHERE emp_no = :emp_no";

		// 두 번째 인자로 엔티티 클래스를 주면 자동으로 매핑 시도
		Query findByEmpNoQuery = entityManager.createNativeQuery(findByEmpNoSql, String.class);

		// 파라미터에 값 넣기
		findByEmpNoQuery.setParameter("emp_no", emp_no);

		try {
			Object result = findByEmpNoQuery.getSingleResult();
	        return (String) result;
	    } catch (NoResultException e) {
	        // 결과가 없는 경우
	        System.out.println("해당 사원 번호에 해당하는 사원 이름이 없습니다. emp_no: " + emp_no);
	        return "-";
	    } catch (Exception e) { // 그 외 다른 예외 처리
	        System.err.println("사원 이름 조회 중 예외 발생: " + e.getMessage());
	        return "-";
	    }
	}
}
