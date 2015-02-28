package com.github.hzw.security.service;

import java.util.List;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.TechnologyInfo;

public interface TechnologyInfoService extends BaseService<TechnologyInfo> {

	TechnologyInfo isExist(String name);
	public List<TechnologyInfo> queryPinyin(String name);
}
