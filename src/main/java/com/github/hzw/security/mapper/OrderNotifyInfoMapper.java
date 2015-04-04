package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.OrderNotifyInfo;

public interface OrderNotifyInfoMapper extends BaseMapper<OrderNotifyInfo> {

	public List<OrderNotifyInfo> queryFind(Map<String, Object> map);
	
}
