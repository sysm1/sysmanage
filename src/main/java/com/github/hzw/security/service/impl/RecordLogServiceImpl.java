package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.RecordLog;
import com.github.hzw.security.mapper.RecordLogMapper;
import com.github.hzw.security.service.RecordLogService;

@Transactional
@Service("recordLogService")
public class RecordLogServiceImpl implements RecordLogService {

	
	@Autowired
	private RecordLogMapper recordLogMapper;
	
	@Override
	public PageView query(PageView pageView, RecordLog t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<RecordLog> list = recordLogMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	@Override
	public List<RecordLog> queryAll(RecordLog t) {
		
		return recordLogMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		recordLogMapper.delete(id);
		
	}

	@Override
	public void update(RecordLog t) throws Exception {
		recordLogMapper.update(t);
		
	}

	@Override
	public RecordLog getById(String id) {
		return recordLogMapper.getById(id);
	}

	@Override
	public void add(RecordLog t) throws Exception {
		recordLogMapper.add(t);
	}

	
	public int sum(Map<String, Object> map){
		return recordLogMapper.sum(map);
	}
	
}
