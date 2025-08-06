package com.WiseForce.AssemERP.service.dg;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.domain.dg.Common;
import com.WiseForce.AssemERP.domain.dg.Common_ID;
import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.repository.dg.CommonRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class CommonServiceImpl implements CommonService {
	private final CommonRepository commonRepository;
	private final ModelMapper modelMapper;

	@Override
	public List<CommonDTO> getAllStatus(int big_status) {
		List<Common> commons = commonRepository.findByBigStatus(big_status);
		
		// Entity -> DTO
		List<CommonDTO> commonDTOs = commons.stream()
		        .map(entity -> modelMapper.map(entity, CommonDTO.class))
		        .collect(Collectors.toList());
		
		return commonDTOs;
	}
	
	public CommonDTO getAllStatus(int big_status, int middle_status) {
		Common_ID common_ID = new Common_ID(big_status, middle_status);
		
		Optional<Common> optional = commonRepository.findById(common_ID);

		// Entity -> DTO
		CommonDTO commonDTO = modelMapper.map(optional.orElseThrow(), CommonDTO.class);
		
		return commonDTO;
	}

	@Override
	public String getAllStatusText(int big_status, int middle_status) {
		Common_ID common_ID = new Common_ID(big_status, middle_status);
		
		Optional<Common> optional = commonRepository.findById(common_ID);

		// Entity -> DTO
		CommonDTO commonDTO = modelMapper.map(optional.orElseThrow(), CommonDTO.class);
		
		return commonDTO.getContext();
	}

}
