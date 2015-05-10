package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ClothAllowance;
import com.github.hzw.security.entity.ClothManage;
import com.github.hzw.security.mapper.ClothAllowanceMapper;
import com.github.hzw.security.mapper.ClothManageMapper;
import com.github.hzw.security.service.ClothManageService;

@Transactional
@Service("clothManageService")
public class ClothManageServiceImpl implements ClothManageService {
	
	@Autowired
	private ClothManageMapper clothManageMapper;
	@Autowired
	private ClothAllowanceMapper clothAllowanceMapper;

	@Override
	public PageView query(PageView pageView, ClothManage t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<ClothManage> list = clothManageMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	@Override
	public List<ClothManage> queryAll(ClothManage t) {
		return clothManageMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		clothManageMapper.delete(id);
	}

	@Override
	public void update(ClothManage t) throws Exception {
		ClothAllowance clothAllowance =new ClothAllowance();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("clothId", t.getClothId());
		map.put("factoryId", t.getFactoryId());
		map.put("color", t.getColor());
		List<ClothAllowance> list=clothAllowanceMapper.queryByFind(map);
		if(null!=list&&list.size()>0){
			clothAllowance=list.get(0);
			clothAllowance.setAllowance(t.getFactNum());
			clothAllowance.setAllowancekg(t.getFactNumKg());
		}
		clothAllowanceMapper.update(clothAllowance);
		clothManageMapper.update(t);
	}

	@Override
	public ClothManage getById(String id) {
		return clothManageMapper.getById(id);
	}

	/**
	 * 添加坯布管理 同时修改胚布余量
	 */
	@Override
	public void add(ClothManage t) throws Exception {
		ClothAllowance clothAllowance =new ClothAllowance();
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("clothId", t.getClothId());
		map.put("factoryId", t.getFactoryId());
		map.put("color", t.getColor());
		List<ClothAllowance> list=clothAllowanceMapper.queryByFind(map);
		if(null!=list&&list.size()>0){
			clothAllowance=list.get(0);
			clothAllowance.setAllowance(t.getFactNum());
			clothAllowance.setAllowancekg(t.getFactNumKg());
		}
		clothAllowanceMapper.update(clothAllowance);
		ClothManage cm=new ClothManage();
		cm.setFactoryId(t.getFactoryId());
		cm.setColor(t.getColor());
		cm.setClothId(t.getClothId());
		map.put("t",cm);
		List<ClothManage> cms=clothManageMapper.query(map);
		if(null!=cms&&cms.size()>0){
			cm=cms.get(0);
			cm.setFactNum(t.getFactNum());
			cm.setFactNumKg(t.getFactNumKg());
			clothManageMapper.update(cm);
		}else{
			clothManageMapper.add(t);
		}
	}

}
