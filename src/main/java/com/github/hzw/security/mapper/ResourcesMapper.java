package com.github.hzw.security.mapper;

import java.util.List;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.entity.ResourcesRole;

public interface ResourcesMapper extends BaseMapper<Resources> {

	void updateSortOrder(Resources resources);

	public Resources isExist(String name);

	public int getMaxLevel();

	// <!-- 根据账号Id获取该用户的权限-->
	public List<Resources> findAccountResourcess(String accountId);

	public List<Resources> findRoleRes(String roleId);
	
	public List<Resources> queryByParentId(Resources resources);
	/**
	 * 更新菜单排序号
	 * 
	 */
	public void addRoleRes(ResourcesRole rr);

	public void deleteResourcesRole(String roleId);
}
