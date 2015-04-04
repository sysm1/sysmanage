package com.github.hzw.security.mapper;

import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.DateVersion;

public interface DateVersionMapper extends BaseMapper<DateVersion> {

	public DateVersion getByCategoryAndDate(Map<String, Object> map);
	
}
