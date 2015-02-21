package com.github.hzw.security.service;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.FactoryInfo;

public interface FactoryInfoService extends BaseService<FactoryInfo> {

	FactoryInfo isExist(String name);

}
