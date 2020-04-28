import java.io.IOException;

import java.sql.SQLException;
import java.util.Collection;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pckg.*;

public class UserEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String login = req.getParameter("login");
            User user = Storage.readUserByLogin(login);
            req.setAttribute("user", user);
        } catch(NumberFormatException e) {


        } catch(SQLException e) {
            throw new ServletException(e);
        }

        getServletContext().getRequestDispatcher("/WEB-INF/jsp/UserEdit.jsp")
                .forward(req, resp);
    }
}