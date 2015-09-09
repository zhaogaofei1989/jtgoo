package cn.jtgoo.cms.util;

import java.util.List;

/**
 * 分页信息
 * 
 * @author tyg
 * 
 */
public class PageBean {

	// 页面传递或配置的
	private int currentPage; // 当前页码
	private int pageSize; // 每页显示多少条记录

	// 查询数据库
	private int recordCount; // 总记录数
	private List recordList; // 本页的数据列表

	// 计算
	private int pageCount; // 总页码
	private int beginPageIndex; // 页码列表的开始索引
	private int endPageIndex; // 页码列表的结束索引
	private int previousPage; // 上一页
	private int nextPage; // 下一页

	public PageBean(int currentPage, int pageSize, int recordCount,
			List recordList) {
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.recordCount = recordCount;
		this.recordList = recordList;

		// ==============================================
		// 计算其他3个属性
		// ==============================================
		// 总页码
		this.pageCount = (recordCount + pageSize - 1) / pageSize;

		// 页码列表的开始索引与结束索引
		if (pageCount <= 10) {
			beginPageIndex = 1;
			endPageIndex = pageCount;
		} else {
			// 显示前4个，后5个，共10个页码
			beginPageIndex = currentPage - 4;
			endPageIndex = currentPage + 5;

			// 前面不足4个，显示前10个页码
			if (beginPageIndex < 1) {
				beginPageIndex = 1;
				endPageIndex = 10;
			}
			// 后面不足5个，显示后10个页码
			else if (endPageIndex > pageCount) {
				beginPageIndex = pageCount - 10 + 1;
				endPageIndex = pageCount;
			}
		}
	}

	public List getRecordList() {
		return recordList;
	}

	public void setRecordList(List recordList) {
		this.recordList = recordList;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getRecordCount() {
		return recordCount;
	}

	public void setRecordCount(int recordCount) {
		this.recordCount = recordCount;
	}

	public int getBeginPageIndex() {
		return beginPageIndex;
	}

	public void setBeginPageIndex(int beginPageIndex) {
		this.beginPageIndex = beginPageIndex;
	}

	public int getEndPageIndex() {
		return endPageIndex;
	}

	public void setEndPageIndex(int endPageIndex) {
		this.endPageIndex = endPageIndex;
	}

	public int getNextPage() {
		nextPage = this.currentPage + 1;
		if (nextPage > this.pageCount)
			nextPage = this.pageCount;
		return nextPage;
	}
	public int getPreviousPage() {
		previousPage = this.currentPage - 1;
		if (previousPage < 1)
			previousPage = 1;
		return previousPage;
	}
	
}
