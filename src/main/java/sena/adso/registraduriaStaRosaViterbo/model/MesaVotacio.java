package sena.adso.registraduriaStaRosaViterbo.model;

public class MesaVotacio {
    private int id;
    private int idZona;
    private int numeroMesa;
    
    // Campos extra para las vistas
    private String nombreZona; 
    private int cantidadCiudadanos;

    public MesaVotacio() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdZona() { return idZona; }
    public void setIdZona(int idZona) { this.idZona = idZona; }

    public int getNumeroMesa() { return numeroMesa; }
    public void setNumeroMesa(int numeroMesa) { this.numeroMesa = numeroMesa; }

    public String getNombreZona() { return nombreZona; }
    public void setNombreZona(String nombreZona) { this.nombreZona = nombreZona; }

    public int getCantidadCiudadanos() { return cantidadCiudadanos; }
    public void setCantidadCiudadanos(int cantidadCiudadanos) { this.cantidadCiudadanos = cantidadCiudadanos; }
}