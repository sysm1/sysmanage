package com.github.hzw.security.entity;

public class Password {
   
    private int id;

    private String passwd;

    private int num;
    
    public int getId() {
        return id;
    }

    
    public void setId(int id) {
        this.id = id;
    }

    
    public String getPasswd() {
        return passwd;
    }

    
    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }


	public int getNum() {
		return num;
	}


	public void setNum(int num) {
		this.num = num;
	}


	@Override
	public String toString() {
		return "Password [id=" + id + ", passwd=" + passwd + ", num=" + num
				+ "]";
	}
    
    
	
}