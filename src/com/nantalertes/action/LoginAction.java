package com.nantalertes.action;


import com.opensymphony.xwork2.ActionSupport;


/**
 * Action Struts pour l'authentification
 * @author alexis
 *
 */
public class LoginAction extends ActionSupport {
    private String username;
    
    //TODO replace by google authentication
    private boolean isAuthenticated = true;
    
    
    /**
     * Méthode execute
     */
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

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
}