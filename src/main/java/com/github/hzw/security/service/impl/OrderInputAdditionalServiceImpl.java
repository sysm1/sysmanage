package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.OrderInputAdditional;
import com.github.hzw.security.mapper.OrderInputAdditionalMapper;
import com.github.hzw.security.service.OrderInputAdditionalService;

@Transactional
@Service("orderInputAdditionalService")
public class OrderInputAdditionalServiceImpl implements
		OrderInputAdditionalService {

	@Autowired
	private OrderInputAdditionalMapper orderInputAdditionalMapper;
	
	@Override
	public PageView query(PageView pageView, OrderInputAdditional t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<OrderInputAdditional> list = orderInputAdditionalMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<OrderInputAdditional> queryAll(OrderInputAdditional t) {
		return orderInputAdditionalMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		orderInputAdditionalMapper.delete(id);
		
	}

	@Override
	public void update(OrderInputAdditional t) throws Exception {
		this.orderInputAdditionalMapper.update(t);
		
	}

	@Override
	public OrderInputAdditional getById(String id) {
		return this.orderInputAdditionalMapper.getById(id);
	}

	@Override
	public void add(OrderInputAdditional t) throws Exception {
		this.orderInputAdditionalMapper.add(t);
	}

}
