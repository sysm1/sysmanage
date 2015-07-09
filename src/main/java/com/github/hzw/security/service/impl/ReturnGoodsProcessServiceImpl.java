package com.github.hzw.security.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.OrderSummaryVO;
import com.github.hzw.security.entity.ClothAllowance;
import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FlowerAdditional;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.entity.ReturnGoodsProcess;
import com.github.hzw.security.mapper.ReturnGoodsProcessMapper;
import com.github.hzw.security.service.ClothAllowanceService;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.FlowerAdditionalService;
import com.github.hzw.security.service.FlowerInfoService;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.security.service.ReturnGoodsProcessService;
import com.github.hzw.util.DateUtil;

@Transactional
@Service("returnGoodsProcessService")
public class ReturnGoodsProcessServiceImpl implements ReturnGoodsProcessService {

	@Autowired
	private ReturnGoodsProcessMapper returnGoodsProcessMapper;
	
	@Inject
	private FlowerInfoService flowerInfoService;
	
	@Autowired
	private OrderSummaryService orderSummaryService;
	
	@Inject
	private ClothAllowanceService clothAllowanceService;
	
	@Inject
	private ClothInfoService clothInfoService;
	
	@Inject
	private FlowerAdditionalService flowerAdditionalService;
	
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
	
	/**
	 * 查询拖延单数
	 * @param dates
	 * @return
	 */
	public String queryDelayDates(String dates){
		return returnGoodsProcessMapper.queryDelayDates(dates);
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
	@Override
	public void save(HttpServletRequest request,OrderSummary orderSummary){
		String id=request.getParameter("id");
		String[] returnCodes=request.getParameterValues(id+"returnCode");
		String[] returnNums=request.getParameterValues(id+"returnNum");
		String[] returnNumKgs=request.getParameterValues(id+"returnNumKg");
		String[] returnColors=request.getParameterValues(id+"factoryColor");
		String[] zhiguans=request.getParameterValues(id+"zhiguan");
		String[] kongchas=request.getParameterValues(id+"kongcha");
		String[] jiaodais=request.getParameterValues(id+"jiaodai");
		String[] clothNames=request.getParameterValues(id+"clothName");
		String[] factoryNames=request.getParameterValues(id+"factoryName");
		String[] myCompanyCodes=request.getParameterValues(id+"myCompanyCode");
		String[] myCompanyColors=request.getParameterValues(id+"myCompanyColor");
		String[] technologyNames=request.getParameterValues(id+"technologyName");
		String[] marks=request.getParameterValues(id+"mark");
		String[] returnDate=request.getParameterValues(id+"returnDate");
		String returnStatus=request.getParameter("returnStatus");
		String returnMark="";
		ClothInfo clothInfo=clothInfoService.getById(orderSummary.getClothId()+"");
		Double tiaoKg=clothInfo.getTiaoKg();
		int unit=orderSummary.getUnit();
		try {
			int returnNum=0;
			/**回货净重量*/
			Double returnNumKg=0D;
			int size=zhiguans.length;
			ReturnGoodsProcess bean=null;
			returnGoodsProcessMapper.deleteBySummaryId(orderSummary.getId()+"");
			for(int i=0;i<size;i++){
				bean=new ReturnGoodsProcess();
				bean.setCreateTime(new Date());
				bean.setMark(marks[i]);
				returnMark+=marks[i];
				if(null!=returnColors&&!"".equals(returnColors)){
					bean.setReturnColor(returnColors[i]);
				}
				bean.setReturnDate(new Date());
				if(null!=returnNums[i]&&!"".equals(returnNums[i])){
					bean.setReturnNum(Integer.parseInt(returnNums[i]));
				}if(null!=returnNumKgs[i]&&!"".equals(returnNumKgs[i])){
					bean.setReturnNumKg(Double.parseDouble(returnNumKgs[i]));
				}if(null!=returnCodes[i]&&!"".equals(returnCodes[i])){
					bean.setReturnCode(returnCodes[i]);
				}
				
				bean.setReturnUnit("");
				bean.setStatisticsNum(null);
				bean.setSummaryId(orderSummary.getId());
				if(null!=zhiguans[i]&&!"".equals(zhiguans[i])){
					bean.setZhiguan(Double.parseDouble(zhiguans[i]));
				}
				if(null!=kongchas[i]&&!"".equals(kongchas[i])){
					bean.setKongcha(Double.parseDouble(kongchas[i]));
				}if(null!=jiaodais[i]&&!"".equals(jiaodais[i])){
					bean.setJiaodai(Double.parseDouble(jiaodais[i]));
				}
				bean.setReturnDate(DateUtil.str2Date(returnDate[i],"yyyy-MM-DD"));
				bean.setClothName(clothNames[i]);
				bean.setFactoryName(factoryNames[i]);
				bean.setMyCompanyCode(myCompanyCodes[i]);
				bean.setMyCompanyColor(myCompanyColors[i]);
				bean.setTechnologyName(technologyNames[i]);
				add(bean);
				
				if(null!=bean.getReturnNum()){
					returnNum+=bean.getReturnNum();
				}
				double xz=0;//虚重量
				if(null!=bean.getZhiguan()){
					xz+=bean.getZhiguan();
				}if(null!=bean.getKongcha()){
					xz+=bean.getKongcha();
				}if(null!=bean.getJiaodai()){
					xz+=bean.getJiaodai();
				}
				if(0==unit){
					//公斤数
					if(null!=returnNumKgs[i]&&!"".equals(returnNumKgs[i])){
						returnNumKg+=Double.parseDouble(returnNumKgs[i]);
					}
					if(null!=bean.getReturnNum()&&!"".equals(bean.getReturnNum())){
						returnNumKg-=xz*bean.getReturnNum();
					}
				}else{
					if(null!=returnNumKgs[i]&&!"".equals(returnNumKgs[i])){
						returnNumKg+=Double.parseDouble(returnNumKgs[i])-xz*bean.getReturnNum();
					}
				}
			}
			if("2".equals(returnStatus)){
				//修改坯布余量
				orderSummary=orderSummaryService.getById(orderSummary.getId()+"");
				Double alreadOrderSum=orderSummary.getNum();
				
				ClothAllowance clothAllowance=clothAllowanceService.queryByClothAndFactory(orderSummary.getClothId(), orderSummary.getFactoryId(),orderSummary.getColor());
				if(null!=clothAllowance){
					//如果是条为单位的  计算条和KG的数量
					if(0==unit){
						//单量虚重
						alreadOrderSum=alreadOrderSum-returnNum;
						clothAllowance.setAllowance(clothAllowance.getAllowance()+alreadOrderSum.intValue());
						clothAllowance.setAllowancekg(clothAllowance.getAllowancekg()+orderSummary.getNum()*tiaoKg-returnNumKg);
					}else{//以包为单位的计算KG的数量
						alreadOrderSum=alreadOrderSum-returnNumKg;
						clothAllowance.setAllowancekg(clothAllowance.getAllowancekg()+orderSummary.getNum()-returnNumKg);
					}
					clothAllowanceService.addAllowance(clothAllowance);
					//坯布余量修改完成
				}
			}
			
			//状态 判断
			orderSummary.setReturnMark(returnMark);
			orderSummary.setStatus(getReturnStatusName(orderSummary));
			orderSummary.setReturnStatus(Integer.parseInt(returnStatus));
			orderSummaryService.update(orderSummary);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getReturnStatusName(OrderSummary orderSummary){
		//1.是否为新厂
		String statusName="";
		int factoryId=orderSummary.getFactoryId();
		FlowerInfo flowerInfo=new FlowerInfo();
		flowerInfo.setFactoryId(factoryId);
		if(flowerInfoService.queryAll(flowerInfo).size()==0){
			statusName+=","+"新厂";
		}
		//2.是否为新布
		int clothId=orderSummary.getClothId();
		flowerInfo=new FlowerInfo();
		flowerInfo.setClothId(clothId);
		if(flowerInfoService.queryAll(flowerInfo).size()==0){
			statusName+=","+"新布";
		}
		//3.是否为新花
		String myCompanyCode=orderSummary.getMyCompanyCode();
		flowerInfo=new FlowerInfo();
		flowerInfo.setMyCompanyCode(myCompanyCode);
		if(flowerInfoService.queryFind(flowerInfo).size()==0){
			statusName+=","+"新花";
		}
		//4.是否为新色
		String myCompanyColor=orderSummary.getMyCompanyColor();
		FlowerAdditional flowerAdditional=new FlowerAdditional();
		flowerAdditional.setMyCompanyColor(myCompanyColor);
		if(flowerAdditionalService.queryFind(flowerAdditional).size()==0){
			statusName+=","+"新色";
		}
		if(statusName.equals("")){
			statusName=",已回";
		}
		return statusName.substring(1);
	}
	
	/**
	 * 修改状态
	 * @param ids
	 * @param status
	 */
	public void updateStatus(String ids,String status){
		String[] idsa=ids.split(",");
		OrderSummary orderSummary=null;
		for(String id:idsa){
			orderSummary=orderSummaryService.getById(id);
			if(orderSummary.getReturnStatus()!=2){
				continue;
			}
			orderSummary.setReturnStatus(Integer.parseInt(status));
			try {
				orderSummaryService.update(orderSummary);
			} catch (Exception e) {
				e.printStackTrace();
			}
			//修改坯布余量
			ClothAllowance clothAllowance=clothAllowanceService.queryByClothAndFactory(orderSummary.getClothId(), orderSummary.getFactoryId(),orderSummary.getColor());
			Integer unit=orderSummary.getUnit();
			ClothInfo cloth=clothInfoService.getById(orderSummary.getClothId()+"");
			if(0==unit){
				List<ReturnGoodsProcess> processList=returnGoodsProcessMapper.queryBySummaryId(orderSummary.getId()+"");
				int returnNum=0;
				int returnNumKg=0;//计算KG量 净重
				for(ReturnGoodsProcess process:processList){
					returnNum+=process.getReturnNum();
					returnNumKg+=process.getReturnNumKg()-(process.getZhiguan()+process.getKongcha()+process.getJiaodai()*process.getReturnNum());
				}
				int tiao=clothAllowance.getAllowance();
				Double kgl=clothAllowance.getAllowancekg();
				tiao=tiao-orderSummary.getNum().intValue();
				tiao=tiao+returnNum;
				kgl=kgl+returnNumKg;
				kgl=kgl-orderSummary.getNum().intValue()*cloth.getTiaoKg();
				clothAllowance.setAllowance(tiao);//单位为条的
				clothAllowance.setAllowancekg(kgl);
			}else{
				double orderKg=orderSummary.getNum();//下单公斤数
				double returnKg=0;//回货公斤数
				List<ReturnGoodsProcess> processList=returnGoodsProcessMapper.queryBySummaryId(orderSummary.getId()+"");
				for(ReturnGoodsProcess process:processList){
					returnKg+=process.getReturnNumKg()-(process.getZhiguan()+process.getKongcha()+process.getJiaodai()*process.getReturnNum());
				}
				orderKg=clothAllowance.getAllowancekg()-orderKg+returnKg;
				clothAllowance.setAllowancekg(orderKg);
			}
			try {
				clothAllowanceService.updateClothAllowance(clothAllowance);
			} catch (Exception e) {
				e.printStackTrace();
			}
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
	
	@Override
	public List<String> queryReturnTime(String summaryId){
		return returnGoodsProcessMapper.queryReturnTime(summaryId);
	}


}
