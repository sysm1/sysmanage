package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.Mark;
import com.github.hzw.security.mapper.MarkMapper;
import com.github.hzw.security.service.MarkService;

@Transactional
@Service("markService")
public class MarkServiceImpl implements MarkService {
	
	@Autowired
	private MarkMapper markMapper;

	@Override
	public List<Mark> queryAll(Mark t) {
		return markMapper.queryAll(t);
	}

	public void add(Mark mark) throws Exception {
		markMapper.add(mark);
	}

	public void delete(String id) throws Exception {
		markMapper.delete(id);
	}

	public Mark getById(String id) {
		return markMapper.getById(id);
	}

	public void update(Mark mark) throws Exception {
		markMapper.update(mark);
	}

	@Override
	public PageView query(PageView pageView, Mark t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<Mark> list = markMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

}
