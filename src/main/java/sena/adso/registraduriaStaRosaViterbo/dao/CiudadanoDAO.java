package sena.adso.registraduriaStaRosaViterbo.dao;

import sena.adso.registraduriaStaRosaViterbo.model.Ciudadano;
import java.util.List;

public interface CiudadanoDAO {
    void insertar(Ciudadano c) throws Exception;
    void actualizar(Ciudadano c) throws Exception;
    void eliminar(int id) throws Exception;
    List<Ciudadano> listarTodos() throws Exception;
    
    // Método para el CiudadanoServlet (Edición)
    Ciudadano obtenerPorId(int id) throws Exception;
    
    // Método para el buscador AJAX (Documentos Formulario)
    Ciudadano buscarPorCedula(String cedula) throws Exception;
    
    // Método para el DocumentoServlet (Guardar documento)
    int obtenerIdPorCedula(String cedula) throws Exception;
    
    int contar() throws Exception;
    boolean tieneDocumentosAsociados(int idCiudadano) throws Exception;
}