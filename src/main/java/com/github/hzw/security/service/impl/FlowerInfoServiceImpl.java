package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.GlVo;
import com.github.hzw.security.entity.FlowerAdditional;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.mapper.FlowerInfoMapper;
import com.github.hzw.security.service.FlowerAdditionalService;
import com.github.hzw.security.service.FlowerInfoService;

@Transactional
@Service("flowerInfoService")
public class FlowerInfoServiceImpl implements FlowerInfoService {

	@Autowired
	private FlowerInfoMapper flowerInfoMapper;
	
	@Autowired
	private FlowerAdditionalService flowerAdditionalService;
	
	@Override
	public PageView query(PageView pageView, FlowerInfo t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<FlowerInfo> list = flowerInfoMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	public PageView queryCode(PageView pageView, String code){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		map.put("paging", pageView);
		List<FlowerInfo> list = flowerInfoMapper.queryColor(map);
		pageView.setRecords(list);
		return pageView;
	}
	
	/**
	 * 关联查询
	 * @param map
	 * @return
	 */
	public List<GlVo> queryGl(Map<String, Object> map){
		return flowerInfoMapper.queryGl(map);
	}
	
	/**
	 * 关联查询
	 * @param map
	 * @return
	 */
	public List<GlVo> queryGlFactory(Map<String, Object> map){
		return flowerInfoMapper.queryGlFactory(map);
	}
	
	public List<GlVo> queryGlFactoryCode(Map<String, Object> map){
		return flowerInfoMapper.queryGlFactoryCode(map);
	}
	
	@Override
	public List<FlowerInfo> queryAll(FlowerInfo t) {
		return flowerInfoMapper.queryAll(t);
	}
	
	/**
	 * 以布种获取我司编号
	 * @param clothId
	 * @return
	 */
	public PageView queryMycompanyCodeByCloth(PageView pageView, FlowerInfo t){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<String> list = flowerInfoMapper.queryMycompanyCodeByCloth(map);
		pageView.setRecords(list);
		return pageView;
	}

	public PageView queryMycompanyColor(PageView pageView, FlowerInfo t){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<String> list = flowerInfoMapper.queryMycompanyColor(map);
		pageView.setRecords(list);
		return pageView;
	}
	
	public List<String> queryMycompanyCodeByCloth1(FlowerInfo t){
		return flowerInfoMapper.queryMycompanyCodeByCloth1(t);
	}
	
	public List<String> queryMycompanyColor1(FlowerInfo t){
		return flowerInfoMapper.queryMycompanyColor1(t);
	}
	
	@Override
	public void delete(String id) throws Exception {
		flowerAdditionalService.deleteByFlowerId(id);
		flowerInfoMapper.delete(id);
	}

	@Override
	public void update(FlowerInfo t) throws Exception {
		// this.flowerInfoMapper.update(t);
		Integer flowerId = t.getId();
		Set<String> list = new HashSet<String>();
		flowerAdditionalService.deleteByFlowerId(flowerId+""); // 删除附加表
		if(t.getList() != null && t.getList().size() > 0){
			for(FlowerAdditional fadd : t.getList()) {
				fadd.setFlowerId(flowerId);
				fadd.setMyCompanyCode(t.getMyCompanyCode());
				flowerAdditionalService.add(fadd);
				list.add(fadd.getFactoryCode());
			}
			t.setFactoryCode(org.apache.commons.lang.StringUtils.join(list.toArray(),","));
			this.flowerInfoMapper.update(t);
		}
		
	}

	@Override
	public FlowerInfo getById(String id) {
		FlowerInfo info = this.flowerInfoMapper.getById(id);
		info.setList(flowerAdditionalService.findByFlowerId(new Integer(id)));
		return info;
	}

	
	@Override
	public void add(FlowerInfo t) throws Exception {
		// 保存主表
		this.flowerInfoMapper.add(t);
		Set<String> list = new HashSet<String>();
		Integer flowerId = t.getId();
		if(t.getList() != null && t.getList().size() > 0){
			for(FlowerAdditional fadd : t.getList()) {
				fadd.setFlowerId(flowerId);
				fadd.setMyCompanyCode(t.getMyCompanyCode());
				flowerAdditionalService.add(fadd);
				list.add(fadd.getFactoryCode());
			}
			t.setFactoryCode(org.apache.commons.lang.StringUtils.join(list.toArray(),","));
			this.flowerInfoMapper.update(t);
		}
	}
	
	@Override
	public List<FlowerInfo> queryFind(FlowerInfo info ){
		return flowerInfoMapper.queryFind(info);
	}
	
	public List<FlowerInfo> queryFindLike(FlowerInfo info ){
		return flowerInfoMapper.queryFindLike(info);
	}
	
	public List<FlowerInfo> queryMyCode(FlowerInfo info ){
		return flowerInfoMapper.queryMyCode(info);
	}
	
	public List<FlowerInfo> queryReport(Map<String, Object> map) {
		return flowerInfoMapper.queryReport(map);
	}
	
	
	public void updateByStatus(Integer id, int status){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("status", status);
		flowerInfoMapper.updateByStatus(map);
	}
	
	public List<FlowerInfo> queryByClothIdAndMyCompanyCode(Integer clothId, String myCompanyCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clothId", clothId);
		map.put("myCompanyCode", myCompanyCode);
		return flowerInfoMapper.queryByClothIdAndMyCompanyCode(map);
	}
	
	public List<TechnologyInfo> queryTechnology(FlowerInfo t){
		return flowerInfoMapper.queryTechnology(t);
	}
}
