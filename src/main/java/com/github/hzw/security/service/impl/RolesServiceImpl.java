package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.RoleAccount;
import com.github.hzw.security.entity.Roles;
import com.github.hzw.security.mapper.RolesMapper;
import com.github.hzw.security.service.RolesService;
import com.github.hzw.util.Common;

@Transactional
@Service("RolesService")
public class RolesServiceImpl implements RolesService {
	@Autowired
	private RolesMapper roleMapper;

	
	public PageView query(PageView pageView, Roles roles) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", roles);
		List<Roles> list = roleMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	public List<Roles> queryAll(Roles t) {
		return roleMapper.queryAll(t);
	}

	
	public void delete(String id) throws Exception {
		roleMapper.delete(id);
		
	}

	
	public void update(Roles t) throws Exception {
		roleMapper.update(t);
		
	}

	
	public Roles getById(String id) {
		return roleMapper.getById(id);
	}

	
	public void add(Roles t) throws Exception {
		roleMapper.add(t);
	}

	
	public Roles isExist(String name) {
		return roleMapper.isExist(name);
	}


	public Roles findbyAccountRole(String accountId) {
		return roleMapper.findbyAccountRole(accountId);
	}


	public void addAccRole(RoleAccount roleAccount) {
		roleMapper.deleteAccountRole(roleAccount.getAccountId().toString());
		roleMapper.addAccRole(roleAccount);
	}


	public void addAccRole(String accountId, List<String> ids) {
		roleMapper.deleteAccountRole(accountId);
		for (String roleId : ids) {
			if(!Common.isEmpty(roleId)){
				RoleAccount roleAccount = new RoleAccount();
				roleAccount.setAccountId(Integer.parseInt(accountId) );
				roleAccount.setRoleId(Integer.parseInt(roleId) );
				roleMapper.addAccRole(roleAccount);
			}
			
		}
	}

}
