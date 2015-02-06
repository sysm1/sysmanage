package com.github.hzw.security.service;


import java.util.List;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.RoleAccount;
import com.github.hzw.security.entity.Roles;

public interface RolesService extends BaseService<Roles>{
	public Roles isExist(String name);
	public Roles findbyAccountRole(String accountId);
	public void addAccRole(RoleAccount roleAccount);

	public void addAccRole(String accountId, List<String> ids);
}
