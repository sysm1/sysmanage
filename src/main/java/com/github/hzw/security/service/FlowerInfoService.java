package com.github.hzw.security.service;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.FlowerInfo;

public interface FlowerInfoService extends BaseService<FlowerInfo> {

	public List<FlowerInfo> queryFind(FlowerInfo info );
	
	public PageView queryCode(PageView pageView, String code);
	
	public List<FlowerInfo> queryReport(Map<String, Object> map);
}
