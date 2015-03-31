package com.github.hzw.security.service;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.OrderSummary;

public interface OrderSummaryService extends BaseService<OrderSummary> {
	
	/**
	 * 保存下单
	 * @param info
	 */
	public void saveOrderSummary(OrderSummary info);

}
