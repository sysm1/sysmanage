package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.DateVersion;
import com.github.hzw.security.mapper.DateVersionMapper;
import com.github.hzw.security.service.DateVersionService;

@Transactional
@Service("dateVersionService")
public class DateVersionServiceImpl implements DateVersionService {

	@Autowired
	private DateVersionMapper dateVersionMapper;
	
	@Override
	public PageView query(PageView pageView, DateVersion t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<DateVersion> list = dateVersionMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<DateVersion> queryAll(DateVersion t) {
		return dateVersionMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		dateVersionMapper.delete(id);
		
	}

	@Override
	public void update(DateVersion t) throws Exception {
		this.dateVersionMapper.update(t);
		
	}

	@Override
	public DateVersion getById(String id) {
		return this.dateVersionMapper.getById(id);
	}

	@Override
	public void add(DateVersion t) throws Exception {
		this.dateVersionMapper.add(t);
	}
	
	/**
	 * category : printsummary
	 * dateK  yyyy-MM-dd
	 */
	public int getValue(String category, String dateK) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("category", category);
		map.put("dateK", dateK);
		DateVersion dv = dateVersionMapper.getByCategoryAndDate(map);
		if(dv != null) {
			dv.setValueV(dv.getValueV() + 1);
			try {
				this.dateVersionMapper.update(dv);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			dv = new DateVersion();
			dv.setCategory(category);
			dv.setDateK(dateK);
			dv.setValueV(1);
			System.out.println("============111111111111111==========="+dv.toString());
			try {
				this.add(dv);
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println("===========4444444444444444============");
		}
		return dv.getValueV();
	}
	

}
