package com.github.hzw.security.service;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.GlVo;
import com.github.hzw.security.entity.FlowerInfo;

public interface FlowerInfoService extends BaseService<FlowerInfo> {

	public List<FlowerInfo> queryFind(FlowerInfo info ); 
	
	public List<FlowerInfo> queryMyCode(FlowerInfo info );
	
	public PageView queryCode(PageView pageView, String code);
	
	public List<FlowerInfo> queryReport(Map<String, Object> map);
	
	/**
	 * 以布种获取我司编号
	 * @param clothId
	 * @return
	 */
	public List<String> queryMycompanyCodeByCloth(FlowerInfo info);
	
	public List<String> queryMycompanyColor(FlowerInfo info);
	
	public void updateByStatus(Integer id, int status);
	
	public List<FlowerInfo> queryByClothIdAndMyCompanyCode(Integer clothId, String myCompanyCode);
	
	/**
	 * 关联查询
	 * @param map
	 * @return
	 */
	public List<GlVo> queryGl(Map<String, Object> map);
	
	public List<GlVo> queryGlFactory(Map<String, Object> map);
	
	public List<GlVo> queryGlFactoryCode(Map<String, Object> map);
	
}
