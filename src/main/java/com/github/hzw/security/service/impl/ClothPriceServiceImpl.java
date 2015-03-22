package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ClothPrice;
import com.github.hzw.security.mapper.ClothPriceMapper;
import com.github.hzw.security.service.ClothPriceService;

@Transactional
@Service("clothPriceService")
public class ClothPriceServiceImpl implements ClothPriceService {

	@Autowired
	private ClothPriceMapper clothPriceMapper;
	
	@Override
	public PageView query(PageView pageView, ClothPrice t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<ClothPrice> list = clothPriceMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<ClothPrice> queryAll(ClothPrice t) {
		return clothPriceMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		clothPriceMapper.delete(id);
		
	}

	@Override
	public void update(ClothPrice t) throws Exception {
		
		this.clothPriceMapper.update(t);
		
	}

	@Override
	public ClothPrice getById(String id) {
		return this.clothPriceMapper.getById(id);
	}

	@Override
	public void add(ClothPrice t) throws Exception {
		
		this.clothPriceMapper.add(t);
	}

	

}
