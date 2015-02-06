package com.github.hzw.security.service;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.DicType;



public interface DicTypeService extends BaseService<DicType>{
	public DicType isExist(DicType dicType);
	public DicType queryById(DicType dicType);
}
