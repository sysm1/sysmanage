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
import com.github.hzw.security.VO.OrderSummaryVO;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.entity.ReturnGoodsProcess;
import com.github.hzw.security.mapper.ReturnGoodsProcessMapper;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.security.service.ReturnGoodsProcessService;
import com.github.hzw.util.DateUtil;

@Transactional
@Service("returnGoodsProcessService")
public class ReturnGoodsProcessServiceImpl implements ReturnGoodsProcessService {

	@Autowired
	private ReturnGoodsProcessMapper returnGoodsProcessMapper;
	
	@Autowired
	private OrderSummaryService orderSummaryService;
	
	@Override
	public PageView query(PageView pageView, ReturnGoodsProcess t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<ReturnGoodsProcess> list = returnGoodsProcessMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}
	
	/**
	 * 返回分页后的数据
	 * @param pageView
	 * @param t
	 * @return
	 */
	@Override
	public PageView queryVO(PageView pageView,Map<String,String> map1){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("factoryId", map1.get("factoryId"));
		map.put("code", map1.get("code"));
		List<OrderSummaryVO> list = returnGoodsProcessMapper.queryVO(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<ReturnGoodsProcess> queryAll(ReturnGoodsProcess t) {
		return returnGoodsProcessMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		returnGoodsProcessMapper.delete(id);
		
	}

	@Override
	public void update(ReturnGoodsProcess t) throws Exception {
		this.returnGoodsProcessMapper.update(t);
		
	}
	
	/**
	 * 暂存数据
	 * @param request
	 * @param summaryId
	 */
	public void save(HttpServletRequest request,OrderSummary orderSummary){
		String[] returnDates=request.getParameterValues("returnDate");
		String[] returnNums=request.getParameterValues("returnNum");
		String[] returnColors=request.getParameterValues("returnColor");
		String[] marks=request.getParameterValues("mark");
		String[] zhiguans=request.getParameterValues("zhiguan");
		String[] kongchas=request.getParameterValues("kongcha");
		String[] jiaodais=request.getParameterValues("jiaodai");
		try {
			int size=returnDates.length;
			ReturnGoodsProcess bean=null;
			returnGoodsProcessMapper.deleteBySummaryId(orderSummary.getId()+"");
			for(int i=0;i<size;i++){
				bean=new ReturnGoodsProcess();
				bean.setCreateTime(new Date());
				bean.setMark(marks[i]);
				bean.setReturnColor(returnColors[i]);
				bean.setReturnDate(DateUtil.str2Date(returnDates[i],"yyyy-MM-dd"));
				bean.setReturnNum(Integer.parseInt(returnNums[i]));
				bean.setReturnUnit("");
				bean.setStatisticsNum(null);
				bean.setSummaryId(orderSummary.getId());
				bean.setZhiguan(Integer.parseInt(zhiguans[i]));
				bean.setKongcha(Integer.parseInt(kongchas[i]));
				bean.setJiaodai(Integer.parseInt(jiaodais[i]));
				add(bean);
				orderSummaryService.update(orderSummary);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 查询下单附属
	 * @param summaryId
	 * @return
	 */
	public List<ReturnGoodsProcess> queryBySummaryId(String summaryId){
		return returnGoodsProcessMapper.queryBySummaryId(summaryId);
	}

	@Override
	public ReturnGoodsProcess getById(String id) {
		return this.returnGoodsProcessMapper.getById(id);
	}

	@Override
	public void add(ReturnGoodsProcess t) throws Exception {
		this.returnGoodsProcessMapper.add(t);
	}


}
