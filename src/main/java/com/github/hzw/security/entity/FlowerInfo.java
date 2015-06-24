package com.github.hzw.security.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.github.hzw.util.ExcelDataMapper;

public class FlowerInfo {
    
    private Integer id;

    private Integer factoryId;
    private String factoryName;// 冗余
    
    private String myCompanyCode;

    private Integer clothId;
    private String clothName; // 冗余

    // 工厂编号
    private String factoryCode;
    
    private List<FlowerAdditional> list = new ArrayList<FlowerAdditional>();
    
    private String fileColor;

    private Integer technologyId;
    
    private String technologyName; // 冗余
    
    private String picture;

    private Integer status;

    private String statusName;
    
    private Date createTime;
    
    @ExcelDataMapper(title="id",order=1)
    public Integer getId() {
        return id;
    }

    public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFactoryId() {
        return factoryId;
    }

    public void setFactoryId(Integer factoryId) {
        this.factoryId = factoryId;
    }

    @ExcelDataMapper(title="我司编号",order=2)
    public String getMyCompanyCode() {
        return myCompanyCode;
    }

    public void setMyCompanyCode(String myCompanyCode) {
        this.myCompanyCode = myCompanyCode;
    }

    public Integer getClothId() {
        return clothId;
    }

    public void setClothId(Integer clothId) {
        this.clothId = clothId;
    }

    @ExcelDataMapper(title="文件分色号",order=7)
    public String getFileColor() {
        return fileColor;
    }

    public void setFileColor(String fileColor) {
        this.fileColor = fileColor;
    }

    public Integer getTechnologyId() {
        return technologyId;
    }

    public void setTechnologyId(Integer technologyId) {
        this.technologyId = technologyId;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
        if(status == 0) {
        	statusName = "停用";
        } else {
        	statusName = "正常";
        }
    }

    @ExcelDataMapper(title="工厂",order=5)
	public String getFactoryName() {
		return factoryName;
	}

	public void setFactoryName(String factoryName) {
		this.factoryName = factoryName;
	}

	 @ExcelDataMapper(title="布种",order=3)
	public String getClothName() {
		return clothName;
	}

	public void setClothName(String clothName) {
		this.clothName = clothName;
	}

	@ExcelDataMapper(title="工艺",order=4)
	public String getTechnologyName() {
		return technologyName;
	}

	public void setTechnologyName(String technologyName) {
		this.technologyName = technologyName;
	}

	public List<FlowerAdditional> getList() {
		return list;
	}

	public void setList(List<FlowerAdditional> list) {
		this.list = list;
	}

	@ExcelDataMapper(title="工厂编号",order=6)
	public String getFactoryCode() {
		return factoryCode;
	}

	public void setFactoryCode(String factoryCode) {
		this.factoryCode = factoryCode;
	}

	@Override
	public String toString() {
		return "FlowerInfo [id=" + id + ", factoryId=" + factoryId
				+ ", factoryName=" + factoryName + ", myCompanyCode="
				+ myCompanyCode + ", clothId=" + clothId + ", clothName="
				+ clothName + ", factoryCode=" + factoryCode + ", list=" + list
				+ ", fileColor=" + fileColor + ", technologyId=" + technologyId
				+ ", technologyName=" + technologyName + ", picture=" + picture
				+ ", status=" + status + "]";
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	
}