package com.github.hzw.security.service;

import java.util.List;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.FactoryInfo;

public interface FactoryInfoService extends BaseService<FactoryInfo> {

	public FactoryInfo isExist(String name);
	
	public List<FactoryInfo> queryPinyin(String name,Integer cityId);
	
	public List<FactoryInfo> queryPinyinByBean(FactoryInfo info);
}
