package sena.adso.registraduriaStaRosaViterbo.dao;

import sena.adso.registraduriaStaRosaViterbo.model.MesaVotacio;
import sena.adso.registraduriaStaRosaViterbo.model.Ciudadano;
import java.util.List;

public interface MesaVotacionDAO {
    List<MesaVotacio> listarTodas() throws Exception;
    void registrar(MesaVotacio mesa) throws Exception;
    void actualizar(MesaVotacio mesa) throws Exception;
    void eliminar(int id) throws Exception;
    MesaVotacio obtenerPorId(int id) throws Exception;
    void distribuirCiudadanosAleatoriamente() throws Exception;
    
    // MÉTODOS DE GESTIÓN DE CIUDADANOS
    List<Ciudadano> listarVotantesPorMesa(int idMesa) throws Exception;
    void quitarVotanteDeMesa(int idCiudadano) throws Exception;
    List<Ciudadano> listarCiudadanosSinMesa() throws Exception;
    void asignarCiudadanoAMesa(int idCiudadano, int idMesa) throws Exception;
}