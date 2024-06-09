package com.svalero.servlet;

import com.svalero.dao.Database;
import com.svalero.dao.MoviesDao;
import com.svalero.domain.Movie;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/listMovies")
public class ListMoviesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");

        try {
            List<Movie> movies = Database.getInstance().withHandle(handle -> {
                MoviesDao dao = handle.attach(MoviesDao.class);
                if (searchTerm == null || searchTerm.trim().isEmpty()) {
                    return dao.getAllMovies();
                } else {
                    return dao.getMoviesByFilter(searchTerm);
                }
            });

            request.setAttribute("movies", movies);
            request.getRequestDispatcher("/listMovies.jsp").forward(request, response);
        } catch (Exception e) {
            log("Error obteniendo películas", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error obteniendo películas");
        }
    }
}
