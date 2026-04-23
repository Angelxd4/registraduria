package sena.adso.registraduriaStaRosaViterbo.dao;

import sena.adso.registraduriaStaRosaViterbo.model.ZonaVotacion;
import java.util.List;

public interface ZonaVotacionDAO {
    List<ZonaVotacion> listarTodas() throws Exception;
    
    // Métodos agregados para completar el CRUD de zonas
    void registrar(ZonaVotacion zona) throws Exception;
    void actualizar(ZonaVotacion zona) throws Exception;
    void eliminar(int id) throws Exception;
    ZonaVotacion obtenerPorId(int id) throws Exception;
}