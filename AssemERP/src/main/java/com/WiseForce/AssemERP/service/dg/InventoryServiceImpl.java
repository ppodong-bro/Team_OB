package com.WiseForce.AssemERP.service.dg;

import java.util.List;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.domain.dg.Month_Inventory;
import com.WiseForce.AssemERP.domain.dg.Month_Inventory_ID;
import com.WiseForce.AssemERP.dto.dg.Month_InventoryDTO;
import com.WiseForce.AssemERP.repository.dg.InventoryRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class InventoryServiceImpl implements InventoryService {
	private final InventoryRepository inventoryRepository;
    private final ModelMapper modelMapper;

	@Override
	public List<Month_InventoryDTO> getList() {
		//월재고 전체 조회
		List<Month_Inventory> month_Inventories = inventoryRepository.findAll();

		//Entity -> DTO
	    List<Month_InventoryDTO> month_InventoryDTOs = month_Inventories.stream()
	            .map(entity -> modelMapper.map(entity, Month_InventoryDTO.class))
	            .collect(Collectors.toList());
		
		return month_InventoryDTOs;
	}

	@Override
	public List<Month_InventoryDTO> getCurrentList() {
		// 이번 월 기초재고 조회 : 가장 최신 기초재고 조회
		List<Month_Inventory> month_Inventories = inventoryRepository.getLastestMonthInventory();

		//Entity -> DTO
	    List<Month_InventoryDTO> month_InventoryDTOs = month_Inventories.stream()
	            .map(entity -> modelMapper.map(entity, Month_InventoryDTO.class))
	            .collect(Collectors.toList());

		for(Month_InventoryDTO aaa : month_InventoryDTOs) {
			System.out.println("month_Inventories->"+aaa);
		}
		
		return month_InventoryDTOs;
	}

}
