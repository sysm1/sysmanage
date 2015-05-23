package com.github.hzw.security.service;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.OrderReportClothVO;
import com.github.hzw.security.VO.OrderReportFactoryVO;
import com.github.hzw.security.entity.OrderSummary;

public interface OrderSummaryService extends BaseService<OrderSummary> {
	
	/**
	 * 保存下单
	 * @param info
	 */
	public void saveOrderSummary(OrderSummary info);

	public PageView queryPrint(PageView pageView, Map<String, Object> map );
	

	public PageView queryNotify(PageView pageView, Map<String, Object> map );
	
	public void cancel(String notifyId);
	
	public List<OrderSummary> query(String notifyId);

	public PageView queryVO(PageView pageView, OrderSummary t);
	
	/**
	 * 查询未回单数量
	 * @param orderSummary
	 * @return
	 */
	public String queryNoReturnNum(OrderSummary orderSummary);

	
	public List<OrderReportFactoryVO> queryReportByFactory(Map<String, Object> map);
	 
	public List<OrderReportClothVO> queryReportByCloth(Map<String, Object> map);
	
	public PageView queryReportByFactoryPage(PageView pageView, Map<String, Object> map );
	
	public PageView queryReportByClothPage(PageView pageView, Map<String, Object> map );
	
	// public List<OrderSummary> queryReportBySummary(Map<String, Object> map);
	
	public List<OrderSummary> queryReportBySummary(Map<String, Object> map);
	
	public List<String> queryFactoryCodeByFactoryId(String factoryId);
	
	public List<String> queryFactoryColor(OrderSummary orderSummary);
	
}
