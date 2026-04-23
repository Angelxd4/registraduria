package sena.adso.registraduriaStaRosaViterbo.servlet;

import sena.adso.registraduriaStaRosaViterbo.dao.*;
import sena.adso.registraduriaStaRosaViterbo.model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/mesas")
public class MesaServlet extends HttpServlet {
    private final MesaVotacionDAO mesaDao = new MesaVotacionDAOImpl();
    private final ZonaVotacionDAO zonaDao = new ZonaVotacionDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "listar";

        try {
            switch (action) {
                case "nuevo":
                    req.setAttribute("listaZonas", zonaDao.listarTodas());
                    req.getRequestDispatcher("/mesas/formulario.jsp").forward(req, resp);
                    break;
                case "editar":
                    req.setAttribute("mesa", mesaDao.obtenerPorId(Integer.parseInt(req.getParameter("id"))));
                    req.setAttribute("listaZonas", zonaDao.listarTodas());
                    req.getRequestDispatcher("/mesas/formulario.jsp").forward(req, resp);
                    break;
                case "eliminar":
                    mesaDao.eliminar(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect("mesas?status=deleted");
                    break;
                case "sortear":
                    mesaDao.distribuirCiudadanosAleatoriamente();
                    resp.sendRedirect("mesas?status=sorteo_ok");
                    break;
                case "verVotantes":
                    int idM = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("mesa", mesaDao.obtenerPorId(idM));
                    req.setAttribute("votantes", mesaDao.listarVotantesPorMesa(idM));
                    req.getRequestDispatcher("/mesas/detalleVotantes.jsp").forward(req, resp);
                    break;
                case "quitarVotante":
                    mesaDao.quitarVotanteDeMesa(Integer.parseInt(req.getParameter("idCiudadano")));
                    resp.sendRedirect("mesas?action=verVotantes&id=" + req.getParameter("idMesa"));
                    break;
                case "asignarManual":
                    req.setAttribute("mesa", mesaDao.obtenerPorId(Integer.parseInt(req.getParameter("id"))));
                    req.setAttribute("disponibles", mesaDao.listarCiudadanosSinMesa());
                    req.getRequestDispatcher("/mesas/asignarManual.jsp").forward(req, resp);
                    break;
                case "guardarAsignacion":
                    mesaDao.asignarCiudadanoAMesa(Integer.parseInt(req.getParameter("idC")), Integer.parseInt(req.getParameter("idM")));
                    resp.sendRedirect("mesas?action=verVotantes&id=" + req.getParameter("idM"));
                    break;
                default:
                    req.setAttribute("listaMesas", mesaDao.listarTodas());
                    req.getRequestDispatcher("/mesas/listado.jsp").forward(req, resp);
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("errorMsg", e.getMessage());
            try { req.setAttribute("listaMesas", mesaDao.listarTodas()); } catch (Exception ignored) {}
            req.getRequestDispatcher("/mesas/listado.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        try {
            MesaVotacio mesa = new MesaVotacio();
            mesa.setIdZona(Integer.parseInt(req.getParameter("id_zona")));
            mesa.setNumeroMesa(Integer.parseInt(req.getParameter("numero_mesa")));
            if ("registrar".equals(action)) mesaDao.registrar(mesa);
            else { mesa.setId(Integer.parseInt(req.getParameter("id"))); mesaDao.actualizar(mesa); }
            resp.sendRedirect("mesas?status=success");
        } catch (Exception e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("/mesas/formulario.jsp").forward(req, resp);
        }
    }
}