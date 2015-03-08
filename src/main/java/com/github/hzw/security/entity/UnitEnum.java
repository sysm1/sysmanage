package com.github.hzw.security.entity;

public enum UnitEnum {
	
	item("条", 0), 
	kg("公斤", 1), 
	cm("米", 2),  
	yard("码", 3);  
	
	// 成员变量  
    private String name;  
    private int index; 
    
    // 构造方法  
    private UnitEnum(String name, int index) {  
        this.name = name;  
        this.index = index;  
    } 
    
    // 普通方法  
    public static String getName(int index) {  
        for (UnitEnum c : UnitEnum.values()) {  
            if (c.getIndex() == index) {  
                return c.name;  
            }  
        }  
        return null;  
    }

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}  
	
	public static boolean isExist(String v) {
		UnitEnum[] c = UnitEnum.values();
		for(UnitEnum unitEnum : c) {
			if(unitEnum.getName().equals(v)) {
				return true;
			}
		}
		return false;
	}
	
	
	public static void main(String[] args) {
		
		for (UnitEnum c : UnitEnum.values()) {
			System.out.println(c + " : " + c.getName() + " : " + c.getIndex());
			System.out.println(c+"_count");
		}
		// System.out.println("UnitEnum.item.name:"+UnitEnum.item.name);
		// System.out.println("UnitEnum.item:" + UnitEnum.item);
		
		// System.out.println("isExist():" + Category.isExist(null));
		
		System.out.println(UnitEnum.yard.getName());
	}
    
}
