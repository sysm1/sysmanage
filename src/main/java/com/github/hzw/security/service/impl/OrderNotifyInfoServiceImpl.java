package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.OrderNotifyInfo;
import com.github.hzw.security.mapper.OrderNotifyInfoMapper;
import com.github.hzw.security.service.OrderNotifyInfoService;

@Transactional
@Service("orderNotifyInfoService")
public class OrderNotifyInfoServiceImpl implements OrderNotifyInfoService {

	@Autowired
	private OrderNotifyInfoMapper orderNotifyInfoMapper;
	
	@Override
	public PageView query(PageView pageView, OrderNotifyInfo t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<OrderNotifyInfo> list = orderNotifyInfoMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<OrderNotifyInfo> queryAll(OrderNotifyInfo t) {
		return orderNotifyInfoMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		orderNotifyInfoMapper.delete(id);
		
	}

	@Override
	public void update(OrderNotifyInfo t) throws Exception {
		this.orderNotifyInfoMapper.update(t);
		
	}

	@Override
	public OrderNotifyInfo getById(String id) {
		return this.orderNotifyInfoMapper.getById(id);
	}

	@Override
	public void add(OrderNotifyInfo t) throws Exception {
		this.orderNotifyInfoMapper.add(t);
	}

}
