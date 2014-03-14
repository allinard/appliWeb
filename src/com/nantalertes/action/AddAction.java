package com.nantalertes.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

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
	private String image;
	private User user;

	/**
	 * Méthode execute
	 */
	public String execute() {

		// user = new User("al.linard@gmail.com", "gmail");
		user = UserServiceFactory.getUserService().getCurrentUser();

		listeAlertes = AlerteDAO.getAllAlertes();
		Alerte alerte = new Alerte();

		alerte.setAdresse(adresse);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("'le' dd MMMM yyyy 'à' HH'h'mm", Locale.FRENCH);
		alerte.setDate(simpleDateFormat.format(new Date()));
		alerte.setDescription(description);
		alerte.setLatitude(latitude);
		alerte.setLongitude(longitude);
		alerte.setType(type);
		if (null != user) {
			alerte.setUser(user.toString());
		}

		// Pour l'image
		if (null != image) {
			if (!image.isEmpty()) {
				// BlobstoreService blobstoreService =
				// BlobstoreServiceFactory.getBlobstoreService();
				//
				// String cleFichierUploade =
				// blobstoreService.createGsBlobKey("/gs/"+image).getKeyString();
				//
				// alerte.setImage(cleFichierUploade);
			}
		}

		// Création d'une nouvelle alerte seulement si les champs
		// nécessaires sont remplis
		if (null != latitude && null != longitude) {
			if (!latitude.isEmpty() || !longitude.isEmpty()) {
				AlerteDAO.createOrUpdateAlerte(alerte);
				return "stored";
			} else if (latitude.isEmpty() || longitude.isEmpty()) {
				addActionError("Veuillez localiser votre alerte en cliquant sur la carte !");
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

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
}