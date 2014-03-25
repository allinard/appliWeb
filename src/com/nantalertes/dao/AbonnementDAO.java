package com.nantalertes.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.nantalertes.bean.Abonnement;

public class AbonnementDAO {

	
	/**
	 * ID de la prochaine alerte
	 */
	public static int NEXTID = nextId();

	/**
	 * Methode permettant de créer ou de mettre a jour un abonnement
	 * @param l'abonnement a creer ou mettre a jour
	 */
	public static void createOrUpdateAbonnement(Abonnement abonnement) {
		Entity storedAbonnement = getEntity(abonnement);
		//create
		if (storedAbonnement == null) {
			storedAbonnement = new Entity("AbonnementId", NEXTID);
			NEXTID++;
			storedAbonnement.setProperty("AbonnementUser", abonnement.getUser());
			storedAbonnement.setProperty("AbonnementAdresse", abonnement.getAdresse());
		}
		//update
		else {
			storedAbonnement.setProperty("AbonnementUser", abonnement.getUser());
			storedAbonnement.setProperty("AbonnementAdresse", abonnement.getAdresse());
		}
		//persist
		Util.persistEntity(storedAbonnement);
	}

	
	
	public static Iterable<Entity> getAllEntities() {
		return Util.listEntities("AbonnementId", null, null);
	}
	
	public static Iterable<Entity> getByAdresse(String adresse) {
		return Util.listEntities("AbonnementId", "AbonnementAdresse", adresse);
	}
	
	public static Iterable<Entity> getByUser(String user) {
		return Util.listEntities("AbonnementId", "AbonnementUser", user);
	}
	
	public static Entity getEntity(Abonnement abonnement) {
		try {
			Key key = KeyFactory.createKey("AbonnementId", abonnement.getId());
			return Util.findEntity(key);
		} catch (Exception e) {
			return null;
		}
	}
	
	
	public static String deleteAbonnement(Abonnement abonnement) {
		Key key = KeyFactory.createKey("AbonnementId", abonnement.getId());
		Util.deleteEntity(key);
		return "Abonnement deleted successfully";
	}
	
	
	public static Abonnement getAbonnement(Entity e) {
		Abonnement abonnement = new Abonnement();
		abonnement.setId((int) e.getKey().getId());
		abonnement.setAdresse((String) e.getProperty("AbonnementAdresse"));
		abonnement.setUser((String) e.getProperty("AbonnementUser"));

		return abonnement;
	}

	

	public static List<Abonnement> getAbonnementsByUser(String user) {
		List<Abonnement> listeAbonnements = new ArrayList<Abonnement>();
		Set<Abonnement> tempListe = new TreeSet<Abonnement>();
		for (Entity entity : getByUser(user)) {
			tempListe.add(getAbonnement(entity));
		}
		listeAbonnements.addAll(tempListe);
		return listeAbonnements;
	}
	
	
	

	public static List<Abonnement> getAbonnementsByAdresse(String adresse) {
		List<Abonnement> listeAbonnements = new ArrayList<Abonnement>();
		Set<Abonnement> tempListe = new TreeSet<Abonnement>();
		for (Entity entity : getByAdresse(adresse)) {
			tempListe.add(getAbonnement(entity));
		}
		listeAbonnements.addAll(tempListe);
		return listeAbonnements;
	}
	
	
	
	public static List<Abonnement> getAllAbonnements() {
		List<Abonnement> listeAbonnements = new ArrayList<Abonnement>();
		Set<Abonnement> tempListe = new TreeSet<Abonnement>();
		for (Entity entity : getAllEntities()) {
			tempListe.add(getAbonnement(entity));
		}
		listeAbonnements.addAll(tempListe);
		return listeAbonnements;
	}
	


	public static String deleteAbonnementWithId(int abonnementId) {
		Key key = KeyFactory.createKey("AbonnementId", abonnementId);
		Util.deleteEntity(key);
		return "Alert deleted successfully";		
	}
	
	
	public static int nextId()
	{
		List<Abonnement> listeAbonnements = getAllAbonnements();
		int plusGrand = 0;
		
		for(Abonnement abonnement : listeAbonnements)
		{
			if(abonnement.getId()>plusGrand){
				plusGrand=abonnement.getId();
			}
		}
		
		return plusGrand+1;
	}
	
}
