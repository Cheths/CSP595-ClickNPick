package com.csp595.utilities;

public class Constants {
	
	public interface Orders{
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
		public static String COUPON_CODE_COL = "coupon_code";
		public static String DISCOUNT_COL = "discount";
		public static String USER_NAME_COL = "user_name";
	}
	
	public interface User{
		public static String ID_COL = "id";
		public static String USERNAME_COL = "username";
		public static String ROLE_COL = "role";
	}
}
