package com.svalero.dao;

import com.svalero.util.Constants;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

public class Database {
    public static Jdbi jdbi = null;

    public static Jdbi getInstance() throws ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        if (jdbi == null) {
            jdbi = Jdbi.create(Constants.CONNECTION_STRING, Constants.USERNAME, Constants.PASSWORD);
            jdbi.installPlugin(new SqlObjectPlugin());
        }
        return jdbi;
    }
}