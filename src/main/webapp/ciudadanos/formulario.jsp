<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty ciudadano.id or ciudadano.id == 0 ? 'Registrar' : 'Editar'} Ciudadano | RNEC</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        :root {
            --apple-bg: #e8e8ed; 
            --gov-blue: #00324D; 
            --apple-blue: #0071e3;
            --card-radius: 35px;
        }
        
        body { 
            background-color: var(--apple-bg);
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "Segoe UI", sans-serif;
            color: #1d1d1f;
            margin: 0;
        }
        
        .main-wrapper {
            margin-left: 300px; 
            padding: 2.5rem;
            transition: all 0.3s;
        }

        .top-navbar {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 0.8rem 2rem;
            margin-bottom: 2.5rem;
            border: 1px solid rgba(255,255,255,0.5);
            box-shadow: 0 4px 20px rgba(0,0,0,0.02);
        }

        .card-modern { 
            background: white;
            border-radius: var(--card-radius);
            border: none;
            box-shadow: 0 20px 60px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 3rem;
        }

        .form-title {
            font-weight: 700;
            letter-spacing: -1.5px;
            color: #1d1d1f;
            font-size: 2.2rem;
        }

        .form-label {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            color: #86868b;
            letter-spacing: 1.2px;
            margin-bottom: 8px;
            margin-left: 10px;
        }

        .form-control-apple {
            background-color: #f5f5f7 !important;
            border: 2px solid transparent !important;
            border-radius: 18px !important;
            padding: 0.8rem 1.2rem !important;
            font-size: 1rem !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
        }

        .form-control-apple:focus {
            background-color: white !important;
            border-color: var(--gov-blue) !important;
            box-shadow: 0 0 0 4px rgba(0, 50, 77, 0.08) !important;
            outline: none !important;
        }

        /* Estilo para cuando el campo está bloqueado en edición */
        .form-control-readonly {
            background-color: #e8e8ed !important;
            color: #86868b !important;
            cursor: not-allowed !important;
            opacity: 0.8;
        }

        /* Borde rojo para validación de error */
        .form-control-error {
            border-color: #dc3545 !important;
            background-color: #fff2f2 !important;
        }

        .btn-apple-blue {
            background-color: var(--gov-blue);
            color: white;
            border-radius: 18px;
            padding: 12px 30px;
            font-weight: 700;
            border: none;
            transition: all 0.3s;
        }

        .btn-apple-blue:hover:not(:disabled) {
            background-color: #001c2b;
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0, 50, 77, 0.2);
            color: white;
        }
        
        .btn-apple-blue:disabled {
            background-color: #a1a1aa;
            cursor: not-allowed;
            box-shadow: none;
        }

        .btn-apple-light {
            background-color: #f5f5f7;
            color: #1d1d1f;
            border-radius: 18px;
            padding: 12px 30px;
            font-weight: 600;
            border: 1px solid #e2e8f0;
            transition: all 0.3s;
        }

        .btn-apple-light:hover {
            background-color: #e8e8ed;
            color: #000;
        }

        .section-divider {
            height: 1px;
            background-color: #f5f5f7;
            margin: 2rem 0;
        }

        @media (max-width: 992px) {
            .main-wrapper { margin-left: 15px; }
        }
    </style>
</head>
<body>

    <jsp:include page="/sidebar.jsp" />

    <div class="main-wrapper">
        
        <header class="top-navbar d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <i class="fa-solid fa-id-card-clip me-3 text-muted"></i>
                <h6 class="fw-bold mb-0">Formulario de Identificación Civil</h6>
            </div>
            <div class="d-flex align-items-center">
                <div class="text-end me-3 d-none d-md-block">
                    <p class="mb-0 fw-bold small">${usuario.nombreCompleto}</p>
                    <span class="text-muted small">Módulo de Censo</span>
                </div>
                <div class="bg-white rounded-circle shadow-sm d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; border: 1px solid #eee;">
                    <i class="fa-solid fa-user-pen text-primary"></i>
                </div>
            </div>
        </header>

        <div class="container-fluid px-0" style="max-width: 900px;">
            
            <%-- Alerta para errores que vengan del Servlet --%>
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger border-0 shadow-sm mb-4 rounded-4 px-4 py-3">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i> <strong>Aviso del sistema:</strong> ${errorMsg}
                </div>
            </c:if>

            <div class="card-modern shadow-lg">
                <div class="p-4 p-md-5 text-center bg-light border-bottom">
                    <img src="https://aldesarrollo.gov.co/wp-content/uploads/2022/11/LA-REGISTRADURIA-NACIONAL.png.webp" 
                         alt="RNEC Logo" style="height: 50px;" class="mb-4">
                    <h1 class="form-title mb-2">
                        ${empty ciudadano.id or ciudadano.id == 0 ? 'Nuevo Ciudadano.' : 'Ficha de Ciudadano.'}
                    </h1>
                    <p class="text-muted mb-0">Asegúrese de que los datos coincidan con el documento físico.</p>
                </div>

                <div class="card-body p-4 p-md-5">
                    <form id="formCiudadano" action="${pageContext.request.contextPath}/ciudadanos" method="post">
                        
                        <input type="hidden" name="action" value="${empty ciudadano.id or ciudadano.id == 0 ? 'registrar' : 'actualizar'}">
                        
                        <c:if test="${not empty ciudadano.id and ciudadano.id != 0}">
                            <input type="hidden" name="id" value="${ciudadano.id}">
                        </c:if>

                        <div class="row g-4 mb-4">
                            <div class="col-md-6">
                                <label class="form-label">Número de Documento</label>
                                <input type="text" id="numeroDocumento" name="numero_documento" 
                                       class="form-control form-control-apple ${not empty ciudadano.id and ciudadano.id != 0 ? 'form-control-readonly' : ''}" 
                                       placeholder="Ej: 1052345678" required pattern="[0-9]+"
                                       value="${ciudadano.numeroDocumento}" 
                                       ${not empty ciudadano.id and ciudadano.id != 0 ? 'readonly' : ''}>
                                <div id="errorDuplicado" class="text-danger small fw-bold mt-2" style="display: none; padding-left: 10px;">
                                    <i class="fa-solid fa-circle-xmark me-1"></i> Este documento ya está registrado.
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Fecha de Nacimiento</label>
                                <input type="date" name="fecha_nacimiento" class="form-control form-control-apple" 
                                       required value="${ciudadano.fechaNacimiento}">
                            </div>
                        </div>

                        <div class="row g-4 mb-4">
                            <div class="col-md-6">
                                <label class="form-label">Nombres</label>
                                <input type="text" name="nombres" class="form-control form-control-apple" 
                                       placeholder="Nombres completos" required value="${ciudadano.nombres}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Apellidos</label>
                                <input type="text" name="apellidos" class="form-control form-control-apple" 
                                       placeholder="Apellidos completos" required value="${ciudadano.apellidos}">
                            </div>
                        </div>

                        <div class="section-divider"></div>

                        <div class="mb-4">
                            <label class="form-label">Vereda o Barrio de Residencia</label>
                            <input type="text" name="vereda_barrio" class="form-control form-control-apple" 
                                   placeholder="Ej: Vereda Cachavita, Barrio Centro..." required value="${ciudadano.veredaBarrio}">
                        </div>

                        <div class="row g-4 mb-5">
                            <div class="col-md-6">
                                <label class="form-label">Teléfono</label>
                                <input type="text" name="telefono" class="form-control form-control-apple" 
                                       placeholder="Opcional" value="${ciudadano.telefono}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Correo Electrónico</label>
                                <input type="email" name="correo" class="form-control form-control-apple" 
                                       placeholder="ejemplo@correo.com" value="${ciudadano.correo}">
                            </div>
                        </div>

                        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-3 pt-4 border-top">
                            <a href="${pageContext.request.contextPath}/ciudadanos" class="btn btn-apple-light px-5 w-100 w-md-auto text-decoration-none text-center">
                                <i class="fa-solid fa-chevron-left me-2"></i> Volver al listado
                            </a>
                            <button type="submit" id="btnGuardar" class="btn btn-apple-blue px-5 w-100 w-md-auto shadow-lg">
                                <i class="fa-solid fa-cloud-arrow-up me-2"></i> 
                                ${empty ciudadano.id or ciudadano.id == 0 ? 'Registrar en Padrón' : 'Guardar Cambios'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <footer class="text-center pb-5">
                <p class="text-muted small fw-medium">Registraduría Nacional del Estado Civil - Santa Rosa de Viterbo</p>
            </footer>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const inputDocumento = document.getElementById("numeroDocumento");
            const errorMensaje = document.getElementById("errorDuplicado");
            const btnGuardar = document.getElementById("btnGuardar");

            // Solo aplicar la validación si el campo no es de solo lectura (es un nuevo registro)
            if (inputDocumento && !inputDocumento.hasAttribute("readonly")) {
                inputDocumento.addEventListener("blur", function() {
                    const cedula = this.value.trim();
                    
                    if (cedula.length >= 5) {
                        // Consumir el AJAX que ya tienes programado en el Servlet para buscar ciudadanos
                        fetch('${pageContext.request.contextPath}/ciudadanos?action=buscarAjax&cedula=' + cedula)
                            .then(response => response.json())
                            .then(data => {
                                if (data.encontrado) {
                                    // Si existe, bloquear formulario y mostrar error
                                    inputDocumento.classList.add("form-control-error");
                                    errorMensaje.style.display = "block";
                                    btnGuardar.disabled = true;
                                } else {
                                    // Si no existe, limpiar error y habilitar botón
                                    inputDocumento.classList.remove("form-control-error");
                                    errorMensaje.style.display = "none";
                                    btnGuardar.disabled = false;
                                }
                            })
                            .catch(error => console.error("Error al verificar documento:", error));
                    } else {
                        // Limpiar validación si borran el campo
                        inputDocumento.classList.remove("form-control-error");
                        errorMensaje.style.display = "none";
                        btnGuardar.disabled = false;
                    }
                });
            }
        });
    </script>
</body>
</html>