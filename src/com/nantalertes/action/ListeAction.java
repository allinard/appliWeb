package com.nantalertes.action;

import java.util.List;
import com.nantalertes.bean.Alerte;
import com.nantalertes.dao.AlerteDAO;
import com.opensymphony.xwork2.ActionSupport;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserServiceFactory;

/**
 * Action Struts pour lister les alertes
 * @author alexis
 *
 */
public class ListeAction extends ActionSupport {
    private List<Alerte> listeAlertes;
    
    //TODO replace by google authentication
    private boolean isAuthenticated = true;
    private User user;
    
    /**
     * Méthode execute
     */
    public String execute() {
    	user = UserServiceFactory.getUserService().getCurrentUser();
 
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
	
	public User getUser(){
		return user;
	}
	
	public void setUser(User u){
		user = u;
	}
}
