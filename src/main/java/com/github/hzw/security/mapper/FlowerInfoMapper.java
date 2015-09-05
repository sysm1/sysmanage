package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.VO.GlVo;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.TechnologyInfo;

public interface FlowerInfoMapper extends BaseMapper<FlowerInfo> {

	public List<FlowerInfo> queryFind(FlowerInfo flowerInfo);
	
	public List<FlowerInfo> queryFindLike(FlowerInfo flowerInfo);
	
	public List<FlowerInfo> queryMyCode(FlowerInfo flowerInfo);
	
	// public List<FlowerInfo> queryColor(String color);
	
	public List<FlowerInfo> queryColor(Map<String, Object> map);
	
	public List<FlowerInfo> queryReport(Map<String, Object> map);
	
	public List<String> queryMycompanyCodeByCloth(Map<String, Object> map);
	
	public List<String> queryMycompanyColor(Map<String, Object> map);
	
	public List<String> queryMycompanyCodeByCloth1(FlowerInfo t);
	
	public List<String> queryMycompanyColor1(FlowerInfo t);
	
	public void updateByStatus(Map<String, Object> map);
	
	public List<FlowerInfo> queryByClothIdAndMyCompanyCode(Map<String, Object> map);
	
	public List<TechnologyInfo> queryTechnology(FlowerInfo t);
	
	/**
	 * 关联查询
	 * @param map
	 * @return
	 */
	public List<GlVo> queryGl(Map<String, Object> map);
	
	public List<GlVo> queryGlFactory(Map<String, Object> map); 
	
	public List<GlVo> queryGlFactoryCode(Map<String, Object> map);
	
}
