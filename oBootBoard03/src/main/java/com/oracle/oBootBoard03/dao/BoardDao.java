package com.oracle.oBootBoard03.dao;

import java.util.List;

import com.oracle.oBootBoard03.dto.BoardDto;

public interface BoardDao {
	List<BoardDto> boardListSel();
	int            insertBoard(BoardDto boardDto);
}
