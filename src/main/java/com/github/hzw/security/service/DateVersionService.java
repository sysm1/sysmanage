package com.github.hzw.security.service;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.DateVersion;

public interface DateVersionService extends BaseService<DateVersion> {
	public int getValue(String category, String strDate) throws Exception;
}
