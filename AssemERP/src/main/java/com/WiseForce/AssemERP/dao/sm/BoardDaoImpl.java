package com.WiseForce.AssemERP.dao.sm;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.sm.BoardDTO;
import com.WiseForce.AssemERP.mapper.sm.BoardMapper;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BoardDaoImpl implements BoardDao 
{
	private final BoardMapper boardMapper;
	
	@Override
	public int getTotalBoardCount() 
	{
		System.out.println("BoardDaoImpl getTotalBoardCount Start");
		
		return boardMapper.totalBoardCount();
	}
	
	@Override
	public List<BoardDTO> selectBoardList(BoardDTO boardDTO) 
	{
		System.out.println("BoardDaoImpl selectBoardList Start");
		
		return boardMapper.selectBoardList(boardDTO);
	}
	
	@Override
	public BoardDTO selectBoardDetail(int boardNo) 
	{
		System.out.println("BoardDaoImpl selectBoardDetail Start");
		
		return boardMapper.selectBoardDetail(boardNo);
	}

	@Override
	public void insertBoard(BoardDTO dept) 
	{
		System.out.println("BoardDaoImpl saveBoard Start");
		
		boardMapper.insertBoard(dept);
	}

	@Override
	public void updateBoard(BoardDTO dept) 
	{
		System.out.println("BoardDaoImpl updateBoard Start");
		
		boardMapper.updateBoard(dept);
	}
	
	@Override
	public void updateReadCount(int boardNo) 
	{
		System.out.println("BoardDaoImpl updateReadCount Start");
		
		boardMapper.updateReadCount(boardNo);
	}
	
	@Override
	public void deleteBoard(int deptCode) 
	{
		System.out.println("BoardDaoImpl deleteBoard Start");
		
		boardMapper.deleteBoard(deptCode);
	}

	@Override
	public void increaseReadCount(int boardNo) 
	{
		boardMapper.updateReadCount(boardNo);
	}

	@Override
	public BoardDTO getBoardDetail(int boardNo) 
	{
		return boardMapper.selectBoardDetail(boardNo);
	}
	
	@Override
	public List<BoardDTO> findAllBoards() 
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BoardDTO findByBoardCode(int deptCode) 
	{
		// TODO Auto-generated method stub
		return null;
	}
}
