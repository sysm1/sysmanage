package com.github.hzw.security.mapper;

import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.ClothAllowance;

public interface ClothAllowanceMapper extends BaseMapper<ClothAllowance>{
	
    public ClothAllowance queryByClothAndFactory(Map<String, Integer> map);
    
}
