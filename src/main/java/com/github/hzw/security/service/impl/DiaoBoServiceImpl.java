package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.DiaoBo;
import com.github.hzw.security.mapper.DiaoBoMapper;
import com.github.hzw.security.service.DiaoBoService;

@Transactional
@Service("diaoBoService")
public class DiaoBoServiceImpl implements DiaoBoService {
	
	@Autowired
	private DiaoBoMapper diaoBoMapper;

	@Override
	public PageView query(PageView pageView, DiaoBo t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<DiaoBo> list = diaoBoMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	@Override
	public List<DiaoBo> queryAll(DiaoBo t) {
		return diaoBoMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		diaoBoMapper.delete(id);
	}

	@Override
	public void update(DiaoBo t) throws Exception {
		diaoBoMapper.update(t);
	}

	@Override
	public DiaoBo getById(String id) {
		return diaoBoMapper.getById(id);
	}

	@Override
	public void add(DiaoBo t) throws Exception {
		diaoBoMapper.add(t);
	}

}
