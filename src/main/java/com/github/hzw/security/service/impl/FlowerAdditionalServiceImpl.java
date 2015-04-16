package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.FlowerAdditional;
import com.github.hzw.security.mapper.FlowerAdditionalMapper;
import com.github.hzw.security.service.FlowerAdditionalService;

@Transactional
@Service("flowerAdditionalService")
public class FlowerAdditionalServiceImpl implements FlowerAdditionalService {

	@Autowired
	private FlowerAdditionalMapper flowerAdditionalMapper;
	
	@Override
	public PageView query(PageView pageView, FlowerAdditional t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<FlowerAdditional> list = flowerAdditionalMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}
	
	public List<FlowerAdditional> queryAllColor(FlowerAdditional fa){
		return flowerAdditionalMapper.queryAllColor(fa);
	}

	
	@Override
	public List<FlowerAdditional> queryAll(FlowerAdditional t) {
		return flowerAdditionalMapper.queryAll(t);
	}
	
	@Override
	public List<FlowerAdditional> queryFind(FlowerAdditional flowerAdditional){
		return flowerAdditionalMapper.queryFind(flowerAdditional);
	}
	
	/**
	 * 根据我司编号 查询工厂编号
	 * @param myCompanyCode
	 * @return
	 */
	public List<String> queryFactoryCode(String  myCompanyCode){
		return flowerAdditionalMapper.queryFactoryCode(myCompanyCode);
	}
	
	/**
	 * 根据我司颜色 查询工厂颜色
	 * @param myCompanyColor
	 * @return
	 */
	public List<String> queryFactoryColor(String  myCompanyColor){
		return flowerAdditionalMapper.queryFactoryColor(myCompanyColor);
	}

	@Override
	public void delete(String id) throws Exception {
		flowerAdditionalMapper.delete(id);
		
	}

	@Override
	public void update(FlowerAdditional t) throws Exception {
		this.flowerAdditionalMapper.update(t);
		
	}

	@Override
	public FlowerAdditional getById(String id) {
		return this.flowerAdditionalMapper.getById(id);
	}

	@Override
	public void add(FlowerAdditional t) throws Exception {
		this.flowerAdditionalMapper.add(t);
	}

	@Override
	public void deleteByFlowerId(String flowerId){
		this.flowerAdditionalMapper.deleteByFlowerId(flowerId);
	}
	
	@Override
	public List<FlowerAdditional> findByFlowerId(Integer flowerId){
		FlowerAdditional flowerAdditional = new FlowerAdditional();
		flowerAdditional.setFlowerId(flowerId);
		return this.flowerAdditionalMapper.queryFind(flowerAdditional);
	}
	
}
