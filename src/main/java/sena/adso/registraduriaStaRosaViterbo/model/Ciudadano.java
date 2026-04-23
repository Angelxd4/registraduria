package sena.adso.registraduriaStaRosaViterbo.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Ciudadano {

    private int id;
    private String numeroDocumento;
    private String nombres;
    private String apellidos;
    private LocalDate fechaNacimiento;
    private String veredaBarrio;
    private String telefono;
    private String correo;
    private int idMesa; // Este es el que mapea a id_mesa en la BD
    private LocalDateTime fechaRegistro;

    public Ciudadano() {
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNumeroDocumento() {
        return numeroDocumento;
    }

    public void setNumeroDocumento(String numeroDocumento) {
        this.numeroDocumento = numeroDocumento;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getVeredaBarrio() {
        return veredaBarrio;
    }

    public void setVeredaBarrio(String veredaBarrio) {
        this.veredaBarrio = veredaBarrio;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    // Este es el método que te marcaba error en rojo
    public int getNumeroMesa() {
        return idMesa;
    }

    public void setNumeroMesa(int idMesa) {
        this.idMesa = idMesa;
    }

    public LocalDateTime getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(LocalDateTime fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }
}
