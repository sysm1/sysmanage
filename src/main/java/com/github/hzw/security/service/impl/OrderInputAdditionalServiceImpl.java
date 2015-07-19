package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.OrderInput;
import com.github.hzw.security.entity.OrderInputAdditional;
import com.github.hzw.security.entity.OrderInputSummary;
import com.github.hzw.security.mapper.OrderInputAdditionalMapper;
import com.github.hzw.security.mapper.OrderInputSummaryMapper;
import com.github.hzw.security.service.OrderInputAdditionalService;
import com.github.hzw.security.service.OrderInputSummaryService;

@Transactional
@Service("orderInputAdditionalService")
public class OrderInputAdditionalServiceImpl implements
		OrderInputAdditionalService {

	@Autowired
	private OrderInputAdditionalMapper orderInputAdditionalMapper;
	
	@Autowired
	private OrderInputSummaryMapper orderInputSummaryMapper;
	
	@Override
	public PageView query(PageView pageView, OrderInputAdditional t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<OrderInputAdditional> list = orderInputAdditionalMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}
	
	/**
	 * 保存预录入下单附属
	 * @param request
	 */
	@Override
	public void saveAddition(HttpServletRequest request,OrderInput input){
		String[] myCompanyColors=request.getParameterValues("myCompanyColor");
		String[] nums=request.getParameterValues("num");
		String[] marks=request.getParameterValues("mark");
		String[] units=request.getParameterValues("unit");
		//删除预录入的相关附属信息
		orderInputAdditionalMapper.deleteByInputId(input.getId()+"");
		OrderInputAdditional bean=new OrderInputAdditional();
		OrderInputSummary orderInputSummary=new OrderInputSummary();
		List<OrderInputSummary> olist=null;
		for(int i=0;i<myCompanyColors.length;i++){
			bean=new OrderInputAdditional();
			bean.setMyCompanyColor(myCompanyColors[i]);
			bean.setNum(Integer.parseInt(nums[i].trim()));
			bean.setMark(marks[i]);
			bean.setInputId(input.getId());
			try {
				this.add(bean);
				
				/*预录入汇总
				orderInputSummary.setMyCompanyCode(input.getMyCompanyCode());
				orderInputSummary.setClothId(input.getClothId());
				orderInputSummary.setMyCompanyColor(myCompanyColors[i]);
				olist=orderInputSummaryMapper.queryAll(orderInputSummary);
				if(olist.size()>0){
					orderInputSummary.setId(orderInputSummary.getId());
					orderInputSummary.setOrderIds(orderInputSummary.getOrderIds()+","+bean.getId());
					orderInputSummaryMapper.update(orderInputSummary);
				}else{
					orderInputSummary.setOrderIds(bean.getId()+"");
					orderInputSummaryMapper.add(orderInputSummary);
				}*/
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}

	
	@Override
	public List<OrderInputAdditional> queryAll(OrderInputAdditional t) {
		return orderInputAdditionalMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		orderInputAdditionalMapper.delete(id);
		
	}

	@Override
	public void update(OrderInputAdditional t) throws Exception {
		this.orderInputAdditionalMapper.update(t);
		
	}

	@Override
	public OrderInputAdditional getById(String id) {
		return this.orderInputAdditionalMapper.getById(id);
	}

	@Override
	public void add(OrderInputAdditional t) throws Exception {
		this.orderInputAdditionalMapper.add(t);
	}

}
