package com.github.hzw.security.mapper;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.TechnologyInfo;

public interface TechnologyInfoMapper extends BaseMapper<TechnologyInfo> {

	TechnologyInfo isExist(String name);

}
