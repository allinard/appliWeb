package com.nantalertes.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.labs.repackaged.com.google.common.primitives.Ints;
import com.nantalertes.bean.Like;

public class LikeDAO {

	/**
	 * ID de la prochaine alerte
	 */
	public static int NEXTID = nextId();

	/**
	 * Methode permettant de créer ou de mettre a jour un like
	 * @param l'like a creer ou mettre a jour
	 */
	public static void createOrUpdateLike(Like like) {
		Entity storedLike = getEntity(like);
		//create
		if (storedLike == null) {
			storedLike = new Entity("LikeId", NEXTID);
			NEXTID++;
			storedLike.setProperty("LikeUser", like.getUser());
			storedLike.setProperty("LikeAlerteId", like.getAlerteId());
		}
		//update
		else {
			storedLike.setProperty("LikeUser", like.getUser());
			storedLike.setProperty("LikeAlerteId", like.getAlerteId());
		}
		//persist
		Util.persistEntity(storedLike);
	}

	
	
	public static Iterable<Entity> getAllEntities() {
		return Util.listEntities("LikeId", null, null);
	}
	
	public static Iterable<Entity> getByUser(String user) {
		return Util.listEntities("LikeId", "LikeUser", user);
	}
	
	public static Iterable<Entity> getByAlerteId(int alerteId) {
		return Util.listEntities("LikeId", "LikeAlerteId", String.valueOf(alerteId));
	}
	
	public static Entity getEntity(Like like) {
		try {
			Key key = KeyFactory.createKey("LikeId", like.getId());
			return Util.findEntity(key);
		} catch (Exception e) {
			return null;
		}
	}
	
	
	public static String deleteLike(Like like) {
		Key key = KeyFactory.createKey("LikeId", like.getId());
		Util.deleteEntity(key);
		return "Like deleted successfully";
	}
	
	
	public static void deleteLikeWithAlerteId(int alerteId){
		//TODO comprendre pk ça ne marche pas la requete
		//List<Like> likes = getLikesByAlerteId(alerteId);
		List<Like> likes = new ArrayList<Like>();
		for(Like like : LikeDAO.getAllLikes()){
			if(like.getAlerteId()==alerteId){
				likes.add(like);
			}
		}
		for(Like like : likes){
			deleteLike(like);
		}
	}
	
	
	public static Like getLike(Entity e) {
		Like like = new Like();
		like.setId((int) e.getKey().getId());
		like.setAlerteId(Ints.checkedCast((long) e.getProperty("LikeAlerteId")));
		like.setUser((String) e.getProperty("LikeUser"));

		return like;
	}

	

	public static List<Like> getLikesByUser(String user) {
		List<Like> listeLikes = new ArrayList<Like>();
		Set<Like> tempListe = new TreeSet<Like>();
		for (Entity entity : getByUser(user)) {
			tempListe.add(getLike(entity));
		}
		listeLikes.addAll(tempListe);
		return listeLikes;
	}
	
	
	

	public static List<Like> getLikesByAlerteId(int alerteId) {
		List<Like> listeLikes = new ArrayList<Like>();
		Set<Like> tempListe = new TreeSet<Like>();
		for (Entity entity : getByAlerteId(alerteId)) {
			tempListe.add(getLike(entity));
		}
		listeLikes.addAll(tempListe);
		return listeLikes;
	}
	
	
	
	public static List<Like> getAllLikes() {
		List<Like> listeLikes = new ArrayList<Like>();
		Set<Like> tempListe = new TreeSet<Like>();
		for (Entity entity : getAllEntities()) {
			tempListe.add(getLike(entity));
		}
		listeLikes.addAll(tempListe);
		return listeLikes;
	}
	


	public static String deleteLikeWithId(int likeId) {
		Key key = KeyFactory.createKey("LikeId", likeId);
		Util.deleteEntity(key);
		return "Alert deleted successfully";		
	}
	
	
	public static int nextId()
	{
		List<Like> listeLikes = getAllLikes();
		int plusGrand = 0;
		
		for(Like like : listeLikes)
		{
			if(like.getId()>plusGrand){
				plusGrand=like.getId();
			}
		}
		
		return plusGrand+1;
	}
	
}
