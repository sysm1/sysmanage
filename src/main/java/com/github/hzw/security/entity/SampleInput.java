package com.github.hzw.security.entity;

import java.util.Date;

import com.github.hzw.util.ExcelDataMapper;

public class SampleInput {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.sample_date
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private Date sampleDate;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.factory_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private Integer factoryId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.cloth_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private Integer clothId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.code_type
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private Integer codeType;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.file_code
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private String fileCode;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.factory_code
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private String factoryCode;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.my_company_code
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private String myCompanyCode;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.technology_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private Integer technologyId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.saleman_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private Integer salemanId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.picture
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private String picture;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.status
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private Integer status;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.reply_date
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private Date replyDate;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.create_time
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private Date createTime;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.id
     *
     * @return the value of sample_input.id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    @ExcelDataMapper(title="id",order=1)
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.id
     *
     * @param id the value for sample_input.id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.sample_date
     *
     * @return the value of sample_input.sample_date
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    @ExcelDataMapper(title="开版日期",order=2)
    public Date getSampleDate() {
        return sampleDate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.sample_date
     *
     * @param sampleDate the value for sample_input.sample_date
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setSampleDate(Date sampleDate) {
        this.sampleDate = sampleDate;
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

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.code_type
     *
     * @return the value of sample_input.code_type
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    
    public Integer getCodeType() {
        return codeType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.code_type
     *
     * @param codeType the value for sample_input.code_type
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setCodeType(Integer codeType) {
        this.codeType = codeType;
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

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.factory_code
     *
     * @return the value of sample_input.factory_code
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    @ExcelDataMapper(title="工厂编号",order=6)
    public String getFactoryCode() {
        return factoryCode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.factory_code
     *
     * @param factoryCode the value for sample_input.factory_code
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setFactoryCode(String factoryCode) {
        this.factoryCode = factoryCode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.my_company_code
     *
     * @return the value of sample_input.my_company_code
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
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

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.technology_id
     *
     * @return the value of sample_input.technology_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    @ExcelDataMapper(title="工艺",order=8)
    public Integer getTechnologyId() {
        return technologyId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.technology_id
     *
     * @param technologyId the value for sample_input.technology_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setTechnologyId(Integer technologyId) {
        this.technologyId = technologyId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.saleman_id
     *
     * @return the value of sample_input.saleman_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    @ExcelDataMapper(title="业务员",order=9)
    public Integer getSalemanId() {
        return salemanId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.saleman_id
     *
     * @param salemanId the value for sample_input.saleman_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setSalemanId(Integer salemanId) {
        this.salemanId = salemanId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.picture
     *
     * @return the value of sample_input.picture
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public String getPicture() {
        return picture;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.picture
     *
     * @param picture the value for sample_input.picture
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setPicture(String picture) {
        this.picture = picture;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.status
     *
     * @return the value of sample_input.status
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public Integer getStatus() {
        return status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.status
     *
     * @param status the value for sample_input.status
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setStatus(Integer status) {
        this.status = status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.reply_date
     *
     * @return the value of sample_input.reply_date
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public Date getReplyDate() {
        return replyDate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.reply_date
     *
     * @param replyDate the value for sample_input.reply_date
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setReplyDate(Date replyDate) {
        this.replyDate = replyDate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sample_input.create_time
     *
     * @return the value of sample_input.create_time
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sample_input.create_time
     *
     * @param createTime the value for sample_input.create_time
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    
    private String demand;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sample_input.mark
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private String mark;

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