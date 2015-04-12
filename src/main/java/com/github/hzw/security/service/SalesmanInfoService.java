package com.github.hzw.security.service;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.SalesmanInfo;

public interface SalesmanInfoService extends BaseService<SalesmanInfo>{

	SalesmanInfo isExist(String name);
	
	/**
	 * 获取业务员名称
	 * @param ids 业务员IDs
	 * @return
	 */
	public String getSalmansName(String[] ids);

}
