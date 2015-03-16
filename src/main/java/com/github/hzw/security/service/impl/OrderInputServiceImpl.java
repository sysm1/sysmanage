package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.OrderInputVO;
import com.github.hzw.security.entity.OrderInput;
import com.github.hzw.security.mapper.OrderInputMapper;
import com.github.hzw.security.service.OrderInputService;

@Transactional
@Service("orderInputService")
public class OrderInputServiceImpl implements OrderInputService {

	@Autowired
	private OrderInputMapper orderInputMapper;
	
	@Override
	public PageView queryVO(PageView pageView, OrderInputVO t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<OrderInputVO> list = orderInputMapper.queryVO(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<OrderInput> queryAll(OrderInput t) {
		return orderInputMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		orderInputMapper.delete(id);
		
	}

	@Override
	public void update(OrderInput t) throws Exception {
		this.orderInputMapper.update(t);
		
	}

	@Override
	public OrderInput getById(String id) {
		return this.orderInputMapper.getById(id);
	}

	@Override
	public void add(OrderInput t) throws Exception {
		this.orderInputMapper.add(t);
	}


	@Override
	public PageView query(PageView pageView, OrderInput t) {
		return null;
	}

}
