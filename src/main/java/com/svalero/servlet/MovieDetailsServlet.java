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

@WebServlet("/movieDetails")
public class MovieDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idMovie = Integer.parseInt(request.getParameter("idMovie"));
        try {
            Movie movie = Database.getInstance().withExtension(MoviesDao.class, dao -> dao.getMovie(idMovie));
            request.setAttribute("movie", movie);
            request.getRequestDispatcher("/movieDetail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error obteniendo los detalles de la película", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            editMovie(request, response);
        } else if ("delete".equals(action)) {
            deleteMovie(request, response);
        }
    }

    private void editMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idMovie = Integer.parseInt(request.getParameter("idMovie"));
        String newTitle = request.getParameter("newTitle");
        String newDirector = request.getParameter("newDirector");
        String newSynopsis = request.getParameter("newSynopsis");
        String newTrailer = request.getParameter("newTrailer");
        int newQuantity = Integer.parseInt(request.getParameter("newQuantity"));
        String newPath = request.getParameter("newPath");
        try {
            Database.getInstance().useExtension(MoviesDao.class, dao -> dao.updateMovie(idMovie, newTitle, newDirector, newSynopsis, newTrailer, newQuantity, newPath));
            response.sendRedirect(request.getContextPath() + "/listMovies.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error actualizando la película", e);
        }
    }

    private void deleteMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idMovie = Integer.parseInt(request.getParameter("idMovie"));
        try {
            Database.getInstance().useExtension(MoviesDao.class, dao -> dao.removeMovie(idMovie));
            response.sendRedirect(request.getContextPath() + "/listMovies.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error eliminando la película", e);
        }
    }
}
