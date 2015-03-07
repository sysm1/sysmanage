package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.SampleAdditional;
import com.github.hzw.security.mapper.SampleAdditionalMapper;
import com.github.hzw.security.service.SampleAdditionalService;

@Transactional
@Service("sampleAdditionalService")
public class SampleAdditionalServiceImpl implements SampleAdditionalService {

	@Autowired
	private SampleAdditionalMapper sampleAdditionalMapper;
	
	@Override
	public PageView query(PageView pageView, SampleAdditional t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<SampleAdditional> list = sampleAdditionalMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}
	/**
	 * 删除开版进度的编号和颜色
	 * @param sampleId
	 */
	@Override
	public void deleteBySampleId(String sampleId){
		sampleAdditionalMapper.deleteBySampleId(sampleId);
	}
	
	@Override
	public List<SampleAdditional> queryAll(SampleAdditional t) {
		return sampleAdditionalMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		sampleAdditionalMapper.delete(id);
		
	}

	@Override
	public void update(SampleAdditional t) throws Exception {
		this.sampleAdditionalMapper.update(t);
		
	}

	@Override
	public SampleAdditional getById(String id) {
		return this.sampleAdditionalMapper.getById(id);
	}

	@Override
	public void add(SampleAdditional t) throws Exception {
		this.sampleAdditionalMapper.add(t);
	}

}
