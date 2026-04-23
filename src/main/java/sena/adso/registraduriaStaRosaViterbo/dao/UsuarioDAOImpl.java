package sena.adso.registraduriaStaRosaViterbo.dao;

import sena.adso.registraduriaStaRosaViterbo.config.ConexionDB;
import sena.adso.registraduriaStaRosaViterbo.model.Usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// CORRECCIÓN: Faltaba "implements UsuarioDAO"
public class UsuarioDAOImpl implements UsuarioDAO {

    @Override
    public Usuario validar(String user, String pass) throws Exception {
        // Consultamos por usuario, clave y que el estado sea activo
        String sql = "SELECT * FROM usuarios WHERE nombre_usuario = ? AND clave = ? AND estado = TRUE";
        
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user);
            ps.setString(2, pass);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setNombreUsuario(rs.getString("nombre_usuario"));
                    u.setNombreCompleto(rs.getString("nombre_completo"));
                    u.setRol(rs.getString("rol"));
                    // Capturamos el estado también
                    u.setEstado(rs.getBoolean("estado"));
                    return u;
                }
            }
        }
        return null; // Credenciales inválidas
    }

    // CORRECCIÓN: Estos métodos se exigen porque están en la interfaz UsuarioDAO
    @Override
    public List<Usuario> listarTodos() throws Exception {
        return new ArrayList<>(); // Vacío por ahora hasta que lo programes
    }

    @Override
    public void insertar(Usuario u) throws Exception {
        // Vacío por ahora hasta que lo programes
    }
}