package sena.adso.registraduriaStaRosaViterbo.servlet;

import sena.adso.registraduriaStaRosaViterbo.dao.*;
import sena.adso.registraduriaStaRosaViterbo.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private final CiudadanoDAO ciudadanoDao = new CiudadanoDAOImpl();
    private final DocumentoDAO documentoDao = new DocumentoDAOImpl();
    // 1. Agregamos el DAO de Mesas
    private final MesaVotacionDAO mesaDao = new MesaVotacionDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 1. VERIFICAR SESIÓN
        // false significa: si no hay sesión, no crees una nueva vacía
        HttpSession session = req.getSession(false); 
        
        // Recuperamos el objeto "usuario" que guardamos en el LoginServlet
        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (u == null) {
            // Si nadie ha iniciado sesión, lo mandamos al login administrativo
            resp.sendRedirect(req.getContextPath() + "/LoginAdmin.jsp?error=sesion");
            return;
        }

        try {
            // 2. OBTENER CONTEOS REALES
            // Consultamos la base de datos a través de los DAO
            int totalC = ciudadanoDao.listarTodos().size();
            int totalD = documentoDao.listarTodos().size();
            
            // 2.1 Consultamos el total de mesas (Asegúrate de que el método se llame listarTodos() o listarTodas() según tu DAO)
            int totalM = mesaDao.listarTodas().size(); 
            
            // 3. ENVIAR DATOS AL JSP (Atributos de petición)
            req.setAttribute("totalCiudadanos", totalC);
            req.setAttribute("totalDocumentos", totalD);
            // 3.1 Enviamos el total de mesas a la vista
            req.setAttribute("totalMesas", totalM);
            
            // 4. CARGAR LA VISTA FINAL
            // El forward mantiene el objeto 'u' de la sesión y los conteos de la petición
            req.getRequestDispatcher("/admin.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            // Si la base de datos falla, enviamos el error al JSP para que sepa qué pasó
            req.setAttribute("errorMsg", "Error al conectar con la base de datos: " + e.getMessage());
            req.getRequestDispatcher("/admin.jsp").forward(req, resp);
        }
    }
}