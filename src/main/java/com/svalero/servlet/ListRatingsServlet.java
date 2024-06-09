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
import java.util.List;

@WebServlet("/listRatings")
public class ListRatingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");

        try {
            List<Rating> ratings;
            if (searchTerm == null || searchTerm.trim().isEmpty()) {
                ratings = Database.getInstance().withExtension(RatingsDao.class, RatingsDao::getAllRatings);
            } else {
                ratings = Database.getInstance().withExtension(RatingsDao.class, dao -> dao.getRatingsByFilter(searchTerm));
            }

            request.setAttribute("ratings", ratings);
            request.getRequestDispatcher("/listRatings.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error obteniendo calificaciones", e);
        }
    }
}
