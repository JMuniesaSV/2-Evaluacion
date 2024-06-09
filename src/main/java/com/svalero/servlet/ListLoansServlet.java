package com.svalero.servlet;

import com.svalero.dao.Database;
import com.svalero.dao.LoansDao;
import com.svalero.domain.Loan;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/listLoans")
public class ListLoansServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");

        HttpSession session = request.getSession();
        Integer idUser = (Integer) session.getAttribute("idUser");

        if (idUser == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            List<Loan> loans;
            if (searchTerm == null || searchTerm.trim().isEmpty()) {
                loans = Database.getInstance().withExtension(LoansDao.class, dao -> dao.findLoansByidUser(idUser));
            } else {
                loans = Database.getInstance().withExtension(LoansDao.class, dao -> dao.getLoansByUserAndFilter(idUser, searchTerm));
            }

            request.setAttribute("loans", loans);
            request.getRequestDispatcher("/listLoans.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error obteniendo alquileres", e);
        }
    }
}

