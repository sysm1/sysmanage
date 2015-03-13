package com.github.hzw.security.entity;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.github.hzw.util.ExcelDataMapper;
import com.github.hzw.util.JsonDate4YYYYMMDD;

public class SampleInput {
	
    private Integer id;

    private Date sampleDate;
    
    /**查询条件开始时间**/
    private Date startDate;
    
    /**查询条件结束时间**/
    private Date endDate;
    
    /**查询条件开始时间**/
    private Date rstartDate;
    
    /**查询条件结束时间**/
    private Date rendDate;

    private Integer factoryId;

    private Integer clothId;

    private Integer codeType;
    
    /**编号值**/
    private String codeValue;
    
    private String fileCode;

    private String factoryCode;

    private String myCompanyCode;

    private Integer technologyId;

    private Integer salemanId;

    private String picture;
    
    /***缩略图**/
    private String smallPicture;

    private Integer status;

    private Date replyDate;
    
    private String demand;

    private String mark;
    
    /**回版备注**/
    private String replyMark;

    private Date createTime;

    @ExcelDataMapper(title="id",order=1)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @ExcelDataMapper(title="开版日期",order=2)
    @JsonSerialize(using=JsonDate4YYYYMMDD.class)
    public Date getSampleDate() {
        return sampleDate;
    }

    public void setSampleDate(Date sampleDate) {
        this.sampleDate = sampleDate;
    }

    /**查询条件开始时间**/
    public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	/**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.factory_id
     *
     * @return the value of sample_input.factory_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    @ExcelDataMapper(title="工厂",order=3)
    public Integer getFactoryId() {
        return factoryId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.factory_id
     *
     * @param factoryId the value for sample_input.factory_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setFactoryId(Integer factoryId) {
        this.factoryId = factoryId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.cloth_id
     *
     * @return the value of sample_input.cloth_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    @ExcelDataMapper(title="布种",order=4)
    public Integer getClothId() {
        return clothId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.cloth_id
     *
     * @param clothId the value for sample_input.cloth_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setClothId(Integer clothId) {
        this.clothId = clothId;
    }
    
    public Integer getCodeType() {
        return codeType;
    }

    public void setCodeType(Integer codeType) {
        this.codeType = codeType;
    }
    /**
     * 编号值 wuyb
     * @return
     */
    @ExcelDataMapper(title="编号",order=5)
    public String getCodeValue() {
		return codeValue;
	}
    /**编号值 wuyb**/
	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}

	/**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.file_code
     *
     * @return the value of sample_input.file_code
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    @ExcelDataMapper(title="分色文件号",order=5)
    public String getFileCode() {
        return fileCode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.file_code
     *
     * @param fileCode the value for sample_input.file_code
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setFileCode(String fileCode) {
        this.fileCode = fileCode;
    }

    @ExcelDataMapper(title="工厂编号",order=6)
    public String getFactoryCode() {
        return factoryCode;
    }

    public void setFactoryCode(String factoryCode) {
        this.factoryCode = factoryCode;
    }

    @ExcelDataMapper(title="我司编号",order=7)
    public String getMyCompanyCode() {
        return myCompanyCode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.my_company_code
     *
     * @param myCompanyCode the value for sample_input.my_company_code
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setMyCompanyCode(String myCompanyCode) {
        this.myCompanyCode = myCompanyCode;
    }

    @ExcelDataMapper(title="工艺",order=8)
    public Integer getTechnologyId() {
        return technologyId;
    }

    public void setTechnologyId(Integer technologyId) {
        this.technologyId = technologyId;
    }

    @ExcelDataMapper(title="业务员",order=9)
    public Integer getSalemanId() {
        return salemanId;
    }

    public void setSalemanId(Integer salemanId) {
        this.salemanId = salemanId;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }
    @ExcelDataMapper(title="状态",order=10)
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(Date replyDate) {
        this.replyDate = replyDate;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	public String getDemand() {
		return demand;
	}

	public void setDemand(String demand) {
		this.demand = demand;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public Date getRstartDate() {
		return rstartDate;
	}

	public void setRstartDate(Date rstartDate) {
		this.rstartDate = rstartDate;
	}

	public Date getRendDate() {
		return rendDate;
	}

	public void setRendDate(Date rendDate) {
		this.rendDate = rendDate;
	}

	public String getSmallPicture() {
		return smallPicture;
	}

	public void setSmallPicture(String smallPicture) {
		this.smallPicture = smallPicture;
	}

	public String getReplyMark() {
		return replyMark;
	}
	@ExcelDataMapper(title="回版备注",order=11)
	public void setReplyMark(String replyMark) {
		this.replyMark = replyMark;
	}

	@Override
	public String toString() {
		return "SampleInput [id=" + id + ", sampleDate=" + sampleDate
				+ ", factoryId=" + factoryId + ", clothId=" + clothId
				+ ", codeType=" + codeType + ", fileCode=" + fileCode
				+ ", factoryCode=" + factoryCode + ", myCompanyCode="
				+ myCompanyCode + ", technologyId=" + technologyId
				+ ", salemanId=" + salemanId + ", picture=" + picture
				+ ", status=" + status + ", replyDate=" + replyDate
				+ ", createTime=" + createTime + ", demand=" + demand
				+ ", mark=" + mark + "]";
	}
    
	
    
}