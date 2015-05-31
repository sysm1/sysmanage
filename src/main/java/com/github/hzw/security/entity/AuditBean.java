package com.github.hzw.security.entity;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.github.hzw.util.JsonDate4YYYYMMDD;


/**
 * 审核实体类
 * @author wuyb
 *
 */
@SuppressWarnings("serial")
public class AuditBean implements java.io.Serializable{
	
	private Integer id;
	
	/**类型 1为下单  2为打印下单**/
	private Integer type;
	
	/***单据ID**/
	private Integer orderId;
	
	/**0未审核 1审核通过  2审核未通过**/
	private Integer status;
	
	/***审核原因**/
	private String reason;
	
	/***审核时间***/
	private Date createTime;
	
	/***审核人ID***/
	private Integer auditorId;
	
	private String auditName;
	
	/***下单时间**/
	private Date orderTime;
	
	private String clothName;
	
	private String myCompanyColor;
	
	private String myCompanyCode;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	/***类型 1为下单预录入  2下单汇总  3为打印下单**/
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getAuditorId() {
		return auditorId;
	}

	public void setAuditorId(Integer auditorId) {
		this.auditorId = auditorId;
	}

	public String getAuditName() {
		return auditName;
	}

	public void setAuditName(String auditName) {
		this.auditName = auditName;
	}
	@JsonSerialize(using=JsonDate4YYYYMMDD.class)
	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	public String getClothName() {
		return clothName;
	}

	public void setClothName(String clothName) {
		this.clothName = clothName;
	}

	public String getMyCompanyColor() {
		return myCompanyColor;
	}

	public void setMyCompanyColor(String myCompanyColor) {
		this.myCompanyColor = myCompanyColor;
	}

	public String getMyCompanyCode() {
		return myCompanyCode;
	}

	public void setMyCompanyCode(String myCompanyCode) {
		this.myCompanyCode = myCompanyCode;
	}

}
