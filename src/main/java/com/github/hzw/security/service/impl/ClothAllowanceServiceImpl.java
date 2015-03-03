package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ClothAllowance;
import com.github.hzw.security.mapper.ClothAllowanceMapper;
import com.github.hzw.security.service.ClothAllowanceService;
import com.github.hzw.security.service.ClothUnitService;

@Transactional
@Service("clothAllowanceService")
public class ClothAllowanceServiceImpl implements ClothAllowanceService {

	@Autowired
	private ClothAllowanceMapper clothAllowanceMapper;
	
	@Autowired
	private ClothUnitService clothUnitService;
	
	@Override
	public PageView query(PageView pageView, ClothAllowance t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<ClothAllowance> list = clothAllowanceMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	public ClothAllowance queryByClothAndFactory(Integer clothId, Integer factoryId) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("clothId", clothId);
		map.put("factoryId", factoryId);
		return clothAllowanceMapper.queryByClothAndFactory(map);
	}
	
	@Override
	public List<ClothAllowance> queryAll(ClothAllowance t) {
		return clothAllowanceMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		clothAllowanceMapper.delete(id);
		
	}

	@Override
	public void update(ClothAllowance t) throws Exception {
		// 转换单位
		// ClothUnit unit = clothUnitService.
		
		if( t.getId() != null ) {
			
			this.clothAllowanceMapper.update(t);
		} else {
			ClothAllowance t1 = this.queryByClothAndFactory(t.getClothId(), t.getFactoryId());
			t.setId(t1.getId());
			t.setOldSum(t1.getAllowance()); // 旧余量
			
		}
		
	}

	@Override
	public ClothAllowance getById(String id) {
		return this.clothAllowanceMapper.getById(id);
	}

	@Override
	public void add(ClothAllowance t) throws Exception {
		this.clothAllowanceMapper.add(t);
	}

}
