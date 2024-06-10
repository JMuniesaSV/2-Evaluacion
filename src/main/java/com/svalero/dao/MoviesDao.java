package com.svalero.dao;

import com.svalero.domain.Movie;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface MoviesDao {

    @SqlQuery("SELECT * FROM Movies")
    @UseRowMapper(MoviesMapper.class)
    List<Movie> getAllMovies();

    @SqlQuery("SELECT * FROM MOVIES WHERE idMovie = ?")
    @UseRowMapper(MoviesMapper.class)
    Movie getMovie(int idMovie);

    @SqlQuery("SELECT * FROM MOVIES WHERE title LIKE '%' || :searchTerm || '%' OR director LIKE '%' || :searchTerm || '%'")
    @UseRowMapper(MoviesMapper.class)
    List<Movie> getMoviesByFilter(@Bind("searchTerm") String searchTerm);

    @SqlUpdate("DELETE FROM RESERVATIONS WHERE idMovie = :idMovie")
    void deleteReservationsByMovieId(@Bind("idMovie") int idMovie);


    @SqlUpdate("INSERT INTO MOVIES (title, director, synopsis, trailer, quantity, path) VALUES (:title, :director, :synopsis, :trailer, :quantity, :path)")
    int addMovie(@Bind("title") String title, @Bind("director") String director, @Bind("synopsis") String synopsis, @Bind("trailer") String trailer, @Bind("quantity") int quantity, @Bind("path") String path);

    @SqlUpdate("UPDATE MOVIES SET title = :title, director = :director, synopsis = :synopsis, trailer = :trailer, quantity = :quantity, path = :path WHERE idMovie = :idMovie")
    int updateMovie(@Bind("idMovie") int idMovie, @Bind("title") String title, @Bind("director") String director, @Bind("synopsis") String synopsis, @Bind("trailer") String trailer, @Bind("quantity") int quantity, @Bind("path") String path);

    @SqlUpdate("DELETE FROM MOVIES WHERE idMovie = :idMovie")
    int removeMovie(@Bind("idMovie") int idMovie);

    @SqlQuery("SELECT (SELECT quantity FROM movies WHERE idMovie = :idMovie) - (SELECT COUNT(idLoan) FROM loans WHERE idMovie = :idMovie AND returnDate IS NULL) AS available_quantity FROM dual")
    int getActualStock(@Bind("idMovie") int idMovie);

    @SqlUpdate("UPDATE movies SET quantity = quantity + 1 WHERE idMovie = :idMovie")
    void increaseMoviesQuantity(@Bind("idMovie") int idMovie);

    @SqlQuery("SELECT COUNT(*) FROM loans WHERE idMovie = :idMovie")
    int countRelatedLoans(@Bind("idMovie") int idMovie);
}


