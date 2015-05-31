package com.github.hzw.security.mapper;

import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.RecordLog;

public interface RecordLogMapper extends BaseMapper<RecordLog>{

	public Integer sum(Map<String, Object> map);
}
