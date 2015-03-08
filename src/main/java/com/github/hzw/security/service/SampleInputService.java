package com.github.hzw.security.service;

import javax.servlet.http.HttpServletRequest;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.SampleInput;

public interface SampleInputService extends BaseService<SampleInput> {

	/***
	 * 暂存数据
	 * @param request
	 */
	public void saveTemp(HttpServletRequest request,SampleInput sampleInput);
	
	/**
	 * 查询已回开版进度
	 * @param pageView
	 * @param t
	 * @return
	 */
	public PageView queryReplay(PageView pageView,SampleInput sampleInput);
	
	/**
	 * 查询新版数据  如果不存在相同的我司编号 为新版
	 * @param pageView
	 * @param t
	 * @return
	 */
	public PageView queryXinBan(PageView pageView,SampleInput sampleInput);
	
}
