package com.github.hzw.security.service;

import java.util.List;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.ClothInfo;

public interface ClothInfoService extends BaseService<ClothInfo> {

	public List<ClothInfo> queryPinyin(String name);
}
