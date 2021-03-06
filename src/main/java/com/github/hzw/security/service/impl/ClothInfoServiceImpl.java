package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ClothColor;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.mapper.ClothInfoMapper;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.util.PinyinUtil;

@Transactional
@Service("clothInfoService")
public class ClothInfoServiceImpl implements ClothInfoService {

	@Autowired
	private ClothInfoMapper clothInfoMapper;
	
	@Override
	public PageView query(PageView pageView, ClothInfo t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<ClothInfo> list = clothInfoMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<ClothInfo> queryAll(ClothInfo t) {
		return clothInfoMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		clothInfoMapper.delete(id);
		
	}

	@Override
	public void update(ClothInfo t) throws Exception {
		t.setPinyin(PinyinUtil.getPinYinHeadChar(t.getClothName()).toUpperCase());
		this.clothInfoMapper.update(t);
		
	}

	@Override
	public ClothInfo getById(String id) {
		return this.clothInfoMapper.getById(id);
	}

	@Override
	public void add(ClothInfo t) throws Exception {
		t.setPinyin(PinyinUtil.getPinYinHeadChar(t.getClothName()).toUpperCase());
		this.clothInfoMapper.add(t);
	}
	
	@Override
	public void addClothInfo(ClothInfo t,List<ClothColor> list) throws Exception {
		t.setPinyin(PinyinUtil.getPinYinHeadChar(t.getClothName()).toUpperCase());
		if(null==t.getId()){
			this.clothInfoMapper.add(t);
		}else{
			if(t.getUnit()!=0){
				t.setTiaoKg(null);
			}
			this.clothInfoMapper.update(t);
			clothInfoMapper.deleteColorsByClothId(t.getId()+"");
		}
		for(ClothColor clothColor:list){
			clothColor.setClothId(t.getId());
			clothInfoMapper.addColor(clothColor);
		}
	}
	
	@Override
	public List<ClothColor> queryColorsById(String id){
		return clothInfoMapper.queryColorsById(id);
	}

	public List<ClothInfo> queryPinyin(String name){
		Map<String, Object> map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(name)){
			name = name.toUpperCase();
		}
		map.put("t", name);
		return clothInfoMapper.queryPinyin(map);
	}
	
	
	public ClothInfo isExist(String clothName){
		return clothInfoMapper.isExist(clothName);
	}
	
	/**
	 * 删除布种颜色
	 * @param clothId
	 */
	public void deleteColorsByClothId(String clothId){
		clothInfoMapper.deleteColorsByClothId(clothId);
	}
	
}
