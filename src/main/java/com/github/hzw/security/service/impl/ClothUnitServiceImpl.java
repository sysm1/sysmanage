package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ClothUnit;
import com.github.hzw.security.mapper.ClothUnitMapper;
import com.github.hzw.security.service.ClothUnitService;

@Transactional
@Service("clothUnitService")
public class ClothUnitServiceImpl implements ClothUnitService {

	@Autowired
	private ClothUnitMapper clothUnitMapper;
	
	@Override
	public PageView query(PageView pageView, ClothUnit t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<ClothUnit> list = clothUnitMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<ClothUnit> queryAll(ClothUnit t) {
		return clothUnitMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		clothUnitMapper.delete(id);
		
	}

	@Override
	public void update(ClothUnit t) throws Exception {
		this.clothUnitMapper.update(t);
		
	}

	@Override
	public ClothUnit getById(String id) {
		return this.clothUnitMapper.getById(id);
	}

	@Override
	public void add(ClothUnit t) throws Exception {
		this.clothUnitMapper.add(t);
	}
	
	// 跟据clothId选择
	public ClothUnit queryClothId(Integer clothId){
		return clothUnitMapper.queryClothId(clothId);
	}
	
}
