package com.nantalertes.bean;

/**
 * Bean représentant une Alerte
 * 
 * @author alexis
 * 
 */
public class Alerte implements Comparable<Alerte> {

	/**
	 * Description de l'alerte
	 */
	private String description;

	/**
	 * Type de l'alerte (bus, panneau, dechets...)
	 */
	private String type;

	/**
	 * Adresse de l'alerte
	 */
	private String adresse;

	/**
	 * Latitude de l'alerte
	 */
	private String latitude;

	/**
	 * Longitude de l'alerte
	 */
	private String longitude;

	/**
	 * Date de l'alerte
	 */
	private String date;

	/**
	 * Utilisateur ayant posté l'alerte
	 */
	private String user;

	/**
	 * ID de l'alerte
	 */
	private int id;

	/**
	 * Flag si une alerte peut être supprimée ou non
	 */
	private boolean removable;

	/**
	 * key de l'image uploadée
	 */
	private String image;

	/**
	 * Count of Likes
	 */
	private int likeCount;

	/**
	 * Say if a user can like the alert
	 */
	private boolean likable;

	/**
	 * Constructeur de l'alerte
	 */
	public Alerte() {
		this.likeCount=-1;
	}

	/**
	 * Description de l'alerte
	 * 
	 * @return la description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * Description de l'alerte
	 * 
	 * @param description
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * Type de l'alerte
	 * 
	 * @return le type
	 */
	public String getType() {
		return type;
	}

	/**
	 * Type de l'alerte
	 * 
	 * @param type
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * Adresse de l'alerte
	 * 
	 * @return l'adresse
	 */
	public String getAdresse() {
		return adresse;
	}

	/**
	 * Adresse de l'alerte
	 * 
	 * @param adresse
	 */
	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}

	/**
	 * Latitude de l'alerte
	 * 
	 * @return la latitude
	 */
	public String getLatitude() {
		return latitude;
	}

	/**
	 * Latitude de l'alerte
	 * 
	 * @param latitude
	 */
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	/**
	 * Longitude de l'alerte
	 * 
	 * @return longitude
	 */
	public String getLongitude() {
		return longitude;
	}

	/**
	 * Longitude de l'alerte
	 * 
	 * @param longitude
	 */
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	/**
	 * Date de l'alerte
	 * 
	 * @return la date
	 */
	public String getDate() {
		return date;
	}

	/**
	 * Date de l'alerte
	 * 
	 * @param date
	 */
	public void setDate(String date) {
		this.date = date;
	}

	/**
	 * Utilisateur ayant posté l'alerte
	 * 
	 * @return l'utilisateur
	 */
	public String getUser() {
		return user;
	}

	/**
	 * Utilisateur de l'alerte
	 * 
	 * @param user
	 */
	public void setUser(String user) {
		this.user = user;
	}

	/**
	 * ID de l'alerte
	 * 
	 * @return id
	 */
	public int getId() {
		return id;
	}

	/**
	 * Id de l'alerte
	 * 
	 * @param id
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * Comparaison d'alertes
	 */
	@Override
	public int compareTo(Alerte o) {
		if (-1 != likeCount) {
			return o.getLikeCount() - this.getLikeCount();
		} else {
			return o.getId() - this.getId();
		}
	}

	public boolean isRemovable() {
		return removable;
	}

	public void setRemovable(boolean removable) {
		this.removable = removable;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public boolean isLikable() {
		return likable;
	}

	public void setLikable(boolean likable) {
		this.likable = likable;
	}

}
