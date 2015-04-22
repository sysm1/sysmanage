package com.github.hzw.security.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.SampleInputVO;
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
	 * 查询拖延单数
	 * @param dates
	 * @return
	 */
	public String queryDelayDates(String dates);
	
	public void updateStatus(String[] idsa);
	
	
	public List<SampleInputVO> queryReport(Map<String, Object> map);
	
	
}
