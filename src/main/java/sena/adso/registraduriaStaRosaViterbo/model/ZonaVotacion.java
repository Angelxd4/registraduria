package sena.adso.registraduriaStaRosaViterbo.model;

public class ZonaVotacion {
    private int id;
    private int idCiudad;
    private String nombreZona;
    private String puestoVotacion;
    private String direccion;
    
    // Campo extra para mostrar el nombre de la ciudad con un JOIN
    private String nombreCiudad;
    
    // NUEVO CAMPO: Enlace de Google Maps
    private String linkMapa;

    public ZonaVotacion() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdCiudad() { return idCiudad; }
    public void setIdCiudad(int idCiudad) { this.idCiudad = idCiudad; }

    public String getNombreZona() { return nombreZona; }
    public void setNombreZona(String nombreZona) { this.nombreZona = nombreZona; }

    public String getPuestoVotacion() { return puestoVotacion; }
    public void setPuestoVotacion(String puestoVotacion) { this.puestoVotacion = puestoVotacion; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getNombreCiudad() { return nombreCiudad; }
    public void setNombreCiudad(String nombreCiudad) { this.nombreCiudad = nombreCiudad; }

    // Nuevos Getters y Setters para linkMapa
    public String getLinkMapa() { return linkMapa; }
    public void setLinkMapa(String linkMapa) { this.linkMapa = linkMapa; }
}