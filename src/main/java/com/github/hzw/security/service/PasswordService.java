package com.github.hzw.security.service;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.Password;

public interface PasswordService extends BaseService<Password>{

	public int getNum();
	
	public String getPasswd();
}
