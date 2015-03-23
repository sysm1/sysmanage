package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.OrderInputSummaryVO;
import com.github.hzw.security.entity.OrderInputSummary;
import com.github.hzw.security.mapper.OrderInputSummaryMapper;
import com.github.hzw.security.service.OrderInputSummaryService;
import com.github.hzw.util.Common;

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
	public PageView queryVO(PageView pageView, OrderInputSummary t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<OrderInputSummaryVO> list = orderInputSummaryMapper.queryVO(map);
		pageView.setRecords(list);
		return pageView;
	}

	/**
	 * 查询下单预录入明细
	 * @param orderInputSummary
	 * @return
	 */
	@Override
	public PageView queryOrderInputBySummaryId(PageView pageView,OrderInputSummary t){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<OrderInputSummaryVO> list = orderInputSummaryMapper.queryOrderInputBySummaryId(map);
		pageView.setRecords(list);
		return pageView;
	}
	
	/**
	 * 获取订单号
	 * @return
	 */
	@Override
	public String getOrderNo(){
		String word="FX";
		String time=Common.fromDateY();
		return word+time;
	}
	
	/**
	 * 获取汇总对象
	 * @param
	 * @return
	 */
	@Override
	public OrderInputSummaryVO getVOById(String id){
		return orderInputSummaryMapper.getVOById(id);
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
