package com.svalero.servlet;

import com.svalero.dao.Database;
import com.svalero.dao.LoansDao;
import com.svalero.dao.MoviesDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/loanMovie")
public class LoanMovieServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if (request.getSession().getAttribute("idUser") == null) {
            response.sendRedirect("/login?message=" + URLEncoder.encode("Inicia sesión para alquilar una película.", StandardCharsets.UTF_8));
            return;
        }
        if (request.getParameter("idLoan") != null) {
            try {
                Database.getInstance().inTransaction(handle -> {
                    int idLoan = Integer.parseInt(request.getParameter("idLoan"));
                    LoansDao loansDao = handle.attach(LoansDao.class);
                    java.sql.Date returnDate = new java.sql.Date(System.currentTimeMillis());
                    loansDao.returnLoanById(idLoan, returnDate);
                    return null;
                });
                response.sendRedirect("listLoans");
            } catch (Exception e) {
                response.sendRedirect("error?message=" + URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8));
            }
        } else {
            int idMovie = Integer.parseInt(request.getParameter("idMovie"));
            int idUser = Integer.parseInt(request.getSession().getAttribute("idUser").toString());
            String action = request.getParameter("action");

            try {
                Database.getInstance().inTransaction(handle -> {
                    LoansDao loansDao = handle.attach(LoansDao.class);
                    MoviesDao moviesDao = handle.attach(MoviesDao.class);

                    if ("rent".equals(action)) {
                        int getActualStock = moviesDao.getActualStock(idMovie);
                        if (getActualStock == 0) {
                            throw new IllegalStateException("No hay stock");
                        }

                        java.sql.Date startDate = new java.sql.Date(System.currentTimeMillis());
                        java.sql.Date expectedDate = new java.sql.Date(System.currentTimeMillis() + 604800000); // 7 dias en milisegundos
                        loansDao.addLoan(idMovie, idUser, startDate, expectedDate);
                    } else if ("return".equals(action)) {
                        java.sql.Date returnDate = new java.sql.Date(System.currentTimeMillis());
                        loansDao.returnLoan(idMovie, idUser, returnDate);
                    }

                    return null;
                });
                response.sendRedirect("listMovies");
            } catch (Exception e) {
                response.sendRedirect("error?message=" + URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8));
            }
        }

    }
}