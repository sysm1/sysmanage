package com.github.hzw.security.entity;

import com.github.hzw.util.ExcelDataMapper;

// 预下单录入汇总表  关键字  inputsummary
public class OrderInputSummary {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order_input_summary.id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private Integer id;

    private Integer clothId;

    private String myCompanyCode;

    private String myCompanyColor;

    private Integer num;
    
    private Integer technologyId;
    
    private String technologyName;
    
    /***数量单位**/
    private Integer unit;

    private String orderIds;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order_input_summary.mark
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private String mark;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order_input_summary.id
     *
     * @return the value of order_input_summary.id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    @ExcelDataMapper(title="id",order=1)
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order_input_summary.id
     *
     * @param id the value for order_input_summary.id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order_input_summary.cloth_id
     *
     * @return the value of order_input_summary.cloth_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public Integer getClothId() {
        return clothId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order_input_summary.cloth_id
     *
     * @param clothId the value for order_input_summary.cloth_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setClothId(Integer clothId) {
        this.clothId = clothId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order_input_summary.my_company_code
     *
     * @return the value of order_input_summary.my_company_code
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public String getMyCompanyCode() {
        return myCompanyCode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order_input_summary.my_company_code
     *
     * @param myCompanyCode the value for order_input_summary.my_company_code
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setMyCompanyCode(String myCompanyCode) {
        this.myCompanyCode = myCompanyCode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order_input_summary.my_company_color
     *
     * @return the value of order_input_summary.my_company_color
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public String getMyCompanyColor() {
        return myCompanyColor;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order_input_summary.my_company_color
     *
     * @param myCompanyColor the value for order_input_summary.my_company_color
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setMyCompanyColor(String myCompanyColor) {
        this.myCompanyColor = myCompanyColor;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order_input_summary.num
     *
     * @return the value of order_input_summary.num
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public Integer getNum() {
        return num;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order_input_summary.num
     *
     * @param num the value for order_input_summary.num
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setNum(Integer num) {
        this.num = num;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order_input_summary.order_ids
     *
     * @return the value of order_input_summary.order_ids
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public String getOrderIds() {
        return orderIds;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order_input_summary.order_ids
     *
     * @param orderIds the value for order_input_summary.order_ids
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setOrderIds(String orderIds) {
        this.orderIds = orderIds;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order_input_summary.mark
     *
     * @return the value of order_input_summary.mark
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public String getMark() {
        return mark;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order_input_summary.mark
     *
     * @param mark the value for order_input_summary.mark
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setMark(String mark) {
        this.mark = mark;
    }
    /***数量单位**/
	public Integer getUnit() {
		return unit;
	}
	/***数量单位**/
	public void setUnit(Integer unit) {
		this.unit = unit;
	}

	public Integer getTechnologyId() {
		return technologyId;
	}

	public void setTechnologyId(Integer technologyId) {
		this.technologyId = technologyId;
	}

	public String getTechnologyName() {
		return technologyName;
	}

	public void setTechnologyName(String technologyName) {
		this.technologyName = technologyName;
	}
}