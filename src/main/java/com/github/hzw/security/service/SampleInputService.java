package com.github.hzw.security.service;

import javax.servlet.http.HttpServletRequest;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.SampleInput;

public interface SampleInputService extends BaseService<SampleInput> {

	/***
	 * 暂存数据
	 * @param request
	 */
	public void saveTemp(HttpServletRequest request,SampleInput sampleInput);
	
}
