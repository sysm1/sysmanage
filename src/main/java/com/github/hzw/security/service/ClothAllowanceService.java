package com.github.hzw.security.service;

import java.util.Map;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ClothAllowance;

public interface ClothAllowanceService extends BaseService<ClothAllowance> {

	public ClothAllowance queryByClothAndFactory(Integer clothId, Integer factoryId);
	
	// public ClothAllowance queryByCloth(String clothId);
	
	public PageView queryByFind(PageView pageView, Map<String, Object> map );
	
	/**
	 * 先从库里查找clothId,factoryId唯一的值
	 */
	public void addAllowance(ClothAllowance t) throws Exception;
	
}
