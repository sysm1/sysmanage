package com.github.hzw.security.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.City;

public interface CityService extends BaseService<City>{
	
	/**
	 * 获取分点信息
	 * @param request
	 * @return
	 */
	public List<City> getCitys(HttpServletRequest request);

}
