package sena.adso.registraduriaStaRosaViterbo.servlet;

import sena.adso.registraduriaStaRosaViterbo.dao.*;
import sena.adso.registraduriaStaRosaViterbo.model.DocumentoExpedido;
import sena.adso.registraduriaStaRosaViterbo.model.Ciudadano;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/documentos")
public class DocumentoServlet extends HttpServlet {

    private final DocumentoDAO documentoDao = new DocumentoDAOImpl();
    private final CiudadanoDAO ciudadanoDao = new CiudadanoDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        action = (action == null) ? "listar" : action;

        try {
            if ("nuevo".equals(action)) {
                int anio = LocalDate.now().getYear();
                int ultimoNumero = documentoDao.obtenerConteoAnual(anio);
                int proximo = ultimoNumero + 1;
                
                req.setAttribute("anioActual", anio);
                req.setAttribute("proximoNumero", String.format("%03d", proximo));
                req.setAttribute("documento", new DocumentoExpedido());
                req.getRequestDispatcher("/documentos/formulario.jsp").forward(req, resp);
            } 
            else if ("editar".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                DocumentoExpedido d = documentoDao.buscarPorId(id);
                
                // CORRECCIÓN: Aquí es donde buscamos la cédula para que aparezca en el formulario
                Ciudadano c = ciudadanoDao.obtenerPorId(d.getIdCiudadano());
                if (c != null) {
                    d.setCedulaTitular(c.getNumeroDocumento());
                }
                
                req.setAttribute("documento", d);
                req.setAttribute("anioActual", d.getFechaExpedicion().getYear());
                req.getRequestDispatcher("/documentos/formulario.jsp").forward(req, resp);
            }
            else if ("eliminar".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                documentoDao.eliminar(id);
                resp.sendRedirect(req.getContextPath() + "/documentos?status=deleted");
            }
            else if ("cambiarEstado".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                String nuevoEstado = req.getParameter("estado");
                documentoDao.cambiarEstado(id, nuevoEstado);
                resp.sendRedirect(req.getContextPath() + "/documentos?status=updated");
            }
            else {
                req.setAttribute("listaDocumentos", documentoDao.listarTodos());
                req.getRequestDispatcher("/documentos/listado.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            resp.sendError(500, "Error en la operación: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("registrar".equals(action) || "actualizar".equals(action)) {
            try {
                DocumentoExpedido d = new DocumentoExpedido();
                
                if ("actualizar".equals(action)) {
                    d.setId(Integer.parseInt(req.getParameter("id")));
                }

                String cedula = req.getParameter("cedula_titular");
                int idCiudadano = ciudadanoDao.obtenerIdPorCedula(cedula);
                
                if (idCiudadano <= 0) throw new Exception("La cédula ingresada no existe.");

                d.setIdCiudadano(idCiudadano);
                d.setCedulaTitular(cedula);
                d.setTipoDocumento(req.getParameter("tipo_documento"));
                d.setNumeroSerie(req.getParameter("numero_serie"));
                d.setFechaExpedicion(LocalDate.parse(req.getParameter("fecha_expedicion")));
                
                String fVenc = req.getParameter("fecha_vencimiento");
                if (fVenc != null && !fVenc.trim().isEmpty()) {
                    d.setFechaVencimiento(LocalDate.parse(fVenc));
                }

                d.setEstado(req.getParameter("estado"));
                d.setObservaciones(req.getParameter("observaciones"));

                if ("actualizar".equals(action)) {
                    documentoDao.actualizar(d);
                } else {
                    documentoDao.insertar(d);
                }
                
                resp.sendRedirect(req.getContextPath() + "/documentos?status=ok");

            } catch (Exception e) {
                req.setAttribute("errorMsg", "ERROR AL PROCESAR: " + e.getMessage());
                try {
                    int anio = LocalDate.now().getYear();
                    req.setAttribute("anioActual", anio);
                    req.setAttribute("proximoNumero", String.format("%03d", documentoDao.obtenerConteoAnual(anio) + 1));
                } catch(Exception ex) {}
                req.getRequestDispatcher("/documentos/formulario.jsp").forward(req, resp);
            }
        }
    }
}