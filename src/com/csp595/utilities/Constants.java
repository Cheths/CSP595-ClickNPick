package com.csp595.utilities;

/*
 * Constants used across the application are declared here.
 */
public class Constants {
	
	static final String ROLE_CUSTOMER = "Customer";
	static final String ROLE_SALESMAN = "Salesman";
	static final String ROLE_STORE_MANAGER = "Store Manager";
	
	public interface Product{
		static final String PRODUCTTABLE = "PRODUCT";
		static final String ID_COL = "id";
		static final String GEN_COL = "gender";
		static final String CAT_COL = "category";
		static final String DESC_COL = "description";
		static final String TYPE_COL = "type";
		static final String NAME_COL = "name";
		static final String COND_COL = "condition";
		static final String MFG_COL = "manufacturer";
		static final String IMAGE_COL = "image";
		static final String DISCOUNT_COL = "discount";
		static final String PRICE_COL = "price";
	}
	
	public interface Orders{
		static final String ORDERTABLE = "ORDERS";
		public static String ID_COL = "id";
		public static String FK_PROD_ID_COL = "fk_product_ids";
		public static String FK_USER_NAME_COL = "fk_user_name";
		public static String SHIP_ADDR_2_COL = "shipping_address_1";
		public static String SHIP_ADDR_1_COL = "shipping_address_2";
		public static String CITY_COL = "city";
		public static String STATE_COL = "state";
		public static String ZIP_COL = "zip";
		public static String COUNTRY_COL = "country";
		public static String PHONE_COL = "phone";
		public static String ORDER_DT_COL = "order_date";
		public static String EXP_DEL_DT_COL = "expected_delivery_date";
		public static String CARD_NO_COL = "card_number";
		public static String CARD_EXP_DT_COL = "card_expiry_date";
		public static String CVV_COL = "CVV";
		public static String NAME_ON_CARD_COL = "name_on_card";
		public static String ORDER_AMT_COL = "order_amount";
	}

	public interface Coupon{
		static final String COUPONTABLE = "COUPONS";
		public static String COUPON_CODE_COL = "coupon_code";
		public static String DISCOUNT_COL = "discount";
		public static String USER_NAME_COL = "user_name";
	}
	
	public interface User{
		static final String USERTABLE = "USER";
		static final String FIRST_NAME = "first_name";
		public static String ID_COL = "id";
		public static String USERNAME_COL = "username";
		public static String ROLE_COL = "role";
		public static String PWD_COL = "password";
		public static String MAIL_ID_COL = "email_id";
	}
	
	public static String TOMCAT_HOME = System.getProperty("catalina.home").replace("\\", "/");
}
