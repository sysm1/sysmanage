package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.Supplier;

public interface SupplierMapper extends BaseMapper<Supplier>{
	public Supplier isExist(String name);
	// public List<FactoryInfo> queryPinyin(String name);
	public List<Supplier> queryPinyin(Map<String, Object> map);
}
