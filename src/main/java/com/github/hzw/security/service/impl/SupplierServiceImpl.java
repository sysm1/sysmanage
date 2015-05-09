package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Supplier;
import com.github.hzw.security.mapper.SupplierMapper;
import com.github.hzw.security.service.SupplierService;
import com.github.hzw.util.PinyinUtil;

@Transactional
@Service("supplierService")
public class SupplierServiceImpl implements SupplierService {
	
	@Autowired
	private SupplierMapper supplierMapper;

	@Override
	public PageView query(PageView pageView, Supplier t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<Supplier> list = supplierMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	public List<Supplier> queryPinyin(String name){
		Map<String, Object> map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(name)){
			name = name.toUpperCase();
		}
		// System.out.println(cn);
		map.put("t", name);
		return supplierMapper.queryPinyin(map);
	}
	
	
	@Override
	public List<Supplier> queryAll(Supplier t) {
		return supplierMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		supplierMapper.delete(id);
		
	}

	@Override
	public void update(Supplier t) throws Exception {
		this.supplierMapper.update(t);
		
	}

	@Override
	public Supplier getById(String id) {
		return this.supplierMapper.getById(id);
	}

	@Override
	public void add(Supplier t) throws Exception {
		t.setPinyin(PinyinUtil.getPinYinHeadChar(t.getName()).toUpperCase());
		this.supplierMapper.add(t);
	}

	@Override
	public Supplier isExist(String name) {
		return this.supplierMapper.isExist(name);
	}

}
