package com.github.hzw.security.service;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.TechnologyInfo;

public interface TechnologyInfoService extends BaseService<TechnologyInfo> {

	TechnologyInfo isExist(String name);

}
