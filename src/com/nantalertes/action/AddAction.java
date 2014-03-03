package com.nantalertes.action;

import java.text.DateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserServiceFactory;
import com.nantalertes.bean.Alerte;
import com.nantalertes.dao.AlerteDAO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * Action Struts pour l'ajout d'une alerte
 * 
 * @author alexis
 * 
 */
public class AddAction extends ActionSupport {
	private List<Alerte> listeAlertes;
	private List<String> listeCat = Constants.getListeCategories();

	private String description;
	private String type;
	private String adresse;
	private String latitude;
	private String longitude;
	private User user;

	/**
	 * Méthode execute
	 */
	public String execute() {

		user = UserServiceFactory.getUserService().getCurrentUser();
		listeAlertes = AlerteDAO.getAllAlertes();
		Alerte alerte = new Alerte();

		alerte.setAdresse(adresse);
		alerte.setDate(DateFormat.getDateTimeInstance(DateFormat.SHORT,
				DateFormat.SHORT).format(new Date()));
		alerte.setDescription(description);
		alerte.setLatitude(latitude);
		alerte.setLongitude(longitude);
		alerte.setType(type);
		if (null != user) {
			alerte.setUser(user.toString());
		}

		// Création d'une nouvelle alerte seulement si les champs
		// nécessaires sont remplis
		if (null != description && null != adresse) {
			if (!description.isEmpty() || !adresse.isEmpty()) {
				AlerteDAO.createOrUpdateAlerte(alerte);
				return "stored";
			} else if (description.isEmpty() || adresse.isEmpty()) {
				addActionError("Veuillez renseigner une description et une adresse du problème à signaler");
			}
		}

		System.out.println("Add Action");
		return "success";
	}

	public List<Alerte> getListeAlertes() {
		return listeAlertes;
	}

	public void setListeAlertes(List<Alerte> listeAlertes) {
		this.listeAlertes = listeAlertes;
	}

	public List<String> getListeCat() {
		return this.listeCat;
	}

	public void setListeCat(List<String> listeCat) {
		this.listeCat = listeCat;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAdresse() {
		return adresse;
	}

	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User u) {
		user = u;
	}
}