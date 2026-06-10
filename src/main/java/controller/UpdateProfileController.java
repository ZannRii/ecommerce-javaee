package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;

/**
 * Servlet implementation class UpdateProfileController
 */
@WebServlet("/update-profile")
public class UpdateProfileController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private UserDAO userDao = new UserDAO();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User sessionUser = (User) request.getSession().getAttribute("user");

		String name = request.getParameter("name");
		String phone = request.getParameter("phone");

		sessionUser.setName(name);
		sessionUser.setPhone(phone);

		boolean success = userDao.updateProfile(sessionUser);

		if (success) {

			// update session
			request.getSession().setAttribute("user", sessionUser);

			response.sendRedirect("profile");

		} else {

			response.sendRedirect("edit-profile");
		}
	}
}