package com.github.hzw.security.service;

import java.util.List;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.ClothColor;
import com.github.hzw.security.entity.ClothInfo;

public interface ClothInfoService extends BaseService<ClothInfo> {

	public List<ClothInfo> queryPinyin(String name);
	
	public ClothInfo isExist(String clothName);
	
	public void addClothInfo(ClothInfo t,List<ClothColor> list) throws Exception;
	
	public List<ClothColor> queryColorsById(String id);
	
	/**
	 * 删除布种颜色
	 * @param clothId
	 */
	public void deleteColorsByClothId(String clothId);
}
