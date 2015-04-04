package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.mapper.OrderSummaryMapper;
import com.github.hzw.security.service.OrderSummaryService;

@Transactional
@Service("orderSummaryService")
public class OrderSummaryServiceImpl implements OrderSummaryService {

	@Autowired
	private OrderSummaryMapper orderSummaryMapper;
	
	@Override
	public PageView query(PageView pageView, OrderSummary t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<OrderSummary> list = orderSummaryMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}
	
	@Override
	public void saveOrderSummary(OrderSummary info){
		try {
			//判断下单的状态
			
			this.add(info);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public List<OrderSummary> queryAll(OrderSummary t) {
		return orderSummaryMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		orderSummaryMapper.delete(id);
		
	}

	@Override
	public void update(OrderSummary t) throws Exception {
		this.orderSummaryMapper.update(t);
		
	}

	@Override
	public OrderSummary getById(String id) {
		return this.orderSummaryMapper.getById(id);
	}

	@Override
	public void add(OrderSummary t) throws Exception {
		this.orderSummaryMapper.add(t);
	}


	@Override
	public PageView queryPrint(PageView pageView, Map<String, Object> map) {
		map.put("paging", pageView);
		List<OrderSummary> list = orderSummaryMapper.queryPrint(map);
		pageView.setRecords(list);
		return pageView;
	}
	
	// 打印通知
	public PageView queryNotify(PageView pageView, Map<String, Object> map ){
		map.put("paging", pageView);
		List<OrderSummary> list = orderSummaryMapper.queryNotify(map);
		pageView.setRecords(list);
		return pageView;
	}
	
	// 取消打印
	public void cancel(String notifyId){
		orderSummaryMapper.updateCancel(notifyId);
	}

	// 返回打印通知里的所有明细
	public List<OrderSummary> query(String notifyId ){
		List<OrderSummary> list = orderSummaryMapper.queryByNotifyId(notifyId);
		return list;
	}
	
	
}
