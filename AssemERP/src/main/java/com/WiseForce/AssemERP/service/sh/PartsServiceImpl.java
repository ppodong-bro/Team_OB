package com.WiseForce.AssemERP.service.sh;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.sh.PartsDao;
import com.WiseForce.AssemERP.domain.sh.Parts;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.repository.sh.PartsRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class PartsServiceImpl implements PartsService {

	private final PartsRepository partsRepository;
	private final PartsDao partsDao;
	
	@Override
	public List<PartsDTO> getPartsList(PartsDTO partsDTO) {
		List<PartsDTO> partsDtoList = partsDao.findPageList(partsDTO);
		
		for(PartsDTO dto : partsDtoList ) {
			// 부품상태 코드를 이름으로 변환 
			dto.setParts_statusName(partsStatus_IntToString(dto.getParts_status()));
		}
		
		return partsDtoList;
	}
	
	// 부품상태 코드를 이름으로 변환메소드
	// common Table 변경시 수정 필요
	private String partsStatus_IntToString(int status) {
		switch(status) {
		case 0: return "메인보드";
		case 1: return "CPU";
		case 2: return "GPU";
		case 3: return "메모리";
		case 4: return "POWER";
		case 5: return "HDD";
		case 6: return "SSD";
		case 7: return "CASE";
		case 8: return "COOLER";
		default: return "";
	}
	}

	@Override
	public int getTotalcount() {
		int Partstotalcout = (int) partsRepository.count();
		return Partstotalcout;
	}

	

	@Override
	public int createParts(PartsDTO partsDTO) {
		if(partsDTO.getIn_date() == null) partsDTO.setIn_date(LocalDateTime.now());
		partsDTO.setDel_status(0);
		// emp 나올떄까지 임시
		partsDTO.setEmp_no(1001); 
		
		Parts parts = partsDTO.changeParts();
		
		
		partsRepository.save(parts);
		 
		
		return parts.getParts_no();
	}
	
	
	
	
	
}
