package com.oracle.oBootBoard03.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.oracle.oBootBoard03.dto.BoardDto;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BoardDaoImpl implements BoardDao {

	private final SqlSession session;
	
	@Override
	public List<BoardDto> boardListSel() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertBoard(BoardDto boardDto) {
		// TODO Auto-generated method stub
		return 0;
	}

}
