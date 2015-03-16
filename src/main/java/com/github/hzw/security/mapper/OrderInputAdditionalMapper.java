package com.github.hzw.security.mapper;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.OrderInputAdditional;

public interface OrderInputAdditionalMapper extends
		BaseMapper<OrderInputAdditional> {
	
	/**
	 * 删除预录入相关的附属信息
	 * @param inputId
	 */
	public void deleteByInputId(String inputId);

}
