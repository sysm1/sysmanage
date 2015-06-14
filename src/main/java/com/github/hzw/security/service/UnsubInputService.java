/**
 * 
 */
package com.github.hzw.security.service;

import javax.servlet.http.HttpServletRequest;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.Unsub;

/**
 * @author wuyb
 *
 */
public interface UnsubInputService extends BaseService<Unsub>{
	
	public void addUnsub(HttpServletRequest request);

}
