package com.svalero.servlet;

import com.svalero.dao.Database;
import com.svalero.dao.RatingsDao;
import com.svalero.domain.Rating;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ratingDetails")
public class RatingDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idRating = Integer.parseInt(request.getParameter("idRating"));
        try {
            Rating rating = Database.getInstance().withExtension(RatingsDao.class, dao -> dao.getRating(idRating));
            request.setAttribute("rating", rating);
            request.getRequestDispatcher("/ratingDetails.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error obteniendo la calificación", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            editRating(request, response);
        } else if ("delete".equals(action)) {
            deleteRating(request, response);
        }
    }

    private void editRating(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idRating = Integer.parseInt(request.getParameter("idRating"));
        int newRating = Integer.parseInt(request.getParameter("newRating"));
        String newReview = request.getParameter("newReview");
        try {
            Database.getInstance().useExtension(RatingsDao.class, dao -> dao.updateRating(idRating, newRating, newReview));
            response.sendRedirect(request.getContextPath() + "/listRatings.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error actualizando la calificación", e);
        }
    }

    private void deleteRating(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idRating = Integer.parseInt(request.getParameter("idRating"));
        try {
            Database.getInstance().useExtension(RatingsDao.class, dao -> dao.removeRating(idRating));
            response.sendRedirect(request.getContextPath() + "/listRatings.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error eliminando la calificación", e);
        }
    }
}
