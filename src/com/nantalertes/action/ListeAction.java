package com.nantalertes.action;

import java.util.List;
import com.nantalertes.bean.Alerte;
import com.nantalertes.dao.AlerteDAO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * Action Struts pour lister les alertes
 * @author alexis
 *
 */
public class ListeAction extends ActionSupport {
    private List<Alerte> listeAlertes;
    
    //TODO replace by google authentication
    private boolean isAuthenticated = true;
    
    /**
     * Méthode execute
     */
    public String execute() {
 
        if(isAuthenticated)
        {
        	listeAlertes = AlerteDAO.getAllAlertes();
        	
        	
        	System.out.println("Liste Action");
        	System.out.println("Alertes stockées " + listeAlertes.size());

        	return "success";
        }
        else
        {
        	System.out.println("Not authenticated mode");
        	addActionError(getText("error.login"));
            return "error";
        }
    }

	public List<Alerte> getListeAlertes() {
		return listeAlertes;
	}

	public void setListeAlertes(List<Alerte> listeAlertes) {
		this.listeAlertes = listeAlertes;
	}

	public boolean isAuthenticated() {
		return isAuthenticated;
	}

	public void setAuthenticated(boolean isAuthenticated) {
		this.isAuthenticated = isAuthenticated;
	}
}
