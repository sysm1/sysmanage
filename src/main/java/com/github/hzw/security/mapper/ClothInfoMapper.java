package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;
import com.github.hzw.security.entity.ClothColor;
import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.ClothInfo;

public interface ClothInfoMapper extends BaseMapper<ClothInfo> {

	public List<ClothInfo> queryPinyin(Map<String, Object> map);
	
	public ClothInfo isExist(String clothName);
	
	public void addColor(ClothColor clothColor);
	
	public List<ClothColor> queryColorsById(String id);
	
	/**
	 * 删除布种颜色
	 * @param clothId
	 */
	public void deleteColorsByClothId(String clothId);
	
}
