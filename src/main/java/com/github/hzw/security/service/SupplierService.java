package com.github.hzw.security.service;

import java.util.List;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.Supplier;

public interface SupplierService extends BaseService<Supplier>{
	
	public Supplier isExist(String name);
	public List<Supplier> queryPinyin(String name);

}
