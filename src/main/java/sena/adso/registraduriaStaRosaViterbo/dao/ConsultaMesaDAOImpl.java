package sena.adso.registraduriaStaRosaViterbo.dao;

import sena.adso.registraduriaStaRosaViterbo.config.ConexionDB;
import sena.adso.registraduriaStaRosaViterbo.model.ResultadoConsulta;
import sena.adso.registraduriaStaRosaViterbo.model.MesaVotacion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ConsultaMesaDAOImpl implements ConsultaMesaDAO {

    @Override
    public ResultadoConsulta buscarPorDocumento(String numDoc) throws Exception {
        String sql = "SELECT c.nombres, c.apellidos, c.numero_documento, ci.nombre AS ciudad, " +
                     "ci.codigo_dane, z.nombre_zona, z.puesto_votacion, z.direccion, m.numero_mesa, m.capacidad " +
                     "FROM ciudadanos c " +
                     "INNER JOIN mesas_votacion m ON c.id_mesa = m.id " +
                     "INNER JOIN zonas_votacion z ON m.id_zona = z.id " +
                     "INNER JOIN ciudades ci ON z.id_ciudad = ci.id " +
                     "WHERE c.numero_documento = ?";
                     
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setString(1, numDoc);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ResultadoConsulta dto = new ResultadoConsulta();
                    dto.setNombres(rs.getString("nombres"));
                    dto.setApellidos(rs.getString("apellidos"));
                    dto.setNumeroDocumento(rs.getString("numero_documento"));
                    dto.setCiudad(rs.getString("ciudad"));
                    dto.setCodigoDane(rs.getString("codigo_dane"));
                    dto.setNombreZona(rs.getString("nombre_zona"));
                    dto.setPuestoVotacion(rs.getString("puesto_votacion"));
                    dto.setDireccion(rs.getString("direccion"));
                    dto.setNumeroMesa(rs.getInt("numero_mesa"));
                    dto.setCapacidad(rs.getInt("capacidad"));
                    return dto;
                }
            }
        }
        return null;
    }

    @Override
    public List<MesaVotacion> listarMesasPorZona(int idZona) throws Exception {
        List<MesaVotacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM mesas_votacion WHERE id_zona = ? ORDER BY numero_mesa";
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idZona);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MesaVotacion m = new MesaVotacion();
                    m.setId(rs.getInt("id"));
                    m.setNumeroMesa(rs.getInt("numero_mesa"));
                    m.setCapacidad(rs.getInt("capacidad"));
                    lista.add(m);
                }
            }
        }
        return lista;
    }

    @Override
    public boolean existeCiudadano(String numDoc) throws Exception {
        String sql = "SELECT 1 FROM ciudadanos WHERE numero_documento = ?";
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, numDoc);
            try (ResultSet rs = ps.executeQuery()) { 
                return rs.next(); 
            }
        }
    }
}