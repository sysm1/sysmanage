package com.github.hzw.security.entity;

public class OrderInputAdditional {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order_input_additional.id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order_input_additional.input_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    private Integer inputId;

    private String myCompanyColor;

    private Integer num;

    private String mark;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order_input_additional.id
     *
     * @return the value of order_input_additional.id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order_input_additional.id
     *
     * @param id the value for order_input_additional.id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order_input_additional.input_id
     *
     * @return the value of order_input_additional.input_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public Integer getInputId() {
        return inputId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order_input_additional.input_id
     *
     * @param inputId the value for order_input_additional.input_id
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setInputId(Integer inputId) {
        this.inputId = inputId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order_input_additional.my_company_color
     *
     * @return the value of order_input_additional.my_company_color
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public String getMyCompanyColor() {
        return myCompanyColor;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order_input_additional.my_company_color
     *
     * @param myCompanyColor the value for order_input_additional.my_company_color
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setMyCompanyColor(String myCompanyColor) {
        this.myCompanyColor = myCompanyColor;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order_input_additional.num
     *
     * @return the value of order_input_additional.num
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public Integer getNum() {
        return num;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order_input_additional.num
     *
     * @param num the value for order_input_additional.num
     *
     * @mbggenerated Sun Mar 01 06:50:08 CST 2015
     */
    public void setNum(Integer num) {
        this.num = num;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }
}