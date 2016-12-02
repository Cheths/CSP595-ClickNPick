package com.csp595.utilities;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.csp595.beans.User;

/*
 * Contains helper methods for product functional capabilities. 
 */
public class ProductHelper {

	private static String orderedDate = "";

	/*
	 * Method to get ordered date.
	 */
	public static String getOrderedDate() {
		DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
		Date date = new Date();
		Timestamp timestamp = new Timestamp(date.getTime());
		orderedDate = dateFormat.format(date);
		return timestamp.toString();
	}

	/*
	 * Method to compute expected delivery date.
	 */
	public static String getExpectedDeliveryDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
		Date date = null;
		try {
			if(orderedDate != ""){
				date = (Date) sdf.parse(orderedDate);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Calendar c1 = Calendar.getInstance();
		
		c1.setTime(date);
		c1.add(Calendar.DATE, 10);
		Timestamp timestamp = new Timestamp(c1.getTimeInMillis());
		return timestamp.toString();
	}
	
	/*
	 * Method to generate order id for a product.
	 */
	public static String generateProductOrderId(Date orderDate) throws NoSuchAlgorithmException {
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        String datestring = df.format(orderDate).toString();
        String hash = generateHashValue(datestring);//creates SHA1 hash of 16 digits
        int datestringlen = datestring.length();
        String ordernum = datestring+hash.substring(datestringlen,datestringlen+5);
        return ordernum;
    }

	/*
	 * Method to generate Hash value to prepare order id.
	 */
    private static String generateHashValue(String plain) throws NoSuchAlgorithmException {
        final int MD_PASSWORD_LENGTH = 16;
        final String HASH_ALGORITHM = "SHA1";
        String hash = null;
         try {
                MessageDigest md = MessageDigest.getInstance(HASH_ALGORITHM);
                md.update(plain.getBytes());
                BigInteger hashint = new BigInteger(1, md.digest());
                hash = hashint.toString(MD_PASSWORD_LENGTH);
            } catch (NoSuchAlgorithmException nsae) {
                throw(nsae);
            }
        return hash;
    }
    
    /*
     * Method to send confirmation mail on order transaction completion.
     */
    public static void sendOrderConfirmationMail(String mailId, String orderId, String mailBody) {
		Session session = getSessionForMailConfig();
		
		MimeMessage message = new MimeMessage(session);
		try {
			message.setFrom(new InternetAddress("system@ClickNPick.com"));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(mailId));
			message.setSubject("Order Placed Successfully #"+orderId+"");
			message.setText(mailBody);
			
			Transport.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

    /*
     * Helper method to get session for mail configuration
     */
	private static Session getSessionForMailConfig() {
		String fromAddress = "clicknpickapp@gmail.com";
		String host = "smtp.gmail.com";
		String password = "Qwerty@12";
		
		Properties properties = System.getProperties();
		
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.socketFactory.port", "465");
		properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.port", "465");
		
		Session session = Session.getDefaultInstance(properties, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication(fromAddress, password);
			}
		});
		return session;
	}
	
	/*
	 * Method to send password through mail when user forgets password.
	 */
	public static void sendPasswordThroughMail(String mailId){
		Session session = getSessionForMailConfig();
		User user = MySqlUtil.getUserBasedOnMailId(mailId);

		if(user != null){
			MimeMessage message = new MimeMessage(session);
			try {
				StringBuilder mailBody = new StringBuilder();
				mailBody.append("Hi "+user.getFirstName()+",");
				mailBody.append("\nYour Password is "+user.getPassword());

				message.setFrom(new InternetAddress("system@ClickNPick.com"));
				message.setRecipient(Message.RecipientType.TO, new InternetAddress(mailId));
				message.setSubject("Password for your account. ");
				message.setText(mailBody.toString());

				Transport.send(message);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}
	}
}
