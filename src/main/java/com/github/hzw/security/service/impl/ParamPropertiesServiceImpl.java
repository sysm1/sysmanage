package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ParamProperties;
import com.github.hzw.security.mapper.ParamPropertiesMapper;
import com.github.hzw.security.service.ParamPropertiesService;


@Transactional
@Service("paramPropertiesService")
public class ParamPropertiesServiceImpl implements ParamPropertiesService {

	
	@Autowired
	private ParamPropertiesMapper paramPropertiesMapper;
	
	@Override
	public PageView query(PageView pageView, ParamProperties t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<ParamProperties> list = paramPropertiesMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<ParamProperties> queryAll(ParamProperties t) {
		return paramPropertiesMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		paramPropertiesMapper.delete(id);
		
	}

	@Override
	public void update(ParamProperties t) throws Exception {
		this.paramPropertiesMapper.update(t);
		
	}

	@Override
	public ParamProperties getById(String id) {
		return this.paramPropertiesMapper.getById(id);
	}

	@Override
	public void add(ParamProperties t) throws Exception {
		this.paramPropertiesMapper.add(t);
	}
	

}
