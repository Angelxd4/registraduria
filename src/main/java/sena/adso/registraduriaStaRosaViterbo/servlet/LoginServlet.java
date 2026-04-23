package sena.adso.registraduriaStaRosaViterbo.servlet;

import sena.adso.registraduriaStaRosaViterbo.dao.UsuarioDAO;
import sena.adso.registraduriaStaRosaViterbo.dao.UsuarioDAOImpl;
import sena.adso.registraduriaStaRosaViterbo.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login-admin")
public class LoginServlet extends HttpServlet {

    private final UsuarioDAO usuarioDao = new UsuarioDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        // NUEVA LÓGICA: Si la acción es logout, destruimos la sesión
        if ("logout".equals(action)) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate(); // Borra los datos del usuario de la memoria
            }
            // Redirige al login con un mensaje opcional de éxito
            resp.sendRedirect(req.getContextPath() + "/LoginAdmin.jsp?status=logout_ok");
            return;
        }

        // Si no es logout, simplemente muestra el formulario
        resp.sendRedirect(req.getContextPath() + "/LoginAdmin.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String usuario = req.getParameter("usuario");
        String clave = req.getParameter("password");

        try {
            Usuario userLogueado = usuarioDao.validar(usuario, clave);

            if (userLogueado != null) {
                HttpSession session = req.getSession();
                
                // Usamos "usuario" para que coincida con AdminServlet y admin.jsp
                session.setAttribute("usuario", userLogueado); 
                
                // Redirigimos a /admin para activar el conteo de datos reales
                resp.sendRedirect(req.getContextPath() + "/admin");
                
            } else {
                req.setAttribute("errorMsg", "Usuario o contraseña incorrectos, o usuario inactivo.");
                req.getRequestDispatcher("/LoginAdmin.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            req.setAttribute("errorMsg", "Error de conexión con la base de datos: " + e.getMessage());
            req.getRequestDispatcher("/LoginAdmin.jsp").forward(req, resp);
        }
    }
}