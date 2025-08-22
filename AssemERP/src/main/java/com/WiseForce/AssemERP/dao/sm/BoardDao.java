package com.WiseForce.AssemERP.dao.sm;

import java.util.List;

import com.WiseForce.AssemERP.dto.sm.BoardDTO;

public interface BoardDao 
{
	// 전체 게시판 목록 조회
	List<BoardDTO> 	selectBoardList(BoardDTO boardDTO);
	
	// 게시판 조회수 수정
	BoardDTO  selectBoardDetail(int boardNo);

    // 신규 게시판 등록
    void insertBoard(BoardDTO boardDTO);
    
    // 게시판 정보 수정
    void updateBoard(BoardDTO boardDTO);
    
    // 게시판 조회수 수정
    void updateReadCount(int boardNo);

    // 게시판 정보 삭제
    void deleteBoard(int boardNo);
    
    void increaseReadCount(int boardNo);

    // 전체 게시판 수 조회 (페이징을 위한
    int  getTotalBoardCount();
    
    // 전체 게시판 목록 조회
    List<BoardDTO> findAllBoards();
    
    // 특정 게시판 정보 조회
    BoardDTO findByBoardCode(int boardNo);
    
    BoardDTO getBoardDetail(int boardNo);

}
