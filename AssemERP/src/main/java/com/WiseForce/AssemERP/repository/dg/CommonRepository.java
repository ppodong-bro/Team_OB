package com.WiseForce.AssemERP.repository.dg;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.WiseForce.AssemERP.domain.dg.Common;
import com.WiseForce.AssemERP.domain.dg.Common_ID;

public interface CommonRepository extends JpaRepository<Common, Common_ID> {
	
	@Query("SELECT c FROM Common c "
			+ "WHERE c.common_ID.big_status = :bigStatus "
			+ "AND c.common_ID.middle_status <> 999 ")
//			+ "ORDER BY c.context")
    List<Common> findByBigStatus(@Param("bigStatus") int bigStatus);

}
