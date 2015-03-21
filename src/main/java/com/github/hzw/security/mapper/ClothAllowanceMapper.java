package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.ClothAllowance;

public interface ClothAllowanceMapper extends BaseMapper<ClothAllowance>{
	
    public ClothAllowance queryByClothAndFactory(Map<String, Integer> map);
    
    public ClothAllowance queryByCloth(String clothId);
    
    public List<ClothAllowance> queryByFind(Map<String, Object> map);
    
}
