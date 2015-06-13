package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;
import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.FactoryInfo;

public interface FactoryInfoMapper extends BaseMapper<FactoryInfo> {

	public FactoryInfo isExist(String name);
	
	public List<FactoryInfo> queryPinyin(Map<String, Object> map);
	
	public List<FactoryInfo> queryPinyinByBean(Map<String, Object> map);
	
}
