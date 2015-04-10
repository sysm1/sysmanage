package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.mapper.TechnologyInfoMapper;
import com.github.hzw.security.service.TechnologyInfoService;


@Transactional
@Service("technologyInfoService")
public class TechnologyInfoServiceImpl implements TechnologyInfoService {

	@Autowired
	private TechnologyInfoMapper technologyInfoMapper;
	
	@Override
	public PageView query(PageView pageView, TechnologyInfo t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<TechnologyInfo> list = technologyInfoMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<TechnologyInfo> queryAll(TechnologyInfo t) {
		return technologyInfoMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		technologyInfoMapper.delete(id);
		
	}

	@Override
	public void update(TechnologyInfo t) throws Exception {
		this.technologyInfoMapper.update(t);
		
	}

	@Override
	public TechnologyInfo getById(String id) {
		return this.technologyInfoMapper.getById(id);
	}

	@Override
	public void add(TechnologyInfo t) throws Exception {
		this.technologyInfoMapper.add(t);
	}

	@Override
	public TechnologyInfo isExist(String name) {
		return this.technologyInfoMapper.isExist(name);
	}
	
	public List<TechnologyInfo> queryPinyin(String name){
		Map<String, Object> map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(name)){
			name = name.toUpperCase();
		}
		map.put("t", name);
		return technologyInfoMapper.queryPinyin(map);
	}
}
