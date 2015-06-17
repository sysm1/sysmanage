package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.VO.OrderInputSummaryVO;
import com.github.hzw.security.entity.OrderInputSummary;

public interface OrderInputSummaryMapper extends BaseMapper<OrderInputSummary> {
	
	/**
	 * 查询预录入汇总集合
	 * @param map
	 * @return
	 */
	public List<OrderInputSummaryVO> queryVO(Map<String, Object> map); 
	
	/**
	 * 查询下单预录入明细
	 * @param orderInputSummary
	 * @return
	 */
	public List<OrderInputSummaryVO> queryOrderInputBySummaryId(Map<String, Object> map);
	
	public OrderInputSummaryVO getVOById(String id);
	
	public List<String> queryMyCompanyCodeByClothId(String clothId);
	
	public List<String> queryMyCompanyColorByMyCompanyCode(String myCompanyCode);
	
	public OrderInputSummary getByOrderId(String inputId);

}
