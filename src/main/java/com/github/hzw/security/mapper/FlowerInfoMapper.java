package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.FlowerInfo;

public interface FlowerInfoMapper extends BaseMapper<FlowerInfo> {

	public List<FlowerInfo> queryFind(FlowerInfo flowerInfo);
	
	// public List<FlowerInfo> queryColor(String color);
	
	public List<FlowerInfo> queryColor(Map<String, Object> map);
	
	public List<FlowerInfo> queryReport(Map<String, Object> map);
	
	public List<String> queryMycompanyCodeByCloth(Integer clothId);
	
}
