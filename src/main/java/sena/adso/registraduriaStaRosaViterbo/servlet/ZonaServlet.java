package sena.adso.registraduriaStaRosaViterbo.servlet;

import sena.adso.registraduriaStaRosaViterbo.dao.ZonaVotacionDAO;
import sena.adso.registraduriaStaRosaViterbo.dao.ZonaVotacionDAOImpl;
import sena.adso.registraduriaStaRosaViterbo.model.ZonaVotacion;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/zonas")
public class ZonaServlet extends HttpServlet {

    private final ZonaVotacionDAO zonaDao = new ZonaVotacionDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Capturamos la acción solicitada por el usuario (nuevo, editar, eliminar)
        String action = req.getParameter("action");
        if (action == null) {
            action = "listar"; // Acción por defecto si no se especifica ninguna
        }

        try {
            switch (action) {
                case "nuevo":
                    // Redirige al formulario vacío para registrar una nueva zona
                    req.getRequestDispatcher("/zonas/formulario.jsp").forward(req, resp);
                    break;
                    
                case "editar":
                    // Busca la zona por ID y la envía al formulario para que se llene con los datos
                    int idEditar = Integer.parseInt(req.getParameter("id"));
                    ZonaVotacion zonaEditar = zonaDao.obtenerPorId(idEditar);
                    req.setAttribute("zona", zonaEditar);
                    req.getRequestDispatcher("/zonas/formulario.jsp").forward(req, resp);
                    break;
                    
                case "eliminar":
                    // Elimina el registro usando el ID y recarga la lista
                    int idEliminar = Integer.parseInt(req.getParameter("id"));
                    zonaDao.eliminar(idEliminar);
                    resp.sendRedirect(req.getContextPath() + "/zonas?status=deleted");
                    break;
                    
                case "listar":
                default:
                    // Comportamiento original: Busca todas las zonas y muestra la tabla
                    List<ZonaVotacion> lista = zonaDao.listarTodas();
                    req.setAttribute("listaZonas", lista);
                    req.getRequestDispatcher("/zonas/listado.jsp").forward(req, resp);
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("errorMsg", "Error en el módulo de Zonas: " + e.getMessage());
            req.getRequestDispatcher("/admin.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Configurar codificación para aceptar tildes y caracteres especiales
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        try {
            // Construimos el objeto con los datos del formulario
            ZonaVotacion zona = new ZonaVotacion();
            zona.setNombreZona(req.getParameter("nombre_zona"));
            zona.setDireccion(req.getParameter("direccion"));
            
            String ciudad = req.getParameter("ciudad");
            // CORRECCIÓN: Usamos setNombreCiudad en lugar de setCiudad
            zona.setNombreCiudad(ciudad != null && !ciudad.trim().isEmpty() ? ciudad : "Santa Rosa de Viterbo");

            // Decidimos si guardar uno nuevo o actualizar uno existente
            if ("registrar".equals(action)) {
                zonaDao.registrar(zona);
                resp.sendRedirect(req.getContextPath() + "/zonas?status=success");
            } else if ("actualizar".equals(action)) {
                zona.setId(Integer.parseInt(req.getParameter("id")));
                zonaDao.actualizar(zona);
                resp.sendRedirect(req.getContextPath() + "/zonas?status=success");
            }
        } catch (Exception e) {
            req.setAttribute("errorMsg", "Error al procesar los datos de la zona: " + e.getMessage());
            req.getRequestDispatcher("/zonas/formulario.jsp").forward(req, resp);
        }
    }
}