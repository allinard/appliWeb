package com.nantalertes.action;

import java.util.ArrayList;
import java.util.List;

public class Constants {

	public static List<String> getListeCategories()
	{
		List<String> listeCat = new ArrayList<String>();
		listeCat.add("Arrêt déterioré (Bus/Tram)");
		listeCat.add("Chaussée endommagée");
		listeCat.add("Débris sur la voie");
		listeCat.add("Eclairage public défaillant");
		listeCat.add("Innondation");
		listeCat.add("Problèmes de signalisation");
		listeCat.add("Tags/Graffitis");
		listeCat.add("Autre");
		return listeCat;
	}
	
}
