package com.github.hzw.security.service;

import java.util.Map;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.OrderSummary;

public interface OrderSummaryService extends BaseService<OrderSummary> {
	
	/**
	 * 保存下单
	 * @param info
	 */
	public void saveOrderSummary(OrderSummary info);

	public PageView queryPrint(PageView pageView, Map<String, Object> map );
	
}
