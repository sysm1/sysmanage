package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.mapper.ClothInfoMapper;
import com.github.hzw.security.service.ClothInfoService;

@Transactional
@Service("clothInfoService")
public class ClothInfoServiceImpl implements ClothInfoService {

	@Autowired
	private ClothInfoMapper clothInfoMapper;
	
	@Override
	public PageView query(PageView pageView, ClothInfo t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<ClothInfo> list = clothInfoMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<ClothInfo> queryAll(ClothInfo t) {
		return clothInfoMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		clothInfoMapper.delete(id);
		
	}

	@Override
	public void update(ClothInfo t) throws Exception {
		this.clothInfoMapper.update(t);
		
	}

	@Override
	public ClothInfo getById(String id) {
		return this.clothInfoMapper.getById(id);
	}

	@Override
	public void add(ClothInfo t) throws Exception {
		this.clothInfoMapper.add(t);
	}

	
	
}
