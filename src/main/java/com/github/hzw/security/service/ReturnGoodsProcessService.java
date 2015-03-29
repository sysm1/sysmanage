package com.github.hzw.security.service;

import java.util.Map;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ReturnGoodsProcess;

public interface ReturnGoodsProcessService extends
		BaseService<ReturnGoodsProcess> {
	
	/**
	 * 返回分页后的数据
	 * @param pageView
	 * @param t
	 * @return
	 */
	public PageView queryVO(PageView pageView,Map<String,String> map); 

}
