package com.github.hzw.security.service;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Account;



public interface AccountService extends BaseService<Account>{
	public Account querySingleAccount(String accountName);
	public Account isExist(String accountName);

	public Account countAccount(Account account);
	
	/**
	 * @param account
	 * @param pageView
	 * @return
	 */
	public PageView queryNoMatch(Account account,PageView pageView);
	
	public Account queryByAccountName(String name);
	
}
