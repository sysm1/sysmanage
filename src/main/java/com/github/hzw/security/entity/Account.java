package com.github.hzw.security.entity;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.github.hzw.util.ExcelDataMapper;
import com.github.hzw.util.JsonDateSerializer;


/**
 * 账号实体表
 */
@SuppressWarnings("serial")
public class Account implements java.io.Serializable {
	
	private int id;

	private String accountName;//账号名
	
	private String roleName;//账号名

	private String password;//密码

	private String description;//说明

	private String state;//账号状态  0 表示停用  1表示启用
	
	private String stateName;//账号状态  0 表示停用  1表示启用
	
	private Integer cityId;
	
	private String cityName;

	private Date createTime; //创建时间
	@ExcelDataMapper(title="id",order=1)
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	@ExcelDataMapper(title="账号名称",order=2)
	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	@ExcelDataMapper(title="账号状态",order=3)
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	/**
	 * 时间格式化
	 * @return
	 */
	@ExcelDataMapper(title="创建时间",order=4)
	@JsonSerialize(using=JsonDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	
	
	@Override
	public String toString() {
		return "Account [id=" + id + ", accountName=" + accountName
				+ ", roleName=" + roleName + ", password=" + password
				+ ", description=" + description + ", state=" + state
				+ ", cityId=" + cityId + ", createTime=" + createTime + "]";
	}

	@ExcelDataMapper(title="描述",order=5)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Integer getCityId() {
		return cityId;
	}

	public void setCityId(Integer cityId) {
		this.cityId = cityId;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getStateName() {
		if("0".equals(state)){
			stateName="停用";
		}else{
			stateName="正常";
		}
		return stateName;
	}

	public void setStateName(String stateName) {
		this.stateName = stateName;
	}

}
