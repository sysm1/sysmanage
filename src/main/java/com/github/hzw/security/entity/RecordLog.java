package com.github.hzw.security.entity;

import java.util.Date;

public class RecordLog {
    
    private Integer id;

    private String username;

    private String model;

    private String opType;

    private String opDate;

    private Date createTime;

    public Integer getId() {
        return id;
    }
 
    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getOpType() {
        return opType;
    }
   
    public void setOpType(String opType) {
        this.opType = opType;
    }

    public String getOpDate() {
        return opDate;
    }

    public void setOpDate(String opDate) {
        this.opDate = opDate;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	@Override
	public String toString() {
		return "RecordLog [id=" + id + ", username=" + username + ", model="
				+ model + ", opType=" + opType + ", opDate=" + opDate
				+ ", createTime=" + createTime + "]";
	}
    
    
}