package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ClothAllowance;
import com.github.hzw.security.mapper.ClothAllowanceMapper;
import com.github.hzw.security.service.ClothAllowanceService;

@Transactional
@Service("clothAllowanceService")
public class ClothAllowanceServiceImpl implements ClothAllowanceService {

	@Autowired
	private ClothAllowanceMapper clothAllowanceMapper;
	
	@Override
	public PageView query(PageView pageView, ClothAllowance t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<ClothAllowance> list = clothAllowanceMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<ClothAllowance> queryAll(ClothAllowance t) {
		return clothAllowanceMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		clothAllowanceMapper.delete(id);
		
	}

	@Override
	public void update(ClothAllowance t) throws Exception {
		this.clothAllowanceMapper.update(t);
		
	}

	@Override
	public ClothAllowance getById(String id) {
		return this.clothAllowanceMapper.getById(id);
	}

	@Override
	public void add(ClothAllowance t) throws Exception {
		this.clothAllowanceMapper.add(t);
	}

}
