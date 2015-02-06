package com.github.hzw.security.mapper;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.RoleAccount;
import com.github.hzw.security.entity.Roles;

public interface RolesMapper extends BaseMapper<Roles>{
	public Roles isExist(String name);
	
	public Roles findbyAccountRole(String accountId);
	
	public void addAccRole(RoleAccount roleAccount);
	
	public void deleteAccountRole(String accountId);
}
