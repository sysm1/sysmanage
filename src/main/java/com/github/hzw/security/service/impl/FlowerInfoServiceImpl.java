package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.mapper.FlowerInfoMapper;
import com.github.hzw.security.service.FlowerInfoService;

@Transactional
@Service("flowerInfoService")
public class FlowerInfoServiceImpl implements FlowerInfoService {

	@Autowired
	private FlowerInfoMapper flowerInfoMapper;
	
	@Override
	public PageView query(PageView pageView, FlowerInfo t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<FlowerInfo> list = flowerInfoMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<FlowerInfo> queryAll(FlowerInfo t) {
		return flowerInfoMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		flowerInfoMapper.delete(id);
		
	}

	@Override
	public void update(FlowerInfo t) throws Exception {
		this.flowerInfoMapper.update(t);
		
	}

	@Override
	public FlowerInfo getById(String id) {
		return this.flowerInfoMapper.getById(id);
	}

	@Override
	public void add(FlowerInfo t) throws Exception {
		this.flowerInfoMapper.add(t);
	}

}
