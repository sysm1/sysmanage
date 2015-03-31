package com.github.hzw.security.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.entity.ReturnGoodsProcess;

public interface ReturnGoodsProcessService extends
		BaseService<ReturnGoodsProcess> {
	
	/**
	 * 返回分页后的数据
	 * @param pageView
	 * @param t
	 * @return
	 */
	public PageView queryVO(PageView pageView,Map<String,String> map);
	
	/**
	 * 保存数据
	 * @param request
	 * @param summaryId
	 */
	public void save(HttpServletRequest request,OrderSummary orderSummary);
	
	/**
	 * 查询下单附属
	 * @param summaryId
	 * @return
	 */
	public List<ReturnGoodsProcess> queryBySummaryId(String summaryId);

}
