package sena.adso.registraduriaStaRosaViterbo.servlet;

import sena.adso.registraduriaStaRosaViterbo.dao.*;
import sena.adso.registraduriaStaRosaViterbo.model.Ciudadano;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate; 
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ciudadanos")
public class CiudadanoServlet extends HttpServlet {

    private final CiudadanoDAO dao = new CiudadanoDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        action = (action == null) ? "listar" : action;

        try {
            switch (action) {
                case "nuevo":
                    req.setAttribute("ciudadano", new Ciudadano());
                    req.getRequestDispatcher("/ciudadanos/formulario.jsp").forward(req, resp);
                    break;
                case "editar":
                    String idEditStr = req.getParameter("id");
                    if (idEditStr != null && !idEditStr.isEmpty()) {
                        int idEdit = Integer.parseInt(idEditStr);
                        Ciudadano c = dao.obtenerPorId(idEdit);
                        req.setAttribute("ciudadano", c);
                        req.getRequestDispatcher("/ciudadanos/formulario.jsp").forward(req, resp);
                    } else {
                        resp.sendRedirect("ciudadanos");
                    }
                    break;
                case "eliminar":
                    String idDelStr = req.getParameter("id");
                    if (idDelStr != null && !idDelStr.isEmpty()) {
                        int idDel = Integer.parseInt(idDelStr);
                        dao.eliminar(idDel);
                        resp.sendRedirect("ciudadanos?status=deleted");
                    }
                    break;
                case "buscarAjax":
                    enviarRespuestaAjax(req, resp);
                    break;
                default:
                    List<Ciudadano> lista = dao.listarTodos();
                    req.setAttribute("listaCiudadanos", lista);
                    req.getRequestDispatcher("/ciudadanos/listado.jsp").forward(req, resp);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Error en el sistema: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        Ciudadano c = new Ciudadano();
        c.setNumeroDocumento(req.getParameter("numero_documento"));
        c.setNombres(req.getParameter("nombres"));
        c.setApellidos(req.getParameter("apellidos"));
        
        // CORRECCIÓN: Conversión de String a LocalDate para evitar el error de compilación
        String fechaNacStr = req.getParameter("fecha_nacimiento");
        if (fechaNacStr != null && !fechaNacStr.isEmpty()) {
            c.setFechaNacimiento(LocalDate.parse(fechaNacStr));
        }

        c.setVeredaBarrio(req.getParameter("vereda_barrio"));
        c.setTelefono(req.getParameter("telefono"));
        c.setCorreo(req.getParameter("correo"));

        try {
            if ("actualizar".equals(action)) {
                String idStr = req.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    c.setId(Integer.parseInt(idStr));
                    dao.actualizar(c);
                }
            } else {
                dao.insertar(c);
            }
            resp.sendRedirect("ciudadanos?status=success");
        } catch (Exception e) {
            req.setAttribute("errorMsg", "No se pudo guardar: " + e.getMessage());
            req.setAttribute("ciudadano", c);
            req.getRequestDispatcher("/ciudadanos/formulario.jsp").forward(req, resp);
        }
    }

    private void enviarRespuestaAjax(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String cedula = req.getParameter("cedula");
        PrintWriter out = resp.getWriter();
        try {
            Ciudadano c = dao.buscarPorCedula(cedula);
            if (c != null) {
                out.print("{\"encontrado\": true, \"nombres\": \"" + c.getNombres() + " " + c.getApellidos() + "\", \"fechaNacimiento\": \"" + c.getFechaNacimiento() + "\"}");
            } else {
                out.print("{\"encontrado\": false, \"mensaje\": \"Cédula no registrada\"}");
            }
        } catch (Exception e) {
            out.print("{\"encontrado\": false, \"mensaje\": \"Error de consulta\"}");
        }
        out.flush();
    }
}