package com.kh.wehub.common.util;

import lombok.Data;

@Data
public class PageInfo {
	private int currentPage;
	
	private int pageLimit;
	
	private int listCount;
	
	private int listLimit;	
	
	public PageInfo(int currentPage, int pageLimit, int listCount, int listLimit) {
		this.currentPage = currentPage;
		this.pageLimit = pageLimit;
		this.listCount = listCount;
		this.listLimit = listLimit;
	}

	public int getMaxPage() {
		
		return (int)Math.ceil((double)this.listCount / this.listLimit);
	}

	public int getStartPage() {
		
		return (this.pageLimit * ((this.currentPage - 1) / this.pageLimit)) + 1;
	}

	public int getEndPage() {
		
		int endPage = getStartPage() + this.pageLimit - 1;
		
		return endPage > getMaxPage() ? getMaxPage() : endPage;
	}	

	public int getCurrentPage() {
		return this.currentPage;
	}

	public int getPrvePage() {
		int prevPage = this.getCurrentPage() - 1;
		
		return prevPage < 1 ? 1 : prevPage;
	}

	public int getNextPage() {
		int nextPage = this.getCurrentPage() + 1;
		
		return nextPage > getMaxPage() ? getMaxPage() : nextPage;
	}
	
	public int getStartList() {
		return (this.getCurrentPage() - 1) * this.listLimit + 1;
	}
	
	public int getEndList() {
		int endList = this.getStartList() + this.listLimit - 1;
		
		return endList > this.listCount ? this.listCount : endList;
	}
}