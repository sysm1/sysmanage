package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.City;
import com.github.hzw.security.mapper.CityMapper;
import com.github.hzw.security.service.CityService;

@Transactional
@Service("cityService")
public class CityServiceImpl implements CityService{
	
	@Autowired
	private CityMapper cityMapper;

	@Override
	public PageView query(PageView pageView, City t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<City> list = cityMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}
	
	public List<City> getCitys(HttpServletRequest request){
		Account user=(Account) request.getSession().getAttribute("userSession");
		City t=new City();
		if(null!=user.getCityId()){
			t.setId(user.getCityId());
			t.setStatus(1);
		}
		return queryAll(t);
	}

	@Override
	public List<City> queryAll(City t) {
		return cityMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		cityMapper.delete(id);
	}

	@Override
	public void update(City t) throws Exception {
		cityMapper.update(t);
	}

	@Override
	public City getById(String id) {
		return cityMapper.getById(id);
	}

	@Override
	public void add(City t) throws Exception {
		cityMapper.add(t);
	}

}
