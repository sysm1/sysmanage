package com.github.hzw.security.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.github.hzw.base.BaseService;
import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.OrderInputVO;
import com.github.hzw.security.entity.OrderInput;

public interface OrderInputService extends BaseService<OrderInput> {
	
	public PageView queryVO(PageView pageView, OrderInputVO t);
	
	public List<OrderInputVO> queryByIds(String[] ids);
	
	public void addOrderInput(HttpServletRequest request);
	
	public void updateOrderInput(HttpServletRequest request);

}
