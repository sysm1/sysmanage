package com.github.hzw.security.service;

import java.util.Map;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.OrderNotifyInfo;

public interface OrderNotifyInfoService extends BaseService<OrderNotifyInfo> {

	public void save(OrderNotifyInfo info) throws Exception;
	
	public PageView queryFind(PageView pageView, Map<String, Object> map );
	
	public void cancel(String[] ids) throws Exception;
}
