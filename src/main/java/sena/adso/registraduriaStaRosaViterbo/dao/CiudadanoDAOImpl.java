package sena.adso.registraduriaStaRosaViterbo.dao;

import sena.adso.registraduriaStaRosaViterbo.config.ConexionDB;
import sena.adso.registraduriaStaRosaViterbo.model.Ciudadano;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CiudadanoDAOImpl implements CiudadanoDAO {

    @Override
    public void insertar(Ciudadano c) throws Exception {
        String sql = "INSERT INTO ciudadanos (numero_documento, nombres, apellidos, fecha_nacimiento, vereda_barrio, telefono, correo, id_mesa) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getNumeroDocumento());
            ps.setString(2, c.getNombres());
            ps.setString(3, c.getApellidos());
            ps.setDate(4, c.getFechaNacimiento() != null ? Date.valueOf(c.getFechaNacimiento()) : null);
            ps.setString(5, c.getVeredaBarrio());
            ps.setString(6, c.getTelefono());
            ps.setString(7, c.getCorreo());
            if (c.getNumeroMesa() > 0) ps.setInt(8, c.getNumeroMesa()); else ps.setNull(8, Types.INTEGER);
            ps.executeUpdate();
        }
    }

    @Override
    public void actualizar(Ciudadano c) throws Exception {
        String sql = "UPDATE ciudadanos SET nombres=?, apellidos=?, fecha_nacimiento=?, vereda_barrio=?, telefono=?, correo=?, id_mesa=? WHERE id=?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getNombres());
            ps.setString(2, c.getApellidos());
            ps.setDate(3, c.getFechaNacimiento() != null ? Date.valueOf(c.getFechaNacimiento()) : null);
            ps.setString(4, c.getVeredaBarrio());
            ps.setString(5, c.getTelefono());
            ps.setString(6, c.getCorreo());
            if (c.getNumeroMesa() > 0) ps.setInt(7, c.getNumeroMesa()); else ps.setNull(7, Types.INTEGER);
            ps.setInt(8, c.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void eliminar(int id) throws Exception {
        String sql = "DELETE FROM ciudadanos WHERE id = ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    @Override
    public List<Ciudadano> listarTodos() throws Exception {
        List<Ciudadano> lista = new ArrayList<>();
        String sql = "SELECT * FROM ciudadanos ORDER BY apellidos ASC";
        try (Connection con = ConexionDB.obtenerConexion(); Statement st = con.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        }
        return lista;
    }

    @Override
    public Ciudadano obtenerPorId(int id) throws Exception {
        String sql = "SELECT * FROM ciudadanos WHERE id = ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        }
        return null;
    }

    @Override
    public Ciudadano buscarPorCedula(String cedula) throws Exception {
        String sql = "SELECT * FROM ciudadanos WHERE numero_documento = ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, cedula);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        }
        return null;
    }

    @Override
    public int obtenerIdPorCedula(String cedula) throws Exception {
        String sql = "SELECT id FROM ciudadanos WHERE numero_documento = ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, cedula);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("id");
            }
        }
        return 0; // Si no lo encuentra, devuelve 0
    }

    @Override
    public int contar() throws Exception {
        String sql = "SELECT COUNT(*) FROM ciudadanos";
        try (Connection con = ConexionDB.obtenerConexion(); Statement st = con.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    @Override
    public boolean tieneDocumentosAsociados(int idCiudadano) throws Exception {
        String sql = "SELECT COUNT(*) FROM documentos_expedidos WHERE id_ciudadano = ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCiudadano);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private Ciudadano mapear(ResultSet rs) throws SQLException {
        Ciudadano c = new Ciudadano();
        c.setId(rs.getInt("id"));
        c.setNumeroDocumento(rs.getString("numero_documento"));
        c.setNombres(rs.getString("nombres"));
        c.setApellidos(rs.getString("apellidos"));
        if (rs.getDate("fecha_nacimiento") != null) {
            c.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
        }
        c.setVeredaBarrio(rs.getString("vereda_barrio"));
        c.setTelefono(rs.getString("telefono"));
        c.setCorreo(rs.getString("correo"));
        c.setNumeroMesa(rs.getInt("id_mesa"));
        if (rs.getTimestamp("fecha_registro") != null) {
            c.setFechaRegistro(rs.getTimestamp("fecha_registro").toLocalDateTime());
        }
        return c;
    }
}