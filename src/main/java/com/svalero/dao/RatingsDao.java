package com.svalero.dao;

import com.svalero.domain.Rating;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface RatingsDao {

    @SqlQuery("SELECT * FROM Ratings")
    @UseRowMapper(RatingsMapper.class)
    List<Rating> getAllRatings();

    @SqlQuery("SELECT * FROM Ratings WHERE idRating = :idRating")
    @UseRowMapper(RatingsMapper.class)
    Rating getRating(@Bind("idRating") int idRating);

    @SqlUpdate("INSERT INTO Ratings (idUser, idMovie, rating, review) VALUES (:idUser, :idMovie, :rating, :review)")
    int addRating(@Bind("idUser") int idUser, @Bind("idMovie") int idMovie, @Bind("rating") int rating, @Bind("review") String review);

    @SqlUpdate("UPDATE Ratings SET rating = :rating, review = :review WHERE idRating = :idRating")
    void updateRating(@Bind("idRating") int idRating, @Bind("rating") int rating, @Bind("review") String review);

    @SqlUpdate("DELETE FROM Ratings WHERE idRating = :idRating")
    void removeRating(@Bind("idRating") int idRating);

    @SqlQuery("SELECT * FROM Ratings WHERE rating LIKE '%' || :filtro || '%' OR review LIKE '%' || :filtro || '%'")
    @UseRowMapper(RatingsMapper.class)
    List<Rating> getRatingsByFilter(@Bind("filtro") String filtro);

}
