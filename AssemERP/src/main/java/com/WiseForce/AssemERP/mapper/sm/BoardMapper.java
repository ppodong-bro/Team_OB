package com.WiseForce.AssemERP.mapper.sm;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.WiseForce.AssemERP.dto.sm.BoardDTO;

@Mapper
public interface BoardMapper  
{
	int 			totalBoardCount();
	
	List<BoardDTO>	selectBoardList(BoardDTO boardDTO);
	
	BoardDTO		selectBoardDetail(int boardNo);
	
	void 			updateReadCount(int boardNo);
	
	void 			insertBoard(BoardDTO boardDTO);
	
	void 			updateBoard(BoardDTO boardDTO);
	
	void 			deleteBoard(int boardNo);
}
