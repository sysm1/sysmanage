package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.TechnologyInfo;

public interface TechnologyInfoMapper extends BaseMapper<TechnologyInfo> {

	public TechnologyInfo isExist(String name);
	public List<TechnologyInfo> queryPinyin(Map<String, Object> map);
}
