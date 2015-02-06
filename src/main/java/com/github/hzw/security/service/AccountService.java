package com.github.hzw.security.service;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Account;



public interface AccountService extends BaseService<Account>{
	public Account querySingleAccount(String accountName);
	public Account isExist(String accountName);
	/**
	 * 验证用户登陆
	 * @author lanyuan
	 * Email：mmm333zzz520@163.com
	 * date：2014-2-25
	 * @param Account account
	 * @return
	 */
	public Account countAccount(Account account);
	
	/**
	 * @param account
	 * @param pageView
	 * @return
	 */
	public PageView queryNoMatch(Account account,PageView pageView);
}
