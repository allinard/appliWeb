package com.mkyong.user.action;

public class LoginAction {
    private String username;
    private String password;
 
    public String execute() {
 
        if ("admin".equals(this.username)
                && "admin123".equals(this.password)){
            return "success";
        } else {
        	System.out.println("coucou");
            return "error";
        }
    }
 
    public String getUsername() {
        return username;
    }
 
    public void setUsername(String username) {
        this.username = username;
    }
 
    public String getPassword() {
        return password;
    }
 
    public void setPassword(String password) {
        this.password = password;
    }
}