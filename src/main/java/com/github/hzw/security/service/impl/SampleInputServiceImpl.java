package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.SampleInput;
import com.github.hzw.security.mapper.SampleInputMapper;
import com.github.hzw.security.service.SampleInputService;

@Transactional
@Service("sampleInputService")
public class SampleInputServiceImpl implements SampleInputService {

	@Autowired
	private SampleInputMapper sampleInputMapper;
	
	@Override
	public PageView query(PageView pageView, SampleInput t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<SampleInput> list = sampleInputMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<SampleInput> queryAll(SampleInput t) {
		return sampleInputMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		sampleInputMapper.delete(id);
		
	}

	@Override
	public void update(SampleInput t) throws Exception {
		this.sampleInputMapper.update(t);
		
	}

	@Override
	public SampleInput getById(String id) {
		return this.sampleInputMapper.getById(id);
	}

	@Override
	public void add(SampleInput t) throws Exception {
		this.sampleInputMapper.add(t);
	}

}
