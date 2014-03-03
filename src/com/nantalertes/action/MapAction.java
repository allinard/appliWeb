package com.nantalertes.action;

import java.util.List;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserServiceFactory;
import com.nantalertes.bean.Alerte;
import com.nantalertes.dao.AlerteDAO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * Action Struts pour l'écran principal
 * 
 * @author alexis
 * 
 */
public class MapAction extends ActionSupport {
	private List<Alerte> listeAlertes;

	private User user;

	/**
	 * Méthode execute
	 */
	public String execute() {

		user = UserServiceFactory.getUserService().getCurrentUser();

		listeAlertes = AlerteDAO.getLastAlertes();

		return "success";
	}

	public List<Alerte> getListeAlertes() {
		return listeAlertes;
	}

	public void setListeAlertes(List<Alerte> listeAlertes) {
		this.listeAlertes = listeAlertes;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User u) {
		user = u;
	}
}
