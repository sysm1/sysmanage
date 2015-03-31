package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.VO.OrderSummaryVO;
import com.github.hzw.security.entity.ReturnGoodsProcess;

public interface ReturnGoodsProcessMapper extends
		BaseMapper<ReturnGoodsProcess> {
	
	/**
	 * 返回分页后的数据
	 * @param List
	 * @param t
	 * @return
	 */
	public List<OrderSummaryVO> queryVO(Map<String, Object> map);
	
	/**
	 * 删除下单相关的附属
	 * @param summaryId
	 */
	public void deleteBySummaryId(String summaryId);
	
	public List<ReturnGoodsProcess> queryBySummaryId(String summaryId);

	
}
