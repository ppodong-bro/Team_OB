package com.WiseForce.AssemERP.service.sm;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Paging {

	private int totalCount;
	private int currentPage = 1;
	
	private int rowPage = 10;
	private int pageBlock = 10;
	
	private int start;
	private int end;

	private int startPage;
	private int endPage;

	private int totalPage;
	
	/**
	 * 페이징 계산을 위한 생성자.
	 *
	 * @param totalCount 총 데이터 개수
	 * @param currentPage1 현재 페이지 번호
	 */
	public Paging(int totalCount, int currentPage1) 
	{
		this.totalCount  = totalCount;
		this.currentPage = currentPage1;
		
		start = (currentPage1 - 1) * rowPage + 1;
		end = start + rowPage - 1;
		
		totalPage = (int) Math.ceil((double)totalCount / rowPage);
		
		startPage = currentPage1 - (currentPage - 1) % pageBlock;
		endPage = startPage + pageBlock - 1;
		
		if(endPage > totalPage) {
			endPage = totalPage;
		}
	}
}
