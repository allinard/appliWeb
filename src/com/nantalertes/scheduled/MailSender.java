package com.nantalertes.scheduled;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.nantalertes.bean.Abonnement;
import com.nantalertes.bean.Alerte;
import com.nantalertes.bean.Like;
import com.nantalertes.dao.AbonnementDAO;
import com.nantalertes.dao.AlerteDAO;
import com.nantalertes.dao.LikeDAO;
import com.opensymphony.xwork2.ActionSupport;

import javax.mail.*;
import javax.mail.internet.*;

public class MailSender extends ActionSupport {

	private static final int MIN_LIKE_FOR_CREDIBILITY = -1;

	public String execute() {
		List<Abonnement> listeAbonnements = AbonnementDAO.getAllAbonnements();

		List<MimeMessage> listeMails = new ArrayList<MimeMessage>();

		// Pour chaque abonnement
		for (Abonnement abonnement : listeAbonnements) {

			// on recupere les alertes de l'adresse de l'abonnement
			List<Alerte> listeAlertes = AlerteDAO.getAlerteByAdresse(abonnement
					.getAdresse());

			List<Alerte> finalListeAlertes = new ArrayList<Alerte>();

			// on s'assure que l'alerte est crédible
			for (Alerte alerte : listeAlertes) {
				List<Like> listeLikes = new ArrayList<Like>();
				for (Like like : LikeDAO.getAllLikes()) {
					if (like.getAlerteId() == alerte.getId()) {
						listeLikes.add(like);
					}
				}
				if (listeLikes.size() > MIN_LIKE_FOR_CREDIBILITY) {
					finalListeAlertes.add(alerte);
				}
			}

			// on builde le mail
			if (!finalListeAlertes.isEmpty()) {
				try {
					listeMails.add(buildMail(abonnement.getAdresse(),
							abonnement.getUser(), finalListeAlertes));
				} catch (MessagingException e) {
					e.printStackTrace();
				}
			}
		}

		int compteur = 0;
		for (int i = 0; i < listeMails.size(); i++) {
			try {
				Transport.send(listeMails.get(i));
				compteur++;
				if (compteur > 5) {
					Thread.sleep(70000);
					compteur = 0;
				}

			} catch (MessagingException e1) {
				e1.printStackTrace();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

		return "success";
	}

	private static MimeMessage buildMail(String adresse, String destinataire,
			List<Alerte> listeAlertes) throws AddressException,
			MessagingException {
		// Sender's email ID needs to be mentioned
		String from = "al.linard@gmail.com";

		Properties props = new Properties();

		Session session = Session.getDefaultInstance(props, null);

		// Create a default MimeMessage object.
		MimeMessage message = new MimeMessage(session);

		// Set From: header field of the header.
		message.setFrom(new InternetAddress(from));

		// Set To: header field of the header.
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(
				destinataire));

		// Set Subject: header field
		message.setSubject("[nantalertes] Notifications dans le secteur "
				+ adresse);

		String mailContent = "Alertes dans votre secteur :\n\n\n";
		for (Alerte alerte : listeAlertes) {
			mailContent += "Alerte de type " + alerte.getType() + " postée le "
					+ alerte.getDate() + " : \n";
			mailContent += alerte.getDescription() + "\n\n";
		}
		mailContent += "Merci pour vos posts !";
		mailContent += "\n\n\nL'équipe NantAlertes.";

		// Now set the actual message
		message.setText(mailContent);

		return message;
	}
}
