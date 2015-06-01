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
import com.github.hzw.security.VO.OrderInputVO;
import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.AuditBean;
import com.github.hzw.security.entity.OrderNotifyInfo;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.mapper.AuditMapper;
import com.github.hzw.security.service.AuditService;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.security.service.OrderInputService;
import com.github.hzw.security.service.OrderNotifyInfoService;
import com.github.hzw.security.service.OrderSummaryService;

@Transactional
@Service("auditService")
public class AuditServiceImpl implements AuditService {
	
	@Autowired
	private AuditMapper auditMapper;
	
	@Autowired
	private OrderInputService orderInputService;
	
	@Autowired
	private ClothInfoService clothInfoService;
	
	@Autowired
	private OrderSummaryService orderSummaryService;
	
	@Inject
	private OrderNotifyInfoService orderNotifyInfoService;

	@Override
	public PageView query(PageView pageView, AuditBean t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<AuditBean> list = auditMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	@Override
	public List<AuditBean> queryAll(AuditBean t) {
		return auditMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {

	}

	@Override
	public void update(AuditBean t) throws Exception {
		auditMapper.update(t);
	}

	@Override
	public AuditBean getById(String id) {
		return auditMapper.getById(id);
	}

	@Override
	public void add(AuditBean t) throws Exception {
		auditMapper.add(t);
	}
	
	@Override
	public void toAudit(String ids,String type,HttpServletRequest request){
		Account user=(Account) request.getSession().getAttribute("userSession");
		try {
			AuditBean ab=null;
			if("1".equals(type)){//下单预录入
				List<OrderInputVO> list=orderInputService.queryByIds(ids.split(","));
				for(OrderInputVO vo:list){
					if(vo.getCreateTime().before(new Date())){//过期单
						AuditBean t=new AuditBean();
						t.setType(Integer.parseInt(type));
						t.setOrderId(vo.getId());
						List<AuditBean> auditList=queryAll(t);
						if(null==auditList||auditList.size()==0){//添加到审核表
							ab=new AuditBean();
							//ab.setAuditorId(user.getId());
							//b.setCreateTime(new Date());
							ab.setMyCompanyCode(vo.getMyCompanyCode());
							ab.setMyCompanyColor(vo.getMyCompanyColor());
							ab.setType(Integer.parseInt(type));
							ab.setStatus(0);
							ab.setOrderId(vo.getId());
							ab.setClothName(vo.getClothName());
							ab.setOrderTime(vo.getCreateTime());
						}
					}
				}
			}else if("2".equals(type)){//下单预录入
				OrderSummary vo=orderSummaryService.getById(ids);
				if(vo.getCreateTime().before(new Date())){//过期单
					AuditBean t=new AuditBean();
					t.setType(Integer.parseInt(type));
					t.setOrderId(vo.getId());
					List<AuditBean> auditList=queryAll(t);
					if(null==auditList||auditList.size()==0){//添加到审核表
						ab=new AuditBean();
						//ab.setAuditorId(user.getId());
						//b.setCreateTime(new Date());
						ab.setMyCompanyCode(vo.getMyCompanyCode());
						ab.setMyCompanyColor(vo.getMyCompanyColor());
						ab.setType(Integer.parseInt(type));
						ab.setStatus(0);
						ab.setOrderId(vo.getId());
						ab.setClothName(vo.getClothName());
						ab.setOrderTime(vo.getOrderDate());
					}
				}
			}else if("3".equals(type)){//下单打印
				OrderNotifyInfo vo=orderNotifyInfoService.getById(ids);
				if(vo.getCreateTime().before(new Date())){//过期单
					AuditBean t=new AuditBean();
					t.setType(Integer.parseInt(type));
					t.setOrderId(vo.getId());
					List<AuditBean> auditList=queryAll(t);
					if(null==auditList||auditList.size()==0){//添加到审核表
						ab=new AuditBean();
						//ab.setAuditorId(user.getId());
						//b.setCreateTime(new Date());
						ab.setMyCompanyCode(vo.getNo());
						//ab.setMyCompanyColor(vo.getMyCompanyColor());
						ab.setType(Integer.parseInt(type));
						ab.setStatus(0);
						ab.setOrderId(vo.getId());
						ab.setClothName(vo.getFactoryName());
						ab.setOrderTime(vo.getCreateTime());
						
					}
				}
			}
			if(null!=ab){
				this.add(ab);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
