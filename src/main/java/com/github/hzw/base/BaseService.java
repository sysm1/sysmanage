package com.github.hzw.base;

import com.github.hzw.pulgin.mybatis.plugin.PageView;



/**
 * 所有服务接口都要继承这个
 */
public interface BaseService<T> extends Base<T> {
	/**
	 * 返回分页后的数据
	 * @param pageView
	 * @param t
	 * @return
	 */
	public PageView query(PageView pageView,T t);
}
