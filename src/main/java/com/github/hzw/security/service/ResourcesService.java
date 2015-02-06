package com.github.hzw.security.service;


import java.util.List;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.Resources;

public interface ResourcesService extends BaseService<Resources>{
	//<!-- 根据账号Id获取该用户的权限-->
	public List<Resources> findAccountResourcess(String accountId);

	public List<Resources> findRoleRes(String roleId);
	
	public List<Resources> queryByParentId(Resources resources);
	/**
	 * 更新菜单排序号
	 */
	void updateSortOrder(List<Resources> menus);
	public void addRoleRes(String roleId,List<String> list);

	public Resources isExist(String menuName);
	public  int  getMaxLevel();
}
