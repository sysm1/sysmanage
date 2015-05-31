package com.github.hzw.security.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.security.VO.OrderInputVO;
import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.AuditBean;
import com.github.hzw.security.entity.OrderInput;
import com.github.hzw.security.entity.OrderNotifyInfo;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.service.AuditService;
import com.github.hzw.security.service.OrderInputService;
import com.github.hzw.security.service.OrderNotifyInfoService;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.util.Common;
import com.github.hzw.util.DateUtil;

@Controller
@RequestMapping("/background/orderAudit/")
public class OrderAuditController extends BaseController{
	
	@Inject
	private OrderInputService orderInputService;
	
	@Inject
	private OrderSummaryService orderSummaryService;
	
	@Inject
	private AuditService auditService;
	
	@Inject
	private OrderNotifyInfoService orderNotifyInfoService;
	
	@RequestMapping("list")
	public String list(Model model,String pageNow,AuditBean info,String flag) {
		pageView = auditService.query(getPageView(pageNow,null), info);
		model.addAttribute("pageView", pageView);
		model.addAttribute("info",info);
		return Common.BACKGROUND_PATH+"/orderAudit/list";
	}
	
	/**
	 * 审核页面
	 * @param model
	 * @param id 审核ID
	 * @return
	 */
	@RequestMapping("auditUI")
	public String auditUI(Model model,String id) {
		AuditBean audit=auditService.getById(id);
		model.addAttribute("id", id);
		model.addAttribute("audit",audit);
		if(audit.getType()==1){//下单预录入
			OrderInput orderInput=orderInputService.getById(audit.getOrderId()+"");
			model.addAttribute("bean", orderInput);
			return Common.BACKGROUND_PATH+"/orderAudit/auditOrderInput";
		}else if(audit.getType()==2){
			OrderSummary orderSummary=orderSummaryService.getById(audit.getOrderId()+"");
			model.addAttribute("inputsummary",orderSummary);
			return Common.BACKGROUND_PATH+"/orderAudit/auditOrderSummary";
		}else if(audit.getType()==3){
			OrderNotifyInfo orderNotifyInfo=orderNotifyInfoService.getById(audit.getOrderId()+"");
			String[] ids=orderNotifyInfo.getSummaryIds().split(",");
			List<OrderSummary> list=orderSummaryService.queryByIds(ids);
			model.addAttribute("orderNotifyInfo",orderNotifyInfo);
			model.addAttribute("list",list);
			return Common.BACKGROUND_PATH+"/orderAudit/auditPrint";
		}
		return Common.BACKGROUND_PATH+"/orderAudit/audit";
	}
	
	/**
	 * 保存数据
	 * 
	 * @param model
	 * @param videoType
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("audit")
	@ResponseBody
	public Map<String, Object> audit(AuditBean info) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			info.setCreateTime(new Date());
			auditService.update(info);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	@RequestMapping("checkTime")
	@ResponseBody
	public Map<String, Object> checkTime(String ids,String type) {
		String newIds=ids;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("flag","true" );
		try {
			if("1".equals(type)){//下单预录入
				List<OrderInputVO> list=orderInputService.queryByIds(ids.split(","));
				for(OrderInputVO vo:list){
					if(DateUtil.DatePattern(vo.getCreateTime(),"yyyy-MM-dd").before(DateUtil.DatePattern(new Date(),"yyyy-MM-dd"))){//过期单
						AuditBean t=new AuditBean();
						t.setType(Integer.parseInt(type));
						t.setOrderId(vo.getId());
						List<AuditBean> auditList=auditService.queryAll(t);
						if(null!=auditList&&auditList.size()>0){
							if(auditList.get(0).getStatus()==0){
								map.put("flag","false" );
								newIds=newIds.replace(newIds, vo.getId()+"");
								//break;
							}else if(auditList.get(0).getStatus()==2){
								map.put("flag","false2" );
								map.put("reason", auditList.get(0).getReason());
							}
						}else{
							map.put("flag","false" );
							//newIds=newIds.replace(vo.getId()+"", "");
							for(String id:newIds.split(",")){
								if(id.split("_")[0].equals(vo.getId()+"")){
									newIds=newIds.replace(id,"");
								}
							}
							//break;
						}
					}
				}
				newIds=newIds.replace(",,", ",");
				String ff=newIds;
				map.put("ff",ff.replace(",","") );
				map.put("newIds",newIds);
			}else if("2".equals(type)){
				OrderSummary vo=orderSummaryService.getById(ids);
				if(DateUtil.DatePattern(vo.getOrderDate(),"yyyy-MM-dd").before(DateUtil.DatePattern(new Date(),"yyyy-MM-dd"))){//过期单
					AuditBean t=new AuditBean();
					t.setType(Integer.parseInt(type));
					t.setOrderId(vo.getId());
					List<AuditBean> auditList=auditService.queryAll(t);
					if(null!=auditList&&auditList.size()>0){
						if(auditList.get(0).getStatus()==0){
							map.put("flag","false" );
							newIds=newIds.replace(newIds, vo.getId()+"");
						}else if(auditList.get(0).getStatus()==2){
							map.put("flag","false2" );
							map.put("reason", auditList.get(0).getReason());
						}
					}else{
						map.put("flag","false" );
						for(String id:newIds.split(",")){
							if(id.split("_")[0].equals(vo.getId()+"")){
								newIds=newIds.replace(id,"");
							}
						}
					}
				}
				newIds=newIds.replace(",,", ",");
				String ff=newIds;
				map.put("ff",ff.replace(",","") );
				map.put("newIds",newIds);
			}
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	} 
	/**
	 * 转到审核
	 * @param model
	 * @param videoType
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("toAudit")
	@ResponseBody
	public Map<String, Object> toAudit(String ids,String type,HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			auditService.toAudit(ids, type, request);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
}
