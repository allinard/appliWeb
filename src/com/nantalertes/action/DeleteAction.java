package com.nantalertes.action;

import java.util.List;
import com.nantalertes.bean.Alerte;
import com.nantalertes.dao.AlerteDAO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * Action Struts pour la suppression d'alertes
 * 
 * @author alexis
 * 
 */
public class DeleteAction extends ActionSupport {

	private int alerteId;

	/**
	 * Méthode execute
	 */
	public String execute() {

		AlerteDAO.deleteAlerteWithId(alerteId);

		System.out.println("Delete Action");

		return "success";
	}

	public int getAlerteId() {
		return alerteId;
	}

	public void setAlerteId(int alerteId) {
		this.alerteId = alerteId;
	}
}