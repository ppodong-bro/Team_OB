package com.WiseForce.AssemERP.service.dg;

import java.util.List;
import java.util.Map;

public interface FilesService {

	// files_no로 파일들 조회
	List<Map<String, String>> getFilesByFilesNo(int adjust_id);

}
