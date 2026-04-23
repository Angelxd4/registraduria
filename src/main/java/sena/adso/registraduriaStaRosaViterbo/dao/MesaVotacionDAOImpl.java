package sena.adso.registraduriaStaRosaViterbo.dao;

import sena.adso.registraduriaStaRosaViterbo.config.ConexionDB;
import sena.adso.registraduriaStaRosaViterbo.model.MesaVotacio;
import sena.adso.registraduriaStaRosaViterbo.model.Ciudadano;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MesaVotacionDAOImpl implements MesaVotacionDAO {

    @Override
    public List<MesaVotacio> listarTodas() throws Exception {
        List<MesaVotacio> lista = new ArrayList<>();
        String sql = "SELECT m.id, m.id_zona, m.numero_mesa, z.nombre_zona, " +
                     "(SELECT COUNT(*) FROM ciudadanos c WHERE c.id_mesa = m.id) as cantidad " +
                     "FROM mesas_votacion m INNER JOIN zonas_votacion z ON m.id_zona = z.id " +
                     "ORDER BY z.nombre_zona, m.numero_mesa";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                MesaVotacio m = new MesaVotacio();
                m.setId(rs.getInt("id"));
                m.setIdZona(rs.getInt("id_zona"));
                m.setNumeroMesa(rs.getInt("numero_mesa"));
                m.setNombreZona(rs.getString("nombre_zona"));
                m.setCantidadCiudadanos(rs.getInt("cantidad"));
                lista.add(m);
            }
        }
        return lista;
    }

    @Override
    public MesaVotacio obtenerPorId(int id) throws Exception {
        MesaVotacio mesa = null;
        String sql = "SELECT m.*, z.nombre_zona FROM mesas_votacion m INNER JOIN zonas_votacion z ON m.id_zona = z.id WHERE m.id = ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    mesa = new MesaVotacio();
                    mesa.setId(rs.getInt("id"));
                    mesa.setIdZona(rs.getInt("id_zona"));
                    mesa.setNumeroMesa(rs.getInt("numero_mesa"));
                    mesa.setNombreZona(rs.getString("nombre_zona"));
                }
            }
        }
        return mesa;
    }

    @Override
    public void registrar(MesaVotacio mesa) throws Exception {
        String sql = "INSERT INTO mesas_votacion (id_zona, numero_mesa) VALUES (?, ?)";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, mesa.getIdZona());
            ps.setInt(2, mesa.getNumeroMesa());
            ps.executeUpdate();
        }
    }

    @Override
    public void actualizar(MesaVotacio mesa) throws Exception {
        String sql = "UPDATE mesas_votacion SET id_zona = ?, numero_mesa = ? WHERE id = ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, mesa.getIdZona());
            ps.setInt(2, mesa.getNumeroMesa());
            ps.setInt(3, mesa.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void eliminar(int id) throws Exception {
        try (Connection con = ConexionDB.obtenerConexion()) {
            con.setAutoCommit(false);
            try {
                try (PreparedStatement ps1 = con.prepareStatement("UPDATE ciudadanos SET id_mesa = NULL WHERE id_mesa = ?")) {
                    ps1.setInt(1, id); ps1.executeUpdate();
                }
                try (PreparedStatement ps2 = con.prepareStatement("DELETE FROM mesas_votacion WHERE id = ?")) {
                    ps2.setInt(1, id); ps2.executeUpdate();
                }
                con.commit();
            } catch (Exception e) { con.rollback(); throw e; }
        }
    }

    @Override
    public void distribuirCiudadanosAleatoriamente() throws Exception {
        try (Connection con = ConexionDB.obtenerConexion()) {
            con.setAutoCommit(false);
            try {
                con.prepareStatement("UPDATE ciudadanos SET id_mesa = NULL").executeUpdate();
                List<Integer> mesas = new ArrayList<>();
                try (ResultSet rs = con.prepareStatement("SELECT id FROM mesas_votacion").executeQuery()) {
                    while (rs.next()) mesas.add(rs.getInt("id"));
                }
                if (mesas.isEmpty()) throw new Exception("No hay mesas creadas.");
                
                String sqlVotantes = "SELECT c.id FROM ciudadanos c INNER JOIN documentos_expedidos d ON c.id = d.id_ciudadano " +
                                     "WHERE d.tipo_documento = 'Cédula de Ciudadanía' AND d.estado = 'vigente' ORDER BY RANDOM()";
                try (ResultSet rsV = con.prepareStatement(sqlVotantes).executeQuery()) {
                    PreparedStatement psAsignar = con.prepareStatement("UPDATE ciudadanos SET id_mesa = ? WHERE id = ?");
                    int i = 0;
                    while (rsV.next()) {
                        psAsignar.setInt(1, mesas.get(i));
                        psAsignar.setInt(2, rsV.getInt("id"));
                        psAsignar.addBatch();
                        i = (i + 1) % mesas.size();
                    }
                    psAsignar.executeBatch();
                }
                con.commit();
            } catch (Exception e) { con.rollback(); throw e; }
        }
    }

    // --- NUEVOS MÉTODOS ---
    @Override
    public List<Ciudadano> listarVotantesPorMesa(int idMesa) throws Exception {
        List<Ciudadano> lista = new ArrayList<>();
        String sql = "SELECT * FROM ciudadanos WHERE id_mesa = ? ORDER BY apellidos, nombres";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idMesa);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ciudadano c = new Ciudadano();
                    c.setId(rs.getInt("id"));
                    c.setNumeroDocumento(rs.getString("numero_documento"));
                    c.setNombres(rs.getString("nombres"));
                    c.setApellidos(rs.getString("apellidos"));
                    c.setVeredaBarrio(rs.getString("vereda_barrio"));
                    lista.add(c);
                }
            }
        }
        return lista;
    }

    @Override
    public void quitarVotanteDeMesa(int idCiudadano) throws Exception {
        String sql = "UPDATE ciudadanos SET id_mesa = NULL WHERE id = ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCiudadano); ps.executeUpdate();
        }
    }

    @Override
    public List<Ciudadano> listarCiudadanosSinMesa() throws Exception {
        List<Ciudadano> lista = new ArrayList<>();
        String sql = "SELECT c.* FROM ciudadanos c INNER JOIN documentos_expedidos d ON c.id = d.id_ciudadano " +
                     "WHERE d.tipo_documento = 'Cédula de Ciudadanía' AND d.estado = 'vigente' AND c.id_mesa IS NULL " +
                     "ORDER BY c.apellidos, c.nombres";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Ciudadano c = new Ciudadano();
                c.setId(rs.getInt("id"));
                c.setNumeroDocumento(rs.getString("numero_documento"));
                c.setNombres(rs.getString("nombres"));
                c.setApellidos(rs.getString("apellidos"));
                c.setVeredaBarrio(rs.getString("vereda_barrio"));
                lista.add(c);
            }
        }
        return lista;
    }

    @Override
    public void asignarCiudadanoAMesa(int idCiudadano, int idMesa) throws Exception {
        String sql = "UPDATE ciudadanos SET id_mesa = ? WHERE id = ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idMesa); ps.setInt(2, idCiudadano); ps.executeUpdate();
        }
    }
}