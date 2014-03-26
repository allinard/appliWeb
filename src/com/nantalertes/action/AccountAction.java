package com.nantalertes.action;

import java.util.List;

import com.nantalertes.bean.Abonnement;
import com.nantalertes.dao.AbonnementDAO;
import com.opensymphony.xwork2.ActionSupport;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserServiceFactory;

/**
 * Action Struts pour la gestion du compte
 * 
 * @author carl
 * 
 */
public class AccountAction extends ActionSupport {
	private User user;

	private List<Abonnement> listeAbonnements;

	private String adresse;
	
	private int abonnementId;

	/**
	 * Méthode execute
	 */
	public String execute() {

		user = UserServiceFactory.getUserService().getCurrentUser();

		if (null != adresse) {
			if (!adresse.isEmpty()) {
				Abonnement abonnement = new Abonnement();
				abonnement.setAdresse(adresse);
				abonnement.setUser(user.toString());
				AbonnementDAO.createOrUpdateAbonnement(abonnement);
			}
		}
		
		if(0 != abonnementId){
			AbonnementDAO.deleteAbonnementWithId(abonnementId);
		}
		
		
		setListeAbonnements(AbonnementDAO.getAbonnementsByUser(user.toString()));

		try {
			Thread.sleep(250);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		return "success";
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Abonnement> getListeAbonnements() {
		return listeAbonnements;
	}

	public void setListeAbonnements(List<Abonnement> listeAbonnements) {
		this.listeAbonnements = listeAbonnements;
	}

	public String getAdresse() {
		return adresse;
	}

	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}

	public int getAbonnementId() {
		return abonnementId;
	}

	public void setAbonnementId(int abonnementId) {
		this.abonnementId = abonnementId;
	}
}