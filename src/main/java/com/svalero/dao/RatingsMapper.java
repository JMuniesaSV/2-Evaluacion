package com.svalero.dao;

import com.svalero.domain.Rating;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class RatingsMapper implements RowMapper<Rating> {

    @Override
    public Rating map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Rating(
                rs.getInt("idRating"),
                rs.getInt("idUser"),
                rs.getInt("idMovie"),
                rs.getInt("rating"),
                rs.getString("review")
        );
    }
}
