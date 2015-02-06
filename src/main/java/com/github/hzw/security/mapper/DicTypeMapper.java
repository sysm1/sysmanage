package com.github.hzw.security.mapper;


import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.DicType;

public interface DicTypeMapper extends BaseMapper<DicType>{
	public DicType isExist(DicType dicType);
	public DicType queryById(DicType dicType);
}
