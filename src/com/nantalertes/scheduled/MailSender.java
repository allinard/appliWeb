package com.nantalertes.scheduled;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.nantalertes.bean.Abonnement;
import com.nantalertes.bean.Alerte;
import com.nantalertes.dao.AbonnementDAO;
import com.nantalertes.dao.AlerteDAO;
import com.nantalertes.dao.LikeDAO;

import javax.mail.*;
import javax.mail.internet.*;

public class MailSender {

	private static final int MIN_LIKE_FOR_CREDIBILITY = 5;


	//TODO cron ou @Scheduled...
	public void sendMails(){
		List<Abonnement> listeAbonnements = AbonnementDAO.getAllAbonnements();
		
		//Pour chaque abonnement
		for(Abonnement abonnement : listeAbonnements){
			
			//on recupere les alertes de l'adresse de l'abonnement
			List<Alerte> listeAlertes = AlerteDAO.getAlerteByAdresse(abonnement.getAdresse());
			
			List<Alerte> finalListeAlertes = new ArrayList<Alerte>();
			
			//on s'assure que l'alerte est crédible
			for(Alerte alerte : listeAlertes){
				if(LikeDAO.getLikesByAlerteId(alerte.getId()).size() > MIN_LIKE_FOR_CREDIBILITY){
					finalListeAlertes.add(alerte);
				}
			}
					
			//on envoie le mail
			buildMail(abonnement.getAdresse(),abonnement.getUser(),finalListeAlertes);
		}
		
	}
	
	
	private void buildMail(String adresse, String destinataire, List<Alerte> listeAlertes){
	      // Sender's email ID needs to be mentioned
	      String from = "no-reply@nantalertes.com";

	      // Assuming you are sending email from localhost
	      String host = "localhost";

	      // Get system properties
	      Properties properties = System.getProperties();

	      // Setup mail server
	      properties.setProperty("mail.smtp.host", host);

	      // Get the default Session object.
	      Session session = Session.getDefaultInstance(properties);

	      try{
	         // Create a default MimeMessage object.
	         MimeMessage message = new MimeMessage(session);

	         // Set From: header field of the header.
	         message.setFrom(new InternetAddress(from));

	         // Set To: header field of the header.
	         message.addRecipient(Message.RecipientType.TO,
	                                  new InternetAddress(destinataire));

	         // Set Subject: header field
	         message.setSubject("[nantalertes] Notifications dans le secteur "+adresse);

	         String mailContent = "Alertes dans votre secteur :\n\n\n";
	         for(Alerte alerte : listeAlertes){
	        	 mailContent += "Alerte de type "+alerte.getType()+" postée le "+alerte.getDate()+" : \n";
	        	 mailContent += alerte.getDescription()+"\n\n";
	         }
	         mailContent += "Merci pour vos posts !";
	         mailContent += "\n\n\nL'équipe NantAlertes.";
	         
	         // Now set the actual message
	         message.setText(mailContent);

	         // Send message
	         Transport.send(message);
	      }catch (MessagingException mex) {
	         mex.printStackTrace();
	      }
	}
}
