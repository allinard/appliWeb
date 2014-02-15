package com.nantalertes.action;

import java.util.List;
import com.nantalertes.bean.Alerte;
import com.nantalertes.dao.AlerteDAO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * Action Struts pour la suppression d'alertes
 * @author alexis
 *
 */
public class DeleteAction extends ActionSupport {
    
    //TODO replace by google authentication
    private boolean isAuthenticated = true;
    
    private int alerteId;
    
    /**
     * Méthode execute
     */
    public String execute() {
 
        if(isAuthenticated)
        {
        	AlerteDAO.deleteAlerteWithId(alerteId);
        	
        	
        	System.out.println("Delete Action");

        	return "success";
        }
        else
        {
        	System.out.println("Not authenticated mode");
        	addActionError(getText("error.login"));
            return "error";
        }
    }


	public boolean isAuthenticated() {
		return isAuthenticated;
	}

	public void setAuthenticated(boolean isAuthenticated) {
		this.isAuthenticated = isAuthenticated;
	}


	public int getAlerteId() {
		return alerteId;
	}


	public void setAlerteId(int alerteId) {
		this.alerteId = alerteId;
	}
}