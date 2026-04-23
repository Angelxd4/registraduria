package sena.adso.registraduriaStaRosaViterbo.dao;

import sena.adso.registraduriaStaRosaViterbo.model.ResultadoConsulta;
import sena.adso.registraduriaStaRosaViterbo.model.MesaVotacion;
import java.util.List;

public interface ConsultaMesaDAO {
    // Busca el lugar exacto de votación cruzando 4 tablas devolviendo un POJO
    ResultadoConsulta buscarPorDocumento(String numDoc) throws Exception;
    
    // Lista las mesas asignadas a una zona específica
    List<MesaVotacion> listarMesasPorZona(int idZona) throws Exception;
    
    // Verifica si el ciudadano existe en el padrón, aunque no tenga mesa
    boolean existeCiudadano(String numDoc) throws Exception;
}