package com.github.hzw.security.service;

import java.util.Map;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.RecordLog;

public interface RecordLogService extends BaseService<RecordLog>{

	public int sum(Map<String, Object> map);
	
	public int sum(String model, String opType);
	
}
