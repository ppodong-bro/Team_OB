package com.WiseForce.AssemERP.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnails;

@Component
@Log4j2
@RequiredArgsConstructor
public class CustomFileUtil {

	@Value("${com.WiseForce.AssemERP.upload.path}")
	private String uploadPath;

	// 실행시 가장먼저 실행
	@PostConstruct
	public void init() {
		File tempFolder = new File(uploadPath);
		if (!tempFolder.exists()) {
			tempFolder.mkdir();
		}
		uploadPath = tempFolder.getAbsolutePath();
		log.info("---------CustomFIleUtil uploadPath--------");
		log.info(uploadPath);
	}

	public String saveFile(MultipartFile file) {

		if (file == null || file.getSize() == 0) {
			return null;
		}

		String saveName = UUID.randomUUID() + "_" + file.getOriginalFilename();
		System.out.println("CustomFileUtil saveFile saveName => " + file.getOriginalFilename());

		Path savePath = Paths.get(uploadPath, saveName);
		System.out.println("CustomFileUtil saveFile savePath => " + savePath);

		try {
			Files.copy(file.getInputStream(), savePath);
			String contentType = file.getContentType();
			if (contentType != null && contentType.startsWith("image")) {
				Path thumnailPath = Paths.get(uploadPath, "s_" + saveName);

				Thumbnails.of(savePath.toFile()).size(400, 600).toFile(thumnailPath.toFile());
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return saveName;
	}

	public ResponseEntity<Resource> getFile(String fileName) {
		Resource resource = new FileSystemResource(uploadPath+File.separator+fileName);
	
		System.out.println("ResponseEntity<Resource> getFile => "+uploadPath+File.separator+fileName);
	
		if(!resource.exists()) {
			// File.separator --> os에 맞는 경로 구분자
			// 요청 파일 없으면 default.jpeg 보여줘
			resource = new FileSystemResource(uploadPath+File.separator+"default.jpg");
		}
		// 응답 Header 생성후 Content-Type 적용
		HttpHeaders headers = new HttpHeaders();
	
		try {
			headers.add("Content-Type", Files.probeContentType(resource.getFile().toPath()));
		} catch (Exception e) {
				return ResponseEntity.internalServerError().build();
		}
		// 최종적	 	: 200 상태코드 +  응답 Header + 파일 Resource 전달
		// 주요 목적	: File D/L 또는 Image 보여줄때
		return ResponseEntity.ok().headers(headers).body(resource);

	}



	public void deleteFiles(String fileName) {
		if(fileName == null || fileName == "") {
			return;
		}
							// 썸네일 있는지 확인하고 삭제
			String 	thumnailFileName = "s_"+fileName;
			Path	thumnailPath	 = Paths.get(uploadPath, thumnailFileName);
			Path	filePath		 = Paths.get(uploadPath, fileName);

			try {
				Files.deleteIfExists(filePath);
				Files.deleteIfExists(thumnailPath);
			} catch (IOException e) {
				throw new RuntimeException(e.getMessage());
			}
		
		
		}
	
}
	
	
