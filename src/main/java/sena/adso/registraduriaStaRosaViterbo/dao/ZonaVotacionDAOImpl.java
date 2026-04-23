package sena.adso.registraduriaStaRosaViterbo.dao;

import sena.adso.registraduriaStaRosaViterbo.config.ConexionDB;
import sena.adso.registraduriaStaRosaViterbo.model.ZonaVotacion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ZonaVotacionDAOImpl implements ZonaVotacionDAO {

    @Override
    public List<ZonaVotacion> listarTodas() throws Exception {
        List<ZonaVotacion> lista = new ArrayList<>();
        
        // JOIN para traer el nombre de la ciudad correspondiente (Mantenido intacto)
        String sql = "SELECT z.id, z.id_ciudad, z.nombre_zona, z.puesto_votacion, z.direccion, c.nombre AS nombre_ciudad " +
                     "FROM zonas_votacion z " +
                     "INNER JOIN ciudades c ON z.id_ciudad = c.id " +
                     "ORDER BY z.id ASC";
        
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                ZonaVotacion z = new ZonaVotacion();
                z.setId(rs.getInt("id"));
                z.setIdCiudad(rs.getInt("id_ciudad"));
                z.setNombreZona(rs.getString("nombre_zona"));
                z.setPuestoVotacion(rs.getString("puesto_votacion"));
                z.setDireccion(rs.getString("direccion"));
                z.setNombreCiudad(rs.getString("nombre_ciudad"));
                lista.add(z);
            }
        }
        return lista;
    }

    @Override
    public ZonaVotacion obtenerPorId(int id) throws Exception {
        ZonaVotacion zona = null;
        String sql = "SELECT z.id, z.id_ciudad, z.nombre_zona, z.puesto_votacion, z.direccion, c.nombre AS nombre_ciudad " +
                     "FROM zonas_votacion z " +
                     "INNER JOIN ciudades c ON z.id_ciudad = c.id " +
                     "WHERE z.id = ?";
                     
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    zona = new ZonaVotacion();
                    zona.setId(rs.getInt("id"));
                    zona.setIdCiudad(rs.getInt("id_ciudad"));
                    zona.setNombreZona(rs.getString("nombre_zona"));
                    zona.setPuestoVotacion(rs.getString("puesto_votacion"));
                    zona.setDireccion(rs.getString("direccion"));
                    zona.setNombreCiudad(rs.getString("nombre_ciudad"));
                }
            }
        }
        return zona;
    }

    @Override
    public void registrar(ZonaVotacion zona) throws Exception {
        // Se asume el id_ciudad = 1 para Santa Rosa de Viterbo.
        // Si tu base de datos exige 'puesto_votacion', lo igualamos al nombre de la zona.
        String sql = "INSERT INTO zonas_votacion (id_ciudad, nombre_zona, direccion, puesto_votacion) VALUES (1, ?, ?, ?)";
        
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, zona.getNombreZona());
            ps.setString(2, zona.getDireccion());
            ps.setString(3, zona.getNombreZona()); // Guardamos el mismo nombre en puesto
            ps.executeUpdate();
        }
    }

    @Override
    public void actualizar(ZonaVotacion zona) throws Exception {
        String sql = "UPDATE zonas_votacion SET nombre_zona = ?, direccion = ?, puesto_votacion = ? WHERE id = ?";
        
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, zona.getNombreZona());
            ps.setString(2, zona.getDireccion());
            ps.setString(3, zona.getNombreZona());
            ps.setInt(4, zona.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void eliminar(int id) throws Exception {
        String sql = "DELETE FROM zonas_votacion WHERE id = ?";
        
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}