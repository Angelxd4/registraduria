package sena.adso.registraduriaStaRosaViterbo.servlet;

import sena.adso.registraduriaStaRosaViterbo.dao.ConsultaMesaDAO;
import sena.adso.registraduriaStaRosaViterbo.dao.ConsultaMesaDAOImpl;
import sena.adso.registraduriaStaRosaViterbo.model.ResultadoConsulta;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/consulta-mesa")
public class ConsultaMesaServlet extends HttpServlet {

    private final ConsultaMesaDAO consultaDao = new ConsultaMesaDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String documento = req.getParameter("documento");

        if (documento != null && !documento.trim().isEmpty()) {
            try {
                boolean existe = consultaDao.existeCiudadano(documento);
                
                if (!existe) {
                    req.setAttribute("errorMsg", "El documento " + documento + " no se encuentra registrado en el censo.");
                } else {
                    // Usamos tu clase ResultadoConsulta
                    ResultadoConsulta resultado = consultaDao.buscarPorDocumento(documento);
                    
                    if (resultado != null) {
                        req.setAttribute("resultado", resultado);
                    } else {
                        req.setAttribute("sinMesa", true);
                    }
                }
                req.setAttribute("busquedaRealizada", true);
                
            } catch (Exception e) {
                req.setAttribute("errorMsg", "Error en la consulta: " + e.getMessage());
            }
        }

        req.getRequestDispatcher("/consulta/consultaMesa.jsp").forward(req, resp);
    }
}