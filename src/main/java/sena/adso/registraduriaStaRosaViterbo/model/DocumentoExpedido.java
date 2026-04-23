package sena.adso.registraduriaStaRosaViterbo.model;

import java.time.LocalDate;

public class DocumentoExpedido {
    private int id;
    private int idCiudadano;
    private String cedulaTitular; // Campo para el formulario y búsqueda
    private String tipoDocumento;
    private String numeroSerie;
    private LocalDate fechaExpedicion;
    private LocalDate fechaVencimiento;
    private String estado;
    private String observaciones;
    private String nombreCiudadano;

    public DocumentoExpedido() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdCiudadano() { return idCiudadano; }
    public void setIdCiudadano(int idCiudadano) { this.idCiudadano = idCiudadano; }

    public String getCedulaTitular() { return cedulaTitular; }
    public void setCedulaTitular(String cedulaTitular) { this.cedulaTitular = cedulaTitular; }

    public String getTipoDocumento() { return tipoDocumento; }
    public void setTipoDocumento(String tipoDocumento) { this.tipoDocumento = tipoDocumento; }

    public String getNumeroSerie() { return numeroSerie; }
    public void setNumeroSerie(String numeroSerie) { this.numeroSerie = numeroSerie; }

    public LocalDate getFechaExpedicion() { return fechaExpedicion; }
    public void setFechaExpedicion(LocalDate fechaExpedicion) { this.fechaExpedicion = fechaExpedicion; }

    public LocalDate getFechaVencimiento() { return fechaVencimiento; }
    public void setFechaVencimiento(LocalDate fechaVencimiento) { this.fechaVencimiento = fechaVencimiento; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }

    public String getNombreCiudadano() { return nombreCiudadano; }
    public void setNombreCiudadano(String nombreCiudadano) { this.nombreCiudadano = nombreCiudadano; }
}