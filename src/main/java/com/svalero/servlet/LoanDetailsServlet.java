package com.svalero.servlet;

import com.svalero.dao.Database;
import com.svalero.dao.LoansDao;
import com.svalero.domain.Loan;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/loanDetails")
public class LoanDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idLoan = Integer.parseInt(request.getParameter("idLoan"));
        try {
            Loan loan = Database.getInstance().withExtension(LoansDao.class, dao -> dao.getLoan(idLoan));
            request.setAttribute("loan", loan);
            request.getRequestDispatcher("/loanDetails.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error obteniendo los detalles del préstamo", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            editLoan(request, response);
        } else if ("delete".equals(action)) {
            deleteLoan(request, response);
        }
    }

    private void editLoan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idLoan = Integer.parseInt(request.getParameter("idLoan"));
        int idMovie = Integer.parseInt(request.getParameter("idMovie"));
        int idUser = Integer.parseInt(request.getParameter("idUser"));
        Date newStartDate = Date.valueOf(request.getParameter("newStartDate"));
        Date newExpectedDate = Date.valueOf(request.getParameter("newExpectedDate"));
        Date newReturnDate = request.getParameter("newReturnDate") != null ? Date.valueOf(request.getParameter("newReturnDate")) : null;

        try {
            Database.getInstance().useExtension(LoansDao.class, dao -> dao.updateLoan(idLoan, idMovie, idUser, newStartDate, newExpectedDate, newReturnDate));
            response.sendRedirect(request.getContextPath() + "/loanDetails?idLoan=" + idLoan);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error actualizando el préstamo", e);
        }
    }



    private void deleteLoan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idLoan = Integer.parseInt(request.getParameter("idLoan"));
        try {
            Database.getInstance().useExtension(LoansDao.class, dao -> dao.removeLoan(idLoan));
            response.sendRedirect(request.getContextPath() + "/listLoans");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error eliminando el préstamo", e);
        }
    }
}
