package com.WiseForce.AssemERP.repository.dg;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.WiseForce.AssemERP.domain.dg.Files;

public interface FilesRepository extends JpaRepository<Files, String> {

	List<Files> findByFilesNo(String files_no);
}
