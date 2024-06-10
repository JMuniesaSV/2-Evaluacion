package com.svalero.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.svalero.dao.Database;
import com.svalero.dao.UsersDao;
import com.svalero.domain.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        try {
            request.setAttribute("headTitle", "Login");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error cargando el login", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            boolean emailExists = Database.getInstance().withExtension(UsersDao.class, dao -> {
                return dao.emailExists(email);
            });

            if (emailExists) {
                User userFromDB = Database.getInstance().withExtension(UsersDao.class, dao -> {
                    return dao.getUserByEmail(email);
                });
                boolean userAndPassCorrect = userFromDB.getPassword().equals(password);
                if (userAndPassCorrect) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("success");

                    HttpSession session = request.getSession(true);
                    session.setAttribute("idUser", userFromDB.getIdUser());
                    // response.sendRedirect("listMovies");
                } else {
                    response.setStatus(HttpServletResponse.SC_CONFLICT);
                    response.getWriter().write("Contraseña incorrecta");
                }
            } else {
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                response.getWriter().write("Cuenta no registrada");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Algo salió mal");
        }
    }
}