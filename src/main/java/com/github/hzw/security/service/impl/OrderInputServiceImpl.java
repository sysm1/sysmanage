package com.github.hzw.security.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.OrderInputVO;
import com.github.hzw.security.entity.OrderInput;
import com.github.hzw.security.entity.OrderInputSummary;
import com.github.hzw.security.mapper.OrderInputMapper;
import com.github.hzw.security.mapper.OrderInputSummaryMapper;
import com.github.hzw.security.service.OrderInputService;

@Transactional
@Service("orderInputService")
public class OrderInputServiceImpl implements OrderInputService {

	@Autowired
	private OrderInputMapper orderInputMapper;
	
	@Autowired
	private OrderInputSummaryMapper orderInputSummaryMapper;
	
	@Override
	public PageView queryVO(PageView pageView, OrderInputVO t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<OrderInputVO> list = orderInputMapper.queryVO(map);
		pageView.setRecords(list);
		return pageView;
	}
	@Override
	public List<OrderInputVO> queryByIds(String[] ids){
		List<OrderInputVO> list = orderInputMapper.queryByIds(ids);
		return list;
	}
	
	@Override
	public void addOrderInput(HttpServletRequest request){
		String[] clothId=request.getParameterValues("clothId");
		String[] myCompanyCode=request.getParameterValues("myCompanyCode");
		String[] myCompanyColor=request.getParameterValues("myCompanyColor");
		String[] num=request.getParameterValues("num");
		String[] unit=request.getParameterValues("unit");
		String[] mark=request.getParameterValues("mark");
		String[] salesmanId=request.getParameterValues("salesmanId");
		OrderInputSummary inputSummary=new OrderInputSummary();
		List<OrderInputSummary> olist=null;
		OrderInput bean=new OrderInput();
		for(int i=0;i<clothId.length;i++){
			bean.setClothId(Integer.parseInt(clothId[i]));
			bean.setCreateTime(new Date());
			bean.setMark(mark[i]);
			bean.setMyCompanyCode(myCompanyCode[i]);
			bean.setMyCompanyColor(myCompanyColor[i]);
			bean.setNum(Integer.parseInt(num[i]));
			bean.setSalesmanId(Integer.parseInt(salesmanId[i]));
			bean.setStatus(0);
			bean.setUnit(Integer.parseInt(unit[i]));
			try {
				this.add(bean);
				
				//预录入汇总
				inputSummary.setMyCompanyCode(bean.getMyCompanyCode());
				inputSummary.setClothId(bean.getClothId());
				inputSummary.setMyCompanyColor(bean.getMyCompanyColor());
				olist=orderInputSummaryMapper.queryAll(inputSummary);
				if(olist.size()>0){
					inputSummary=olist.get(0);
					inputSummary.setOrderIds(inputSummary.getOrderIds()+","+bean.getId());
					orderInputSummaryMapper.update(inputSummary);
				}else{
					inputSummary.setOrderIds(bean.getId()+"");
					orderInputSummaryMapper.add(inputSummary);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	@Override
	public List<OrderInput> queryAll(OrderInput t) {
		return orderInputMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		orderInputMapper.delete(id);
		
	}

	@Override
	public void update(OrderInput t) throws Exception {
		this.orderInputMapper.update(t);
		
	}

	@Override
	public OrderInput getById(String id) {
		return this.orderInputMapper.getById(id);
	}

	@Override
	public void add(OrderInput t) throws Exception {
		this.orderInputMapper.add(t);
	}


	@Override
	public PageView query(PageView pageView, OrderInput t) {
		return null;
	}

}
