package com.WiseForce.AssemERP.dao.sh;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.sh.PartsDTO;

import lombok.RequiredArgsConstructor;

public interface PartsDao {

	List<PartsDTO> findPageList(PartsDTO partsDTO);

	List<PartsDTO> findAllPartsList();

}
