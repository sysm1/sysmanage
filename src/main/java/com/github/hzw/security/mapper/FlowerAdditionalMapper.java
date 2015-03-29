package com.github.hzw.security.mapper;

import java.util.List;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.FlowerAdditional;

public interface FlowerAdditionalMapper extends BaseMapper<FlowerAdditional>{

	public void deleteByFlowerId(String flowerId);
	
	public List<FlowerAdditional> queryFind(FlowerAdditional fa);
	
	/**
	 * 根据我司编号 查询工厂编号
	 * @param myCompanyCode
	 * @return
	 */
	public List<String> queryFactoryCode(String  myCompanyCode);
	
	/**
	 * 根据我司颜色 查询工厂颜色
	 * @param myCompanyColor
	 * @return
	 */
	public List<String> queryFactoryColor(String  myCompanyColor);
}
