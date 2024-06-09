package com.svalero.servlet;

import com.svalero.dao.Database;
import com.svalero.dao.MoviesDao;
import com.svalero.dao.RatingsDao;
import com.svalero.domain.Movie;
import com.svalero.domain.Rating;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/addRating")
public class AddRatingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer idUser = (Integer) session.getAttribute("idUser");

        if (idUser == null) {
            response.sendRedirect("login");
            return;
        }

        int idMovie = Integer.parseInt(request.getParameter("idMovie"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String review = request.getParameter("review");

        try {
            Database.getInstance().withExtension(RatingsDao.class, dao -> {
                dao.addRating(idUser, idMovie, rating, review);
                return null;
            });

            response.sendRedirect("listRatings");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error añadiendo calificación", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Movie> movies = null;
        try {
            movies = Database.getInstance().withExtension(MoviesDao.class, MoviesDao::getAllMovies);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("movies", movies);
        request.getRequestDispatcher("/addRating.jsp").forward(request, response);
    }
}
