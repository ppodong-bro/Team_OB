package com.WiseForce.AssemERP.service.sm;

import java.util.List;

import com.WiseForce.AssemERP.dto.sm.BoardDTO;

public interface BoardService 
{
	int 			getTotalCount(BoardDTO boardDTO);
	List<BoardDTO> 	getBoardList(BoardDTO boardDTO);
	BoardDTO		getBoardDetail(int boardNo);
	void 			saveBoard(BoardDTO boardDTO);
	void 			updateBoard(BoardDTO boardDTO);
	void 			deleteBoard(int boardNo);
}