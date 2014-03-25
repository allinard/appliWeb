package com.nantalertes.bean;

public class Abonnement implements Comparable<Abonnement>{
	
	private int id;
	
	
	private String adresse;
	
	
	private String user;


	public Abonnement() {

	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getAdresse() {
		return adresse;
	}


	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}


	public String getUser() {
		return user;
	}


	public void setUser(String user) {
		this.user = user;
	}


	@Override
	public int compareTo(Abonnement arg0) {
		return arg0.getId()-this.getId();
	}

}
