package com.nantalertes.action;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserServiceFactory;
import com.nantalertes.bean.Like;
import com.nantalertes.dao.LikeDAO;
import com.opensymphony.xwork2.ActionSupport;

public class LikeAction extends ActionSupport  {

	private User user;
	
	private int alerteId;
	
	private String forward;

	/**
	 * Méthode execute
	 */
	public String execute() {
		user = UserServiceFactory.getUserService().getCurrentUser();
		//user = new User("al.linardo@gmail.com", "gmail");

		
		Like like = new Like();
		like.setAlerteId(alerteId);
		like.setUser(user.toString());
		LikeDAO.createOrUpdateLike(like);

		return forward;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User u) {
		user = u;
	}

	public int getAlerteId() {
		return alerteId;
	}

	public void setAlerteId(int alerteId) {
		this.alerteId = alerteId;
	}

	public String getForward() {
		return forward;
	}

	public void setForward(String forward) {
		this.forward = forward;
	}
}
