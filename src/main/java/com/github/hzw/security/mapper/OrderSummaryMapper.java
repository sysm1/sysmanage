package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.OrderSummary;

public interface OrderSummaryMapper extends BaseMapper<OrderSummary> {

	 public List<OrderSummary> queryPrint(Map<String, Object> map);
}
