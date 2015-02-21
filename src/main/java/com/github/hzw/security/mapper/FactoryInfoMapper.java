package com.github.hzw.security.mapper;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.FactoryInfo;

public interface FactoryInfoMapper extends BaseMapper<FactoryInfo> {

	FactoryInfo isExist(String name);

}
