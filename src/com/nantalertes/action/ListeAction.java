package com.nantalertes.action;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.nantalertes.bean.Alerte;
import com.nantalertes.bean.Like;
import com.nantalertes.dao.AlerteDAO;
import com.nantalertes.dao.LikeDAO;
import com.nantalertes.dao.Util;
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
		//user = new User("al.linardo@gmail.com", "gmail");

		listeAlertes = AlerteDAO.getAllAlertes();
		
		for (Alerte alerte : listeAlertes) {
			
			//TODO revoir pk ÇA ne marche pas ^^
			//List<Like> listeLikes = LikeDAO.getLikesByAlerteId(alerte.getId());
			List<Like> listeLikes = new ArrayList<Like>();
			for(Like like : LikeDAO.getAllLikes()){
				if(like.getAlerteId()==alerte.getId()){
					listeLikes.add(like);
				}
			}
			
			//pour le like count
			alerte.setLikeCount(listeLikes.size());
			
			//par défaut, est likable
			alerte.setLikable(true);
			
			//pour savoir si une alerte peut etre supprimée et likée
			if (null != user) {
				//si l'alerte a été postée par l'utilisateur en cours OU si l'utilisateur en cours est le superuser
				if (alerte.getUser().equals(user.toString())
						|| user.toString().equals(Constants.SUPERUSER)) {
					//on dit que l'alerte peut etre supprimée
					alerte.setRemovable(true);
					//on dit que l'alerte ne peut pas etre likée
					alerte.setLikable(false);
				}
				
				for(Like like : listeLikes){
					if(like.getUser().equals(user.toString())){
						alerte.setLikable(false);
						break;
					}
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
