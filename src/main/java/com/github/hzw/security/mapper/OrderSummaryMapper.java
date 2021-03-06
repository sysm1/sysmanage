package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.VO.OrderReportClothVO;
import com.github.hzw.security.VO.OrderReportFactoryVO;
import com.github.hzw.security.VO.OrderSummaryVO;
import com.github.hzw.security.entity.OrderSummary;

public interface OrderSummaryMapper extends BaseMapper<OrderSummary> {

	 public List<OrderSummary> queryPrint(Map<String, Object> map);

	 public List<OrderSummary> queryNotify(Map<String, Object> map);
	 public void updateCancel(String notifyId);
	 
	 /**
	  * 查询指定ID的OrderSummary
	  * @param ids OrderSummary id
	  * @return
	  */
	 public List<OrderSummary> queryByIds(String[] ids);
	 
	 public List<OrderSummary> queryByNotifyId(String notifyId);

	 public String queryNoReturnNum(OrderSummary orderSummary);
	 
	 public List<OrderSummaryVO> queryVO(Map<String, Object> map);

	 public List<OrderReportFactoryVO> queryReportByFactory(Map<String, Object> map);
	 
	 public List<OrderReportClothVO> queryReportByCloth(Map<String, Object> map);
	 
	 public List<OrderSummary> queryReportBySummary(Map<String, Object> map);
	 
	 public List<String> queryFactoryCodeByFactoryId(String factoryId);
	 
	 public List<String> queryFactoryColor(OrderSummary orderSummary);
	 
}
