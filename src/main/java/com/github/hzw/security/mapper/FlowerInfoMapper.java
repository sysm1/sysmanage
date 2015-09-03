package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.VO.GlVo;
import com.github.hzw.security.entity.FlowerInfo;

public interface FlowerInfoMapper extends BaseMapper<FlowerInfo> {

	public List<FlowerInfo> queryFind(FlowerInfo flowerInfo);
	
	public List<FlowerInfo> queryFindLike(FlowerInfo flowerInfo);
	
	public List<FlowerInfo> queryMyCode(FlowerInfo flowerInfo);
	
	// public List<FlowerInfo> queryColor(String color);
	
	public List<FlowerInfo> queryColor(Map<String, Object> map);
	
	public List<FlowerInfo> queryReport(Map<String, Object> map);
	
	public List<String> queryMycompanyCodeByCloth(FlowerInfo flowerInfo);
	
	public List<String> queryMycompanyColor(FlowerInfo info);
	
	public void updateByStatus(Map<String, Object> map);
	
	public List<FlowerInfo> queryByClothIdAndMyCompanyCode(Map<String, Object> map);
	
	/**
	 * 关联查询
	 * @param map
	 * @return
	 */
	public List<GlVo> queryGl(Map<String, Object> map);
	
	public List<GlVo> queryGlFactory(Map<String, Object> map); 
	
	public List<GlVo> queryGlFactoryCode(Map<String, Object> map);
	
}
