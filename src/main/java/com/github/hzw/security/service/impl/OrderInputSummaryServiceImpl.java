package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.OrderInputSummary;
import com.github.hzw.security.mapper.OrderInputSummaryMapper;
import com.github.hzw.security.service.OrderInputSummaryService;

@Transactional
@Service("orderInputSummaryService")
public class OrderInputSummaryServiceImpl implements OrderInputSummaryService {

	@Autowired
	private OrderInputSummaryMapper orderInputSummaryMapper;
	
	@Override
	public PageView query(PageView pageView, OrderInputSummary t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<OrderInputSummary> list = orderInputSummaryMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<OrderInputSummary> queryAll(OrderInputSummary t) {
		return orderInputSummaryMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		orderInputSummaryMapper.delete(id);
		
	}

	@Override
	public void update(OrderInputSummary t) throws Exception {
		this.orderInputSummaryMapper.update(t);
		
	}

	@Override
	public OrderInputSummary getById(String id) {
		return this.orderInputSummaryMapper.getById(id);
	}

	@Override
	public void add(OrderInputSummary t) throws Exception {
		this.orderInputSummaryMapper.add(t);
	}

}
