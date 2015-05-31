package com.github.hzw.security.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.OrderNotifyInfo;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.entity.RecordLog;
import com.github.hzw.security.mapper.OrderNotifyInfoMapper;
import com.github.hzw.security.service.OrderNotifyInfoService;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.security.service.RecordLogService;
import com.github.hzw.util.Common;
import com.github.hzw.util.DateUtil;

@Transactional
@Service("orderNotifyInfoService")
public class OrderNotifyInfoServiceImpl implements OrderNotifyInfoService {

	private static Logger logger = LoggerFactory.getLogger(OrderNotifyInfoServiceImpl.class);
	
	@Autowired
	private OrderNotifyInfoMapper orderNotifyInfoMapper;
	
	@Autowired
	private OrderSummaryService orderSummaryService;
	
	@Inject
	private RecordLogService recordLogService;
	
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

	// 
	public void save(OrderNotifyInfo info) throws Exception {
		String ids = info.getSummaryIds();
		String[] tmp = ids.split("[, ]");
		OrderSummary summary = null;
		this.add(info);
		
		for(String id : tmp) {
			summary = orderSummaryService.getById(id);
			summary.setPrintStatus(1); // 改变状态为已打印
			summary.setPrintNum(summary.getPrintNum() + 1);
			summary.setNotifyId(info.getId());
			summary.setNotifyTime(info.getCreateTime());
			summary.setNo(info.getNo());
			orderSummaryService.update(summary);
		}
		
	}
	
	public PageView queryFind(PageView pageView, Map<String, Object> map ){
		map.put("paging", pageView);
		List<OrderNotifyInfo> list = orderNotifyInfoMapper.queryFind(map);
		pageView.setRecords(list);
		return pageView;
	}
	
	// 撤销打印
	public void cancel(String[] ids) throws Exception {
		
		if(ids == null || ids.length == 0) return;
		
		for(String id : ids) {
			orderNotifyInfoMapper.delete(id);
			orderSummaryService.cancel(id);
		}
		
		// 记录撤销记录
		try{
			String username = Common.findAuthenticatedUsername();
			String model = "notify";
			String opType = "cancel";
			String opDate = DateUtil.date2Str(new Date(), "yyyy-MM-dd");
			
			RecordLog log = new RecordLog();
			log.setCreateTime(new Date());
			log.setModel(model);
			log.setOpDate(opDate);
			log.setOpType(opType);
			log.setUsername(username);
			log.setNum(ids.length);  // 删除一条记录
			recordLogService.add(log);
			
		}catch(Exception e) {
			logger.error("", e);
		}
		
		
	}
	
}
