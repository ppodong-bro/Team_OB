package com.oracle.oBootBoard03.service;

import java.util.List;

import com.oracle.oBootBoard03.dto.BoardDto;

public interface BoardService {
	int 			totelBoard();
	List<BoardDto>  boardList(BoardDto boardDto);
}
