package sena.adso.registraduriaStaRosaViterbo.dao;

import sena.adso.registraduriaStaRosaViterbo.model.DocumentoExpedido;
import java.util.List;

public interface DocumentoDAO {
    void insertar(DocumentoExpedido d) throws Exception;
    void actualizar(DocumentoExpedido d) throws Exception; // NUEVO
    void eliminar(int id) throws Exception; // NUEVO
    List<DocumentoExpedido> listarTodos() throws Exception;
    void cambiarEstado(int id, String nuevoEstado) throws Exception;
    DocumentoExpedido buscarPorId(int id) throws Exception;
    List<DocumentoExpedido> listarPorCiudadano(int idCiudadano) throws Exception;
    int obtenerConteoAnual(int anio) throws Exception;
    
    // Para saber qué documentos ya tiene el ciudadano
    List<String> obtenerTiposDocumentosPorCiudadano(int idCiudadano) throws Exception;
    int contar() throws Exception;
}