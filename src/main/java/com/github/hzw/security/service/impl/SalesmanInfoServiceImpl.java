package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.SalesmanInfo;
import com.github.hzw.security.mapper.SalesmanInfoMapper;
import com.github.hzw.security.service.SalesmanInfoService;


@Transactional
@Service("salesmanInfoService")
public class SalesmanInfoServiceImpl implements SalesmanInfoService  {

	@Autowired
	private SalesmanInfoMapper salesmanInfoMapper;
	
	@Override
	public PageView query(PageView pageView, SalesmanInfo t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<SalesmanInfo> list = salesmanInfoMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}
	/**
	 * 获取业务员名称
	 * @param ids 业务员IDs
	 * @return
	 */
	@Override
	public String getSalmansName(String[] ids){
		return salesmanInfoMapper.getSalmansName(ids);
	}
	
	@Override
	public List<SalesmanInfo> queryAll(SalesmanInfo t) {
		return salesmanInfoMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		salesmanInfoMapper.delete(id);
		
	}

	@Override
	public void update(SalesmanInfo t) throws Exception {
		this.salesmanInfoMapper.update(t);
		
	}

	@Override
	public SalesmanInfo getById(String id) {
		return this.salesmanInfoMapper.getById(id);
	}

	@Override
	public void add(SalesmanInfo t) throws Exception {
		this.salesmanInfoMapper.add(t);
	}


	@Override
	public SalesmanInfo isExist(String name) {
		
		return this.salesmanInfoMapper.isExist(name);
	}

}
