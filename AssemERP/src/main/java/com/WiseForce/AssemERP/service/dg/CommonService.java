package com.WiseForce.AssemERP.service.dg;

import java.util.List;

import com.WiseForce.AssemERP.dto.CommonDTO;

public interface CommonService {

	List<CommonDTO> getAllStatus(int big_status);

	CommonDTO getAllStatus(int bigStatus, int middleStatus);

}
