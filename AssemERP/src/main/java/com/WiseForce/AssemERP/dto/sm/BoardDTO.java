package com.WiseForce.AssemERP.dto.sm;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO 
{
	//게시판(공지사항) 테이블
	private int 	boardNo;
	private int		empNo;
	private String	title;
	private String	boardContent;
	private int		readCount;
	private int		groupNo;
	private int		reLvl;
	private int		reStep;
	private int 	registrar;
	private Date 	inDate;
	
	// 페이징 처리를 위한 추가 필드
	private int		start;
	private int 	end;
	
	// 조회용 필드
	private String 	empName;	//작성자명
	
	// 검색 조건
    private String searchType;
    private String searchKeyword;
}
