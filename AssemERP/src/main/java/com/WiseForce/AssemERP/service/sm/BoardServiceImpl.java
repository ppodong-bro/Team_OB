package com.WiseForce.AssemERP.service.sm;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.WiseForce.AssemERP.account.service.CustomUser;
import com.WiseForce.AssemERP.dao.sm.BoardDao;
import com.WiseForce.AssemERP.dto.sm.BoardDTO;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService 
{
	private final BoardDao boardDao;

	@Override
	public int getTotalCount(BoardDTO boardDTO) 
	{
		System.out.println("BoardServiceImpl totalBoardCount Start");
		return boardDao.getTotalBoardCount();
	}

	@Override
	public List<BoardDTO> getBoardList(BoardDTO boardDTO) 
	{
		System.out.println("BoardServiceImpl selectBoardList Start");
		return boardDao.selectBoardList(boardDTO);
	}

	@Override
	public void saveBoard(BoardDTO boardDTO) 
	{
		System.out.println("BoardServiceImpl saveBoard Start");
		
        Authentication authentication = SecurityContextHolder
        							   .getContext()
        							   .getAuthentication();

        if (authentication != null && authentication.getPrincipal() instanceof CustomUser) 
        {
            CustomUser customUser = (CustomUser) authentication.getPrincipal();
            
            int empNo = customUser.getAccountDTO().getEmpNo();
            
            boardDTO.setRegistrar(empNo);
            boardDTO.setEmpNo(empNo);
            
            System.out.println("BoardServiceImpl saveBoard 1 Registrar->"+empNo);
            System.out.println("BoardServiceImpl saveBoard 1 empNo->"+empNo);
        } else {
        	
        	System.out.println("BoardServiceImpl saveBoard 1 empNo->"+boardDTO.getEmpNo());
        	boardDTO.setRegistrar(1005); 
        	boardDTO.setEmpNo(1005);
        	System.out.println("BoardServiceImpl saveBoard 2 Registrar->"+boardDTO.getRegistrar());
        }
        
        boardDao.insertBoard(boardDTO);
	}

	@Override
	public void updateBoard(BoardDTO boardDTO) 
	{
		System.out.println("BoardServiceImpl updateBoard Start");
		boardDao.updateBoard(boardDTO);
	}

	@Override
	public void deleteBoard(int boardNo) 
	{
		System.out.println("BoardServiceImpl deleteBoard Start");
		boardDao.deleteBoard(boardNo);
	}

	@Override
	public BoardDTO getBoardDetail(int boardNo) 
	{
		boardDao.increaseReadCount(boardNo);
		return boardDao.getBoardDetail(boardNo);
	}

}
