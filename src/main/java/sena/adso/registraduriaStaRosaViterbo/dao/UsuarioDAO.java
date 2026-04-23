package sena.adso.registraduriaStaRosaViterbo.dao;

import sena.adso.registraduriaStaRosaViterbo.model.Usuario;
import java.util.List;

public interface UsuarioDAO {
    Usuario validar(String user, String pass) throws Exception;
    List<Usuario> listarTodos() throws Exception; // Agregado
    void insertar(Usuario u) throws Exception;   // Agregado
}