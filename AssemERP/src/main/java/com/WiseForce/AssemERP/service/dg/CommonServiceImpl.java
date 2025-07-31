package com.WiseForce.AssemERP.service.dg;

import java.util.List;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.domain.dg.Common;
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
		
		List<CommonDTO> commonDTOs = commons.stream()
		        .map(entity -> modelMapper.map(entity, CommonDTO.class))
		        .collect(Collectors.toList());
		
		return commonDTOs;
	}

}
