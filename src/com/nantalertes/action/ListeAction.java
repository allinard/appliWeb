package com.nantalertes.action;

import java.util.List;
import com.nantalertes.bean.Alerte;
import com.nantalertes.dao.AlerteDAO;
import com.opensymphony.xwork2.ActionSupport;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserServiceFactory;

/**
 * Action Struts pour lister les alertes
 * 
 * @author alexis
 * 
 */
public class ListeAction extends ActionSupport {
	private List<Alerte> listeAlertes;

	private User user;

	/**
	 * Méthode execute
	 */
	public String execute() {
		user = UserServiceFactory.getUserService().getCurrentUser();

		listeAlertes = AlerteDAO.getAllAlertes();

		//pour savoir si une alerte peut etre supprimée
		for (Alerte alerte : listeAlertes) {
			if (null != user) {
				//si l'alerte a été postée par l'utilisateur en cours OU si l'utilisateur en cours est le superuser
				if (alerte.getUser().equals(user.toString())
						|| user.toString().equals(Constants.SUPERUSER)) {
					//on dit que l'alerte peut etre supprimée
					alerte.setRemovable(true);
				}
			}
		}

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
