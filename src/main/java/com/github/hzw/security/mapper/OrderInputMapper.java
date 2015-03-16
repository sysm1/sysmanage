package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.VO.OrderInputVO;
import com.github.hzw.security.entity.OrderInput;

public interface OrderInputMapper extends BaseMapper<OrderInput> {
	
	/**
	 * 返回分页后的数据
	 * @param List
	 * @param t
	 * @return
	 */
	public List<OrderInputVO> queryVO(Map<String, Object> map);

}
