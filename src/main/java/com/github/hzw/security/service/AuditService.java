package com.github.hzw.security.service;

import javax.servlet.http.HttpServletRequest;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.AuditBean;

public interface AuditService  extends BaseService<AuditBean>{
	
	public void toAudit(String ids,String type,HttpServletRequest request);

}
