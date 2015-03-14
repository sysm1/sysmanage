package com.github.hzw.security.service;

import java.util.Map;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.FlowerInfo;

public interface FlowerInfoService extends BaseService<FlowerInfo> {

	public PageView queryFind(PageView pageView, Map<String, Object> map );
}
