package com.github.hzw.security.entity;

import com.github.hzw.util.ExcelDataMapper;

public class SalesmanInfo {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column salesman_info.id
     *
     * @mbggenerated Thu Feb 19 18:47:07 CST 2015
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column salesman_info.code
     *
     * @mbggenerated Thu Feb 19 18:47:07 CST 2015
     */
    // private String code;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column salesman_info.name
     *
     * @mbggenerated Thu Feb 19 18:47:07 CST 2015
     */
    private String name;

    private String mark;

    @ExcelDataMapper(title="id",order=1)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
    
    @ExcelDataMapper(title="业务员名称",order=2)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column salesman_info.mark
     *
     * @return the value of salesman_info.mark
     *
     * @mbggenerated Thu Feb 19 18:47:07 CST 2015
     */
    @ExcelDataMapper(title="备注",order=3)
    public String getMark() {
        return mark;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column salesman_info.mark
     *
     * @param mark the value for salesman_info.mark
     *
     * @mbggenerated Thu Feb 19 18:47:07 CST 2015
     */
    public void setMark(String mark) {
        this.mark = mark;
    }

	@Override
	public String toString() {
		return "SalesmanInfo [id=" + id + ", name=" + name
				+ ", mark=" + mark + "]";
	}
    
    
}