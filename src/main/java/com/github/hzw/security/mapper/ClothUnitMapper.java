package com.github.hzw.security.mapper;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.ClothUnit;

public interface ClothUnitMapper extends BaseMapper<ClothUnit> {
	
	public ClothUnit queryClothId(Integer clothId);
}
