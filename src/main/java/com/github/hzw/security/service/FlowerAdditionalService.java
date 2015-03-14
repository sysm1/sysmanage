package com.github.hzw.security.service;

import java.util.List;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.FlowerAdditional;

public interface FlowerAdditionalService extends BaseService<FlowerAdditional> {

	public void deleteByFlowerId(String flowerId);
	
	public List<FlowerAdditional> findByFlowerId(Integer flowerId);
	
}
