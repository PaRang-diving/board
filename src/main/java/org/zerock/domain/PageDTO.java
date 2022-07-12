package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
public class PageDTO {
	
	// 시작페이지, 끝나는 페이지
	private int startPage, endPage;
	// 이전으로 가는 링크가 있느냐, 다음으로 가는 링크가 있느냐 (10개씩 표시되니 페이지가 넘어갈떄)
	private boolean prev, next;
	
	// 정보보관용도
	// 토탈카운트 값
	private int total;
	// 화면에 10개씩 뿌려줄때 20개씩 뿌려줄깨 50개씩 뿌려줄때 계산을 할수 있으려면...
	private Criteria cri;
	
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		//Math.ceil 올림        //0.3 -> 1 -> 10
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		
		this.startPage = endPage - 9;
		
		this.prev = this.startPage > 1;
										//71건.0 / 10 realEnd => 7.1 -> 8페이지
		int realEnd = (int)(Math.ceil( (total * 1.0) / cri.getAmount()) );
		
		this.endPage = realEnd <= endPage? realEnd : endPage;
		
		this.next = this.endPage < realEnd;
		
	}
}
