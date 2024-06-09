package com.svalero.servlet;

import com.svalero.dao.Database;
import com.svalero.dao.MoviesDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addMovie")
public class AddMovieServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer idUser = (Integer) session.getAttribute("idUser");

        if (idUser == null) {
            response.sendRedirect("login");
            return;
        }

        String title = request.getParameter("title");
        String director = request.getParameter("director");
        String synopsis = request.getParameter("synopsis");
        String trailer = request.getParameter("trailer");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String path = request.getParameter("path");

        try {
            Database.getInstance().withExtension(MoviesDao.class, dao -> {
                dao.addMovie(title, director, synopsis, trailer, quantity, path);
                return null;
            });

            response.sendRedirect("listMovies");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error añadiendo película", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/addMovie.jsp").forward(request, response);
    }
}
