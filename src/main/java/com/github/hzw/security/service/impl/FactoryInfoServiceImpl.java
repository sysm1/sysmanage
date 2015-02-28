package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.mapper.FactoryInfoMapper;
import com.github.hzw.security.service.FactoryInfoService;


@Transactional
@Service("factoryInfoService")
public class FactoryInfoServiceImpl implements FactoryInfoService {

	@Autowired
	private FactoryInfoMapper factoryInfoMapper;
	
	@Override
	public PageView query(PageView pageView, FactoryInfo t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<FactoryInfo> list = factoryInfoMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	public List<FactoryInfo> queryPinyin(String name){
		Map<String, Object> map = new HashMap<String, Object>();
		String cn = name.toUpperCase();
		// System.out.println(cn);
		map.put("t", cn);
		return factoryInfoMapper.queryPinyin(map);
	}
	
	
	@Override
	public List<FactoryInfo> queryAll(FactoryInfo t) {
		return factoryInfoMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		factoryInfoMapper.delete(id);
		
	}

	@Override
	public void update(FactoryInfo t) throws Exception {
		this.factoryInfoMapper.update(t);
		
	}

	@Override
	public FactoryInfo getById(String id) {
		return this.factoryInfoMapper.getById(id);
	}

	@Override
	public void add(FactoryInfo t) throws Exception {
		this.factoryInfoMapper.add(t);
	}

	@Override
	public FactoryInfo isExist(String name) {
		return this.factoryInfoMapper.isExist(name);
	}
}
