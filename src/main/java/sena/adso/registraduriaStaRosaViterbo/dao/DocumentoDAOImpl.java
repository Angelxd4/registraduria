package sena.adso.registraduriaStaRosaViterbo.dao;

import sena.adso.registraduriaStaRosaViterbo.config.ConexionDB;
import sena.adso.registraduriaStaRosaViterbo.model.DocumentoExpedido;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocumentoDAOImpl implements DocumentoDAO {

    @Override
    public int obtenerConteoAnual(int anio) throws Exception {
        String sql = "SELECT MAX(CAST(SPLIT_PART(numero_serie, '-', 3) AS INTEGER)) "
                + "FROM documentos_expedidos WHERE numero_serie LIKE ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%-" + anio + "-%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    @Override
    public void insertar(DocumentoExpedido d) throws Exception {
        String sql = "INSERT INTO documentos_expedidos (id_ciudadano, tipo_documento, numero_serie, fecha_expedicion, fecha_vencimiento, estado, observaciones) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, d.getIdCiudadano());
            ps.setString(2, d.getTipoDocumento());
            ps.setString(3, d.getNumeroSerie());
            ps.setDate(4, Date.valueOf(d.getFechaExpedicion()));
            if (d.getFechaVencimiento() != null) {
                ps.setDate(5, Date.valueOf(d.getFechaVencimiento()));
            } else {
                ps.setNull(5, Types.DATE);
            }
            ps.setString(6, d.getEstado());
            ps.setString(7, d.getObservaciones());
            ps.executeUpdate();
        }
    }

    @Override
    public void actualizar(DocumentoExpedido d) throws Exception {
        String sql = "UPDATE documentos_expedidos SET id_ciudadano=?, tipo_documento=?, numero_serie=?, fecha_expedicion=?, fecha_vencimiento=?, estado=?, observaciones=? WHERE id=?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, d.getIdCiudadano());
            ps.setString(2, d.getTipoDocumento());
            ps.setString(3, d.getNumeroSerie());
            ps.setDate(4, Date.valueOf(d.getFechaExpedicion()));
            ps.setDate(5, d.getFechaVencimiento() != null ? Date.valueOf(d.getFechaVencimiento()) : null);
            ps.setString(6, d.getEstado());
            ps.setString(7, d.getObservaciones());
            ps.setInt(8, d.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void eliminar(int id) throws Exception {
        String sql = "DELETE FROM documentos_expedidos WHERE id = ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    @Override
    public List<DocumentoExpedido> listarTodos() throws Exception {
        List<DocumentoExpedido> lista = new ArrayList<>();
        String sql = "SELECT d.*, c.nombres, c.apellidos FROM documentos_expedidos d "
                + "LEFT JOIN ciudadanos c ON d.id_ciudadano = c.id ORDER BY d.id DESC";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapear(rs, true));
            }
        }
        return lista;
    }

    @Override
    public void cambiarEstado(int id, String nuevoEstado) throws Exception {
        String sql = "UPDATE documentos_expedidos SET estado = ? WHERE id = ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    @Override
    public DocumentoExpedido buscarPorId(int id) throws Exception {
        String sql = "SELECT d.*, c.nombres, c.apellidos FROM documentos_expedidos d "
                + "LEFT JOIN ciudadanos c ON d.id_ciudadano = c.id WHERE d.id = ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapear(rs, true) : null;
            }
        }
    }

    @Override
    public List<DocumentoExpedido> listarPorCiudadano(int idCiudadano) throws Exception {
        List<DocumentoExpedido> lista = new ArrayList<>();
        String sql = "SELECT * FROM documentos_expedidos WHERE id_ciudadano = ? ORDER BY fecha_expedicion DESC";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCiudadano);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapear(rs, false));
                }
            }
        }
        return lista;
    }

    @Override
    public List<String> obtenerTiposDocumentosPorCiudadano(int idCiudadano) throws Exception {
        List<String> tipos = new ArrayList<>();
        String sql = "SELECT DISTINCT tipo_documento FROM documentos_expedidos WHERE id_ciudadano = ?";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCiudadano);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    tipos.add(rs.getString("tipo_documento"));
                }
            }
        }
        return tipos;
    }

    @Override
    public int contar() throws Exception {
        String sql = "SELECT COUNT(*) FROM documentos_expedidos";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private DocumentoExpedido mapear(ResultSet rs, boolean incluirNombre) throws SQLException {
        DocumentoExpedido d = new DocumentoExpedido();
        d.setId(rs.getInt("id"));
        d.setIdCiudadano(rs.getInt("id_ciudadano"));
        d.setTipoDocumento(rs.getString("tipo_documento"));
        d.setNumeroSerie(rs.getString("numero_serie"));
        if (rs.getDate("fecha_expedicion") != null) {
            d.setFechaExpedicion(rs.getDate("fecha_expedicion").toLocalDate());
        }
        Date fVenc = rs.getDate("fecha_vencimiento");
        if (fVenc != null) {
            d.setFechaVencimiento(fVenc.toLocalDate());
        }
        d.setEstado(rs.getString("estado"));
        d.setObservaciones(rs.getString("observaciones"));
        if (incluirNombre) {
            String nombres = rs.getString("nombres");
            if (nombres != null) {
                d.setNombreCiudadano(nombres + " " + rs.getString("apellidos"));
            } else {
                d.setNombreCiudadano("CIUDADANO NO REGISTRADO");
            }
        }
        return d;
    }
}