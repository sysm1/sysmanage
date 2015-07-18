package com.github.hzw.security.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.OrderInputVO;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.OrderInput;
import com.github.hzw.security.entity.OrderInputSummary;
import com.github.hzw.security.entity.RecordLog;
import com.github.hzw.security.mapper.OrderInputMapper;
import com.github.hzw.security.mapper.OrderInputSummaryMapper;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.OrderInputAdditionalService;
import com.github.hzw.security.service.OrderInputService;
import com.github.hzw.security.service.RecordLogService;
import com.github.hzw.util.Common;
import com.github.hzw.util.DateUtil;

@Transactional
@Service("orderInputService")
public class OrderInputServiceImpl implements OrderInputService {

	private static Logger logger = LoggerFactory.getLogger(OrderInputServiceImpl.class);
	
	
	@Autowired
	private OrderInputMapper orderInputMapper;
	
	@Autowired
	private OrderInputSummaryMapper orderInputSummaryMapper;
	
	@Inject
	private ClothInfoService clothInfoService;
	
	@Inject 
	private OrderInputAdditionalService orderInputAdditionalService;
	
	@Inject
	private RecordLogService recordLogService;
	
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
		//String[] unit=request.getParameterValues("unit");
		String[] mark=request.getParameterValues("mark");
		String[] technologyIds=request.getParameterValues("technologyId");
		String[] salesmanId=request.getParameterValues("salesmanId");
		
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
			bean.setTechnologyId(Integer.parseInt(technologyIds[i]));
			bean.setStatus(0);
			ClothInfo clothInfo=new ClothInfo();
			clothInfo=clothInfoService.getById(bean.getClothId()+"");
			bean.setUnit(clothInfo.getUnit());
			try {
				this.add(bean);
				olist=huizong(bean);
				orderInputAdditionalService.saveAddition(request,bean);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 预录入汇总
	 * @param bean
	 * @return
	 */
	public List<OrderInputSummary> huizong(OrderInput bean){
		OrderInputSummary inputSummary=new OrderInputSummary();
		//预录入汇总
		inputSummary.setMyCompanyCode(bean.getMyCompanyCode());
		inputSummary.setClothId(bean.getClothId());
		inputSummary.setMyCompanyColor(bean.getMyCompanyColor());
		inputSummary.setTechnologyId(bean.getTechnologyId());
		List<OrderInputSummary> olist=orderInputSummaryMapper.queryAll(inputSummary);
		if(olist.size()>0){
			inputSummary=olist.get(0);
			inputSummary.setNum(inputSummary.getNum()+bean.getNum());
			if(inputSummary.getUnit()!=bean.getUnit()){
				inputSummary.setUnit(null);
			}
			inputSummary.setOrderIds(inputSummary.getOrderIds()+","+bean.getId());
			inputSummary.setOrderIdsBak(inputSummary.getOrderIds());
			try {
				orderInputSummaryMapper.update(inputSummary);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			inputSummary.setOrderIds(bean.getId()+"");
			inputSummary.setOrderIdsBak(inputSummary.getOrderIds());
			inputSummary.setNum(bean.getNum());
			inputSummary.setUnit(bean.getUnit());
			try {
				orderInputSummaryMapper.add(inputSummary);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return olist;
	}
	
	@Override
	public void updateOrderInput(HttpServletRequest request){
		String[] clothId=request.getParameterValues("clothId");
		String[] ids=request.getParameterValues("id");
		String[] myCompanyCode=request.getParameterValues("myCompanyCode");
		String[] myCompanyColor=request.getParameterValues("myCompanyColor");
		String[] num=request.getParameterValues("num");
		//String[] unit=request.getParameterValues("unit");
		String[] technologyIds=request.getParameterValues("technologyId");
		String[] mark=request.getParameterValues("mark");
		String[] salesmanId=request.getParameterValues("salesmanId");
		OrderInputSummary inputSummary=new OrderInputSummary();
		List<OrderInputSummary> olist=null;
		OrderInput bean=new OrderInput();
		for(int i=0;i<clothId.length;i++){
			bean.setId(Integer.parseInt(ids[i]));
			bean.setClothId(Integer.parseInt(clothId[i]));
			bean.setCreateTime(new Date());
			bean.setMark(mark[i]);
			bean.setMyCompanyCode(myCompanyCode[i]);
			bean.setMyCompanyColor(myCompanyColor[i]);
			bean.setNum(Integer.parseInt(num[i]));
			bean.setSalesmanId(Integer.parseInt(salesmanId[i]));
			bean.setTechnologyId(Integer.parseInt(technologyIds[i]));
			bean.setStatus(0);
			ClothInfo clothInfo=new ClothInfo();
			clothInfo=clothInfoService.getById(bean.getClothId()+"");
			bean.setUnit(clothInfo.getUnit());
			try {
				this.update(bean);
				
				//预录入汇总
				inputSummary.setMyCompanyCode(bean.getMyCompanyCode());
				inputSummary.setClothId(bean.getClothId());
				inputSummary.setMyCompanyColor(bean.getMyCompanyColor());
				inputSummary.setTechnologyId(bean.getTechnologyId());
				olist=orderInputSummaryMapper.queryAll(inputSummary);
				if(olist.size()>0){
					inputSummary=olist.get(0);
					inputSummary.setNum(inputSummary.getNum()+bean.getNum());
					if(inputSummary.getUnit()!=bean.getUnit()){
						inputSummary.setUnit(null);
					}
					//inputSummary.setOrderIds(inputSummary.getOrderIds()+","+bean.getId());
					orderInputSummaryMapper.update(inputSummary);
				}else{
					OrderInputSummary orderInputSummary=orderInputSummaryMapper.getByOrderId(bean.getId()+"");
					String orderIds=orderInputSummary.getOrderIds();
					orderIds=orderIds.replace(bean.getId()+"", "").trim();
					orderIds=orderIds.replace(",,",",").trim();
					if(orderIds.equals(",")){
						orderInputSummary.setOrderIds(null);
					}
					if("".equals(orderIds)){
						orderIds=null;
					}
					orderInputSummary.setOrderIds(orderIds);
					orderInputSummaryMapper.update(orderInputSummary);
					inputSummary.setOrderIds(bean.getId()+"");
					inputSummary.setNum(bean.getNum());
					inputSummary.setUnit(bean.getUnit());
					orderInputSummaryMapper.add(inputSummary);
				}
				orderInputAdditionalService.saveAddition(request,bean);
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
		
		// 记录删除记录
		try{
			String username = Common.findAuthenticatedUsername();
			String model = "inputsummary";
			String opType = "delete";
			String opDate = DateUtil.date2Str(new Date(), "yyyy-MM-dd");
			
			RecordLog log = new RecordLog();
			log.setCreateTime(new Date());
			log.setModel(model);
			log.setOpDate(opDate);
			log.setOpType(opType);
			log.setUsername(username);
			log.setNum(1);  // 删除一条记录
			
			recordLogService.add(log);
			
		}catch(Exception e) {
			logger.error("", e);
		}
		
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
