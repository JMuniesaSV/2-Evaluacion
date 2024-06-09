package com.svalero.util;

public class Constants {

    public static final String DATABASE = "VIDEOCLUB";
    public static final String USERNAME = "videoclub";
    public static final String PASSWORD = "videoclub";


    public static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
    public static final String CONNECTION_STRING = "jdbc:oracle:thin:@//localhost:1521/xepdb1";

    public static final String DATE_PATTERN;

    static {
        DATE_PATTERN = "yyyy-MM-dd";
    }
}
