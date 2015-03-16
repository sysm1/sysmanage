package com.github.hzw.security.service;

import javax.servlet.http.HttpServletRequest;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.OrderInputAdditional;

public interface OrderInputAdditionalService extends
		BaseService<OrderInputAdditional> {
	
	/**
	 * 保存预录入下单附属
	 * @param request
	 * @inputId 预录入ID
	 */
	public void saveAddition(HttpServletRequest request,Integer inputId);

}
