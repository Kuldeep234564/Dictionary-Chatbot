package users;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UserDetailsServlet")
public class UserDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String step = request.getParameter("step");

        if ("1".equals(step)) {
            session.setAttribute("firstName", request.getParameter("firstName"));
            session.setAttribute("lastName", request.getParameter("lastName"));
            response.sendRedirect("ageGender.jsp");
        } else if ("2".equals(step)) {
            session.setAttribute("age", request.getParameter("age"));
            session.setAttribute("gender", request.getParameter("gender"));
            session.setAttribute("dob", request.getParameter("dob"));
            response.sendRedirect("email.jsp");
        } else if ("3".equals(step)) {
            String email = request.getParameter("email");

            // Validate email format
            if (!isValidEmail(email)) {
                // Redirect back to email.jsp with an error message
                request.setAttribute("errorMessage", "Email must be in lowercase, include numbers, and end with '@gmail.com'.");
                request.getRequestDispatcher("email.jsp").forward(request, response);
                return; // Stop further processing
            }

            // Save the validated email and proceed
            email = email.toLowerCase(); // Ensure it's saved as lowercase
            session.setAttribute("email", email);
            response.sendRedirect("password.jsp");
        } else if ("4".equals(step)) {
            String firstName = (String) session.getAttribute("firstName");
            String lastName = (String) session.getAttribute("lastName");
            int age = Integer.parseInt((String) session.getAttribute("age"));
            String gender = (String) session.getAttribute("gender");
            String dob = (String) session.getAttribute("dob");
            String email = (String) session.getAttribute("email");
            String password = request.getParameter("password");

            // Password validation
            if (!isValidPassword(password)) {
            	request.setAttribute("errorMessage", "password must be in uppercase,lowercase, include numbers, and end with 'symbols'.");
                request.getRequestDispatcher("password.jsp").forward(request, response);
                return; // Stop further processing
            }

            String dbURL = "jdbc:mysql://localhost:3306/UserRegistration";
            String dbUser = "root";
            String dbPassword = "Kuld7458#";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                    String sql = "INSERT INTO Users (firstName, lastName, age, gender, dob, email, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, firstName);
                    stmt.setString(2, lastName);
                    stmt.setInt(3, age);
                    stmt.setString(4, gender);
                    stmt.setString(5, dob);
                    stmt.setString(6, email);
                    stmt.setString(7, password);
                    stmt.executeUpdate();
                    response.sendRedirect("login.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error: " + e.getMessage());
                response.sendRedirect("login.jsp");
            }
        }
    }

    // Utility method to validate email
    private boolean isValidEmail(String email) {
        // Regular expression to check if email:
        // 1. Is lowercase
        // 2. Includes at least one number
        // 3. Ends with '@gmail.com'
        String regex = "^[a-z0-9]+[a-z0-9._%+-]*[a-z0-9]+@[gmail]+\\.com$";
        return email.matches(regex);
    }

    // Utility method to validate password
    private boolean isValidPassword(String password) {
        // Regular expression to check if password contains:
        // 1. At least one uppercase letter
        // 2. At least one lowercase letter
        // 3. At least one number
        // 4. At least one special character
        // 5. At least 8 characters long
        String regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return password.matches(regex);
    }
}
