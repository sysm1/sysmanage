package com.github.hzw.security.mapper;

import java.util.List;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.FlowerAdditional;

public interface FlowerAdditionalMapper extends BaseMapper<FlowerAdditional>{

	public void deleteByFlowerId(String flowerId);
	
	public List<FlowerAdditional> queryFind(FlowerAdditional fa);
}
