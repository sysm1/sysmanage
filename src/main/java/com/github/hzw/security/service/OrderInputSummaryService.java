package com.github.hzw.security.service;

import java.util.List;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.OrderInputSummaryVO;
import com.github.hzw.security.entity.OrderInputSummary;

public interface OrderInputSummaryService extends
		BaseService<OrderInputSummary> {
	
	/**
	 * 查询下单预录入
	 * @param pageView
	 * @param t
	 * @return
	 */
	public PageView queryVO(PageView pageView, OrderInputSummary t);
	
	/**
	 * 查询下单预录入明细
	 * @param orderInputSummary
	 * @return
	 */
	public PageView queryOrderInputBySummaryId(PageView pageView,OrderInputSummary orderInputSummary);

}
