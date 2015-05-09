package com.github.hzw.security.entity;

import com.github.hzw.util.ExcelDataMapper;

/**
 * 坯布供应商
 * @author wuyb
 *
 */
public class Supplier {
	private Integer id;

    private String name;

    private String pinyin;
    
    private String mark;

    @ExcelDataMapper(title="id",order=1)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @ExcelDataMapper(title="工厂名称",order=2)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    /**
    @ExcelDataMapper(title="工厂编号",order=3)
    public String getCode() {
        return code;
    }
	**/

    @ExcelDataMapper(title="备注",order=5)
    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }

	public String getPinyin() {
		return pinyin;
	}

	public void setPinyin(String pinyin) {
		this.pinyin = pinyin;
	}

	@Override
	public String toString() {
		return "FactoryInfo [id=" + id + ", name=" + name + ", pinyin="
				+ pinyin + ", mark=" + mark + "]";
	}
}
