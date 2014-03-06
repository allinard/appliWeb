package com.nantalertes.dao;

import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.nantalertes.bean.Alerte;

/**
 * Classe AlerteDAO pour la persistance des alertes
 * @author alexis
 *
 */
public class AlerteDAO {

	/**
	 * ID de la prochaine alerte
	 */
	public static int NEXTID = 1;

	/**
	 * Methode permettant de créer ou de mettre a jour une alerte
	 * @param l'alerte a creer ou mettre a jour
	 */
	public static void createOrUpdateAlerte(Alerte alerte) {
		Entity storedAlerte = getEntity(alerte);
		//create
		if (storedAlerte == null) {
			storedAlerte = new Entity("AlerteId", NEXTID);
			NEXTID++;
			storedAlerte.setProperty("AlerteDescription",
					alerte.getDescription().replaceAll("\'", " "));
			storedAlerte.setProperty("AlerteType", alerte.getType());
			storedAlerte.setProperty("AlerteAdresse", alerte.getAdresse().replaceAll("\'", " "));
			storedAlerte.setProperty("AlerteLatitude", alerte.getLatitude());
			storedAlerte.setProperty("AlerteLongitude", alerte.getLongitude());
			storedAlerte.setProperty("AlerteDate", alerte.getDate());
			storedAlerte.setProperty("AlerteUser", alerte.getUser());
			storedAlerte.setProperty("AlerteImage", alerte.getImage());
		}
		//update
		else {
			storedAlerte.setProperty("AlerteDescription",
					alerte.getDescription().replaceAll("\'", " "));
			storedAlerte.setProperty("AlerteType", alerte.getType());
			storedAlerte.setProperty("AlerteAdresse", alerte.getAdresse().replaceAll("\'", " "));
			storedAlerte.setProperty("AlerteLatitude", alerte.getLatitude());
			storedAlerte.setProperty("AlerteLongitude", alerte.getLongitude());
			storedAlerte.setProperty("AlerteDate", alerte.getDate());
			storedAlerte.setProperty("AlerteUser", alerte.getUser());
			storedAlerte.setProperty("AlerteImage", alerte.getImage());
		}
		//persist
		Util.persistEntity(storedAlerte);
	}

	/**
	 * Retrun all the products
	 * 
	 * @param kind
	 *            : of kind product
	 * @return products
	 */
	public static Iterable<Entity> getAllEntities() {
		return Util.listEntities("AlerteId", null, null);
	}

	/**
	 * Get product entity
	 * 
	 * @param name
	 *            : name of the product
	 * @return: product entity
	 */
	public static Entity getEntity(Alerte alerte) {
		try {
			Key key = KeyFactory.createKey("AlerteId", alerte.getId());
			return Util.findEntity(key);
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * Delete product entity
	 * 
	 * @param productKey
	 *            : product to be deleted
	 * @return status string
	 */
	public static String deleteAlerte(Alerte alerte) {
		Key key = KeyFactory.createKey("AlerteId", alerte.getId());
		Util.deleteEntity(key);
		BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
		blobstoreService.delete(new BlobKey(alerte.getImage()));
		return "Alert deleted successfully";
	}

	public static Alerte getAlerte(Entity e) {
		Alerte alerte = new Alerte();
		alerte.setId((int) e.getKey().getId());
		alerte.setDescription((String) e.getProperty("AlerteDescription"));
		alerte.setType((String) e.getProperty("AlerteType"));
		alerte.setAdresse((String) e.getProperty("AlerteAdresse"));
		alerte.setLatitude((String) e.getProperty("AlerteLatitude"));
		alerte.setLongitude((String) e.getProperty("AlerteLongitude"));
		alerte.setDate((String) e.getProperty("AlerteDate"));
		alerte.setUser((String) e.getProperty("AlerteUser"));
		alerte.setImage((String) e.getProperty("AlerteImage"));

		return alerte;
	}

	/**
	 * Methode retournant la liste de toutes les alertes en cours
	 * @return la liste de toutes les alertes en cours
	 */
	public static List<Alerte> getAllAlertes() {
		List<Alerte> listeAlerte = new ArrayList<Alerte>();
		Set<Alerte> tempListe = new TreeSet<Alerte>();
		for (Entity entity : getAllEntities()) {
			tempListe.add(getAlerte(entity));
		}
		listeAlerte.addAll(tempListe);
		return listeAlerte;
	}
	
	/**
	 * Méthode retournant les X dernières alertes postées
	 * @return les X dernières alertes postées
	 */
	public static List<Alerte> getLastAlertes() {
		List<Alerte> listeAlerte = new ArrayList<Alerte>();
		Set<Alerte> tempListe = new TreeSet<Alerte>();
		int i=0;
		for (Entity entity : getAllEntities()) {
			tempListe.add(getAlerte(entity));
			i++;
			if(i>5) break;
		}
		listeAlerte.addAll(tempListe);
		return listeAlerte;
	}

	/**
	 * Méthode pour la suppression d'une alerte
	 * @param alerteId l'ID de l'alerte a supprimer
	 * @return Success ou non
	 */
	public static String deleteAlerteWithId(int alerteId) {
		Key key = KeyFactory.createKey("AlerteId", alerteId);
		Util.deleteEntity(key);
		return "Alert deleted successfully";		
	}

}