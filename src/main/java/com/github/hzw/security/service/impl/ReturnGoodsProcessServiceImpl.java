package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ReturnGoodsProcess;
import com.github.hzw.security.mapper.ReturnGoodsProcessMapper;
import com.github.hzw.security.service.ReturnGoodsProcessService;

@Transactional
@Service("returnGoodsProcessService")
public class ReturnGoodsProcessServiceImpl implements ReturnGoodsProcessService {

	@Autowired
	private ReturnGoodsProcessMapper returnGoodsProcessMapper;
	
	@Override
	public PageView query(PageView pageView, ReturnGoodsProcess t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<ReturnGoodsProcess> list = returnGoodsProcessMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<ReturnGoodsProcess> queryAll(ReturnGoodsProcess t) {
		return returnGoodsProcessMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		returnGoodsProcessMapper.delete(id);
		
	}

	@Override
	public void update(ReturnGoodsProcess t) throws Exception {
		this.returnGoodsProcessMapper.update(t);
		
	}

	@Override
	public ReturnGoodsProcess getById(String id) {
		return this.returnGoodsProcessMapper.getById(id);
	}

	@Override
	public void add(ReturnGoodsProcess t) throws Exception {
		this.returnGoodsProcessMapper.add(t);
	}


}
