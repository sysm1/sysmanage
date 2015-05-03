package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.ClothInfo;

public interface ClothInfoMapper extends BaseMapper<ClothInfo> {

	public List<ClothInfo> queryPinyin(Map<String, Object> map);
	
	public ClothInfo isExist(String clothName);
	
}
