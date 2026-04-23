package sena.adso.registraduriaStaRosaViterbo.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class ConexionDB {

    private static final Properties props = new Properties();

    static {
        // Cargamos la configuración desde el archivo de propiedades [cite: 291-294]
        try (InputStream in = ConexionDB.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in == null) {
                throw new RuntimeException("Error: No se encontró el archivo db.properties");
            }
            props.load(in);
            System.out.println(">>> Conexión de Santa Rosa inicializada.");
        } catch (Exception e) {
            throw new RuntimeException("Error crítico al cargar configuración", e);
        }
    }

    public static Connection obtenerConexion() throws Exception {
        // Registro del driver de PostgreSQL necesario para Supabase 
        Class.forName("org.postgresql.Driver");

        String url = props.getProperty("supabase.url");
        String user = props.getProperty("supabase.user");
        String pass = props.getProperty("supabase.password");

        return DriverManager.getConnection(url, user, pass);
    }
}