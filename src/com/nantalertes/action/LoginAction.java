package com.nantalertes.action;


import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.FileAttribute;
import java.nio.file.attribute.PosixFilePermission;
import java.nio.file.attribute.PosixFilePermissions;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport {
    private String username;
    private boolean isAuthenticated = true;
    
    public String execute() {
 
        if(isAuthenticated)
        {
        	System.out.println("Authenticated mode");
        	return "success";
        }
        else
        {
        	System.out.println("Not authenticated mode");
        	addActionError(getText("error.login"));
            return "error";
        }
    }
}