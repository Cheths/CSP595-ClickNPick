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

public class ProductHelper {

	private static String orderedDate = "";

	public static String getOrderedDate() {
		DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
		Date date = new Date();
		Timestamp timestamp = new Timestamp(date.getTime());
		orderedDate = dateFormat.format(date);
		return timestamp.toString();
	}

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
	
	public static String generateProductOrderId(Date orderDate) throws NoSuchAlgorithmException {
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        String datestring = df.format(orderDate).toString();
        String hash = generateHashValue(datestring);//creates SHA1 hash of 16 digits
        int datestringlen = datestring.length();
        String ordernum = datestring+hash.substring(datestringlen,datestringlen+5);
        return ordernum;
    }

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
}
