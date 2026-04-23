package sena.adso.registraduriaStaRosaViterbo.model;

public class MesaVotacion {
    private int id;
    private int idZona;
    private int numeroMesa;
    private int capacidad;
    
    // Campo para el JOIN de la Zona
    private String nombreZona;
    
    // NUEVO CAMPO: Para contar los votantes y mostrarlo en la burbuja verde
    private int cantidadCiudadanos;

    public MesaVotacion() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdZona() { return idZona; }
    public void setIdZona(int idZona) { this.idZona = idZona; }

    public int getNumeroMesa() { return numeroMesa; }
    public void setNumeroMesa(int numeroMesa) { this.numeroMesa = numeroMesa; }

    public int getCapacidad() { return capacidad; }
    public void setCapacidad(int capacidad) { this.capacidad = capacidad; }

    public String getNombreZona() { return nombreZona; }
    public void setNombreZona(String nombreZona) { this.nombreZona = nombreZona; }

    // Getters y Setters del nuevo campo
    public int getCantidadCiudadanos() { return cantidadCiudadanos; }
    public void setCantidadCiudadanos(int cantidadCiudadanos) { this.cantidadCiudadanos = cantidadCiudadanos; }
}