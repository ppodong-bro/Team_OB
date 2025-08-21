package com.WiseForce.AssemERP.service.dg;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.domain.dg.Files;
import com.WiseForce.AssemERP.domain.dg.Inventory_Adjust;
import com.WiseForce.AssemERP.repository.dg.FilesRepository;
import com.WiseForce.AssemERP.repository.dg.InventoryAdjustRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class FilesServiceImpl implements FilesService {
	private final InventoryAdjustRepository adjustRepository;
	private final FilesRepository filesRepository;
	
	// files_no로 파일들 조회
	@Override
	public List<Map<String, String>> getFilesByFilesNo(int adjust_id) {
		List<Map<String, String>> returnList = new ArrayList<>();
		
		// adjust_id로 file_no를 가져온다.
		Optional<Inventory_Adjust> inventoryAdjustOpt = adjustRepository.findById(adjust_id);
		inventoryAdjustOpt.ifPresent(adjust -> {
			List<Files> files = filesRepository.findByFilesNo(adjust.getFilesNo());

			System.out.println(files);
			
			// 람다에서 외부 변수에 직접 대입하면 에러가 발생...
	        List<Map<String, String>> fileMapList = files.stream()
	            .map(file -> {
	                Map<String, String> fileMap = new HashMap<>();
	                fileMap.put("filePath", file.getFiles_path());
	                fileMap.put("fileName", file.getFiles_name());
	                return fileMap;
	            })
	            .collect(Collectors.toList());
	        
	        // 결과 리스트에 addAll로 추가
	        returnList.addAll(fileMapList);
		});
		
		return returnList;
	}

}
