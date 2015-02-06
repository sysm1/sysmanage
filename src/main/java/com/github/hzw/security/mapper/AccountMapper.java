package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.Account;

public interface AccountMapper extends BaseMapper<Account>{
	public Account querySingleAccount(String accountName);
	public Account isExist(String accountName);

	public Account countAccount(Account account);
	
	public List<Account> queryNoMatch(Map<String, Object> map);
}
