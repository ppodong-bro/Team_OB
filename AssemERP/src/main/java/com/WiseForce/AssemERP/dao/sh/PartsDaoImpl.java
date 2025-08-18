package com.WiseForce.AssemERP.dao.sh;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.domain.sh.Parts;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;

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
			partDTOList = session.selectList("com.WiseForce.AssemERP.sh.PartsDTOMapper.shPartsListPage", partsDTO);
			System.out.println("PartsDaoImpl findPageList partDTOList => "+partDTOList);
		} catch (Exception e) {
			System.out.println("PartsDaoImpl findPageList Exception => "+e.getMessage());
		}

		return partDTOList;
	}


	@Override
	public List<PartsDTO> findAllPartsList() {
		List<PartsDTO> partsDTOs = null;

		try {
			partsDTOs = session.selectList("shFindPartsAllList");
			System.out.println("PartsDaoImpl findAllPartsList partsDTOs => "+partsDTOs);
		} catch (Exception e) {
			System.out.println("PartsDaoImpl findAllPartsList Exception => "+e.getMessage());
		}

		return partsDTOs;
	}


	@Override
	public int getSearchCount(PartsDTO partsDTO) {
		int searchCount = 0;

		try {
			searchCount = session.selectOne("shsearchPartsCount", partsDTO);
			System.out.println("PartsDaoImpl getSearchCount searchCount => "+searchCount);
		} catch (Exception e) {
			System.out.println("PartsDaoImpl getSearchCount Exception => "+e.getMessage());
		}
		return searchCount;
	}


	@Override
	public List<PartsDTO> findSearchList(PartsDTO partsDTO) {
		List<PartsDTO> partsDTOs = null;

		try {
			partsDTOs = session.selectList("shPartsSearchList", partsDTO);
			System.out.println("PartsDaoImpl findSearchList partsDTOs => "+partsDTOs);
		} catch (Exception e) {
			System.out.println("PartsDaoImpl findSearchList Exception => "+e.getMessage());
		}


		return partsDTOs;
	}


	@Override
	public List<PartsDTO> findPartsByStatus(int status) {
		List<PartsDTO> partsDTOs = null;
		
		try {
			partsDTOs = session.selectList("shfindPartsByStatus", status);
			System.out.println("PartsDaoImpl findPartsByStatus partsDTOs => "+partsDTOs);
		} catch (Exception e) {
			System.out.println("PartsDaoImpl findPartsByStatus Exception => "+e.getMessage());
		}
		
		return partsDTOs;
	}


	@Override
	public void deleteParts(int parts_no) {
		session.update("shPartsDelete", parts_no);
		
	}


	@Override
	public int getTotalParts() {
		int result = 0;
		
		
		try {
			result = session.selectOne("shPartTotalCount");
			System.out.println("PartsDaoImpl getTotalParts result => "+result);
		} catch (Exception e) {
			System.out.println("PartsDaoImpl getTotalParts Exception => "+e.getMessage());
		}
		
		return result;
	}


	@Override
	public String partsNameFromPartno(Integer parts_no) {
		String part_name = null;
		
		try {
			part_name = session.selectOne("shPartsNameFromPartsno", parts_no);
			System.out.println("PartsDaoImpl partsNameFromPartno part_name => "+part_name);
		} catch (Exception e) {
			System.out.println("PartsDaoImpl partsNameFromPartno Exception => "+e.getMessage());
		}
		
		return part_name;
	}


	@Override
	public List<PartsDTO> searchByName(String keyword) {
		List<PartsDTO> result = null;
		System.out.println("PartsDaoImpl searchByName keyword =>"+keyword);
		
		try {
			result = session.selectList("shSearchByPartsName", keyword);
			System.out.println("PartsDaoImpl searchByName result => "+result);
		} catch (Exception e) {
			System.out.println("PartsDaoImpl searchByName Exception =>"+e.getMessage());
		}
		
		return result;
	}


	






}
