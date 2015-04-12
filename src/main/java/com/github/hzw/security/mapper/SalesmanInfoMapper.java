package com.github.hzw.security.mapper;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.SalesmanInfo;


public interface SalesmanInfoMapper extends BaseMapper<SalesmanInfo>{

	public SalesmanInfo isExist(String name);
	
	public String getSalmansName(String[] ids);
	
}
