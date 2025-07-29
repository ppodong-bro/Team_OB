package com.WiseForce.AssemERP.dao.sh;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.sh.PartsDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PartsDaoImpl implements PartsDao {

	private final SqlSession session;

	@Override
	public List<PartsDTO> findPageList(PartsDTO partsDTO) {
		
		System.out.println("PartsDaoImpl findPageList partsDTO => "+partsDTO);
		System.out.println("PartsDaoImpl findPageList partsDTO => "+partsDTO.getStart());
		System.out.println("PartsDaoImpl findPageList partsDTO => "+partsDTO.getEnd());
		List<PartsDTO> partDTOList = null;
		
		try {
			partDTOList = session.selectList("com.WiseForce.AssemERP.PartsDTOMapper.shPartsListPage", partsDTO);
			System.out.println("PartsDaoImpl findPageList partDTOList => "+partDTOList);
		} catch (Exception e) {
			System.out.println("PartsDaoImpl findPageList Exception => "+e.getMessage());
		}
		
		return partDTOList;
	}
	
}
