package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Unsub;
import com.github.hzw.security.mapper.UnsubMapper;
import com.github.hzw.security.service.UnsubInputService;

@Transactional
@Service("unsubInputService")
public class UnsubInputServiceImpl implements UnsubInputService {
	
	@Autowired
	private UnsubMapper unsubMapper;

	@Override
	public PageView query(PageView pageView, Unsub t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<Unsub> list = unsubMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	@Override
	public List<Unsub> queryAll(Unsub t) {
		return null;
	}

	@Override
	public void delete(String id) throws Exception {

	}

	@Override
	public void update(Unsub t) throws Exception {
		unsubMapper.update(t);
	}

	@Override
	public Unsub getById(String id) {
		return unsubMapper.getById(id);
	}

	@Override
	public void add(Unsub t) throws Exception {
		unsubMapper.add(t);
	}
}
