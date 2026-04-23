<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty documento.id or documento.id == 0 ? 'Expedir' : 'Editar'} Documento | RNEC</title>

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
            margin-left: 300px; /* Margen para sidebar Apple */
            padding: 2.5rem;
            transition: all 0.3s; 
        }

        /* Top Navbar Estilo Glass */
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

        /* Card Principal Blanca */
        .card-modern { 
            border: none; 
            border-radius: var(--card-radius); 
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.05); 
            background: white; 
            overflow: hidden; 
        }

        .card-header-apple { 
            background: white;
            border-bottom: 1px solid #f5f5f7;
            padding: 3rem 2rem 2rem; 
            text-align: center; 
        }

        .section-title {
            color: var(--gov-blue); 
            font-weight: 700; 
            padding-bottom: 10px; 
            margin-bottom: 25px; 
            font-size: 0.85rem; 
            text-transform: uppercase;
            letter-spacing: 1.5px;
            border-bottom: 2px solid #f5f5f7;
        }

        /* Labels e Inputs Estilo iOS */
        .form-label { 
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            color: #86868b;
            letter-spacing: 1.2px;
            margin-bottom: 8px;
            margin-left: 10px;
        }

        .form-control-apple, .form-select-apple {
            background-color: #f5f5f7 !important;
            border: 2px solid transparent !important;
            border-radius: 18px !important;
            padding: 0.8rem 1.2rem !important;
            font-size: 1rem !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
        }

        .form-control-apple:focus, .form-select-apple:focus {
            background-color: white !important;
            border-color: var(--gov-blue) !important;
            box-shadow: 0 0 0 4px rgba(0, 50, 77, 0.08) !important;
            outline: none !important;
        }

        /* Botón Pro Azul Institucional */
        .btn-apple-blue { 
            background-color: var(--gov-blue); 
            color: white; 
            font-weight: 700; 
            border-radius: 18px; 
            padding: 12px 30px; 
            border: none; 
            transition: all 0.3s; 
        }
        .btn-apple-blue:hover { 
            background-color: #001c2b; 
            transform: translateY(-2px); 
            box-shadow: 0 10px 25px rgba(0, 50, 77, 0.2);
            color: white;
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

        #resultadoCiudadano .alert {
            border-radius: 15px;
            font-size: 0.9rem;
            border: none;
        }

        @media (max-width: 992px) { .main-wrapper { margin-left: 15px; } }
    </style>
</head>
<body>

    <jsp:include page="/sidebar.jsp" />

    <div class="main-wrapper">
        <header class="top-navbar d-flex justify-content-between align-items-center sticky-top">
            <h6 class="fw-bold text-dark mb-0"><i class="fa-solid fa-file-signature me-2 text-muted"></i>Registro de Documentación</h6>
            <div class="d-flex align-items-center">
                <div class="text-end me-3 d-none d-md-block">
                    <p class="mb-0 fw-bold small">${usuario.nombreCompleto}</p>
                    <span class="text-muted small">Oficial de Registro</span>
                </div>
                <div class="bg-white rounded-circle shadow-sm d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; border: 1px solid #eee;">
                    <i class="fa-solid fa-stamp text-primary"></i>
                </div>
            </div>
        </header>

        <div class="container-fluid px-0" style="max-width: 900px;">
            
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger border-0 shadow-sm rounded-4 p-3 mb-4 d-flex align-items-center">
                    <i class="fa-solid fa-circle-exclamation fs-4 me-3"></i>
                    <div>
                        <h6 class="fw-bold mb-0">Error en el proceso</h6>
                        <p class="mb-0 small">${errorMsg}</p>
                    </div>
                </div>
            </c:if>

            <div class="card-modern shadow-lg mb-5">
                <div class="card-header-apple">
                    <img src="https://aldesarrollo.gov.co/wp-content/uploads/2022/11/LA-REGISTRADURIA-NACIONAL.png.webp" 
                         alt="Logo RNEC" style="height: 50px;" class="mb-4">
                    <h1 class="fw-bold mb-1" style="letter-spacing: -1.5px;">
                        ${empty documento.id or documento.id == 0 ? 'Expedir Documento.' : 'Actualizar Trámite.'}
                    </h1>
                    <p class="text-muted small">Validación estricta de censo y rango de edad oficial.</p>
                </div>

                <div class="card-body p-4 p-md-5">
                    <form id="formExpedir" action="${pageContext.request.contextPath}/documentos" method="post">
                        <input type="hidden" name="action" value="${empty documento.id or documento.id == 0 ? 'registrar' : 'actualizar'}">
                        <input type="hidden" name="id" value="${documento.id}">

                        <h5 class="section-title">1. Verificación del Titular</h5>
                        <div class="mb-5">
                            <label class="form-label">Número de Identificación del Ciudadano</label>
                            <input type="text" id="cedulaBusqueda" name="cedula_titular" class="form-control form-control-apple w-100" 
                                   required placeholder="Ej: 1052345678" value="${documento.cedulaTitular}">
                            <div id="resultadoCiudadano" class="mt-3 text-center">
                                <span class="text-muted small"><i class="fa-solid fa-magnifying-glass me-1"></i> Esperando documento...</span>
                            </div>
                        </div>

                        <h5 class="section-title">2. Datos del Documento</h5>
                        <div class="row g-4 mb-4">
                            <div class="col-md-6">
                                <label class="form-label">Tipo de Acta</label>
                                <select id="tipoDoc" name="tipo_documento" class="form-select form-select-apple" required>
                                    <option value="Registro Civil" ${documento.tipoDocumento == 'Registro Civil' ? 'selected' : ''}>Registro Civil</option>
                                    <option value="Tarjeta de Identidad" ${documento.tipoDocumento == 'Tarjeta de Identidad' ? 'selected' : ''}>Tarjeta de Identidad</option>
                                    <option value="Cédula de Ciudadanía" ${documento.tipoDocumento == 'Cédula de Ciudadanía' ? 'selected' : ''}>Cédula de Ciudadanía</option>
                                    <option value="Contraseña" ${documento.tipoDocumento == 'Contraseña' ? 'selected' : ''}>Contraseña</option>
                                </select>
                                <div id="errorTipoDoc" class="mt-2 ms-2"></div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Número de Serie (Automático)</label>
                                <input type="text" id="numSerie" name="numero_serie" class="form-control form-control-apple fw-bold text-primary" 
                                       style="background-color: #e8e8ed !important; cursor: not-allowed;" readonly required value="${documento.numeroSerie}">
                            </div>
                        </div>

                        <div class="row g-4 mb-4">
                            <div class="col-md-4">
                                <label class="form-label">Fecha Expedición</label>
                                <input type="date" id="fechaExp" name="fecha_expedicion" class="form-control form-control-apple" required value="${documento.fechaExpedicion}">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Vencimiento Sugerido</label>
                                <input type="date" id="fechaVenc" name="fecha_vencimiento" class="form-control form-control-apple" style="opacity: 0.7;" readonly value="${documento.fechaVencimiento}">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Estado del Trámite</label>
                                <select name="estado" class="form-select form-select-apple" required>
                                    <option value="vigente" ${documento.estado == 'vigente' ? 'selected' : ''}>Vigente</option>
                                    <option value="tramite" ${documento.estado == 'tramite' ? 'selected' : ''}>En Trámite</option>
                                    <option value="anulado" ${documento.estado == 'anulado' ? 'selected' : ''}>Anulado</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-5">
                            <label class="form-label">Observaciones de Registro</label>
                            <textarea name="observaciones" class="form-control form-control-apple" rows="3" placeholder="Notas adicionales sobre el trámite...">${documento.observaciones}</textarea>
                        </div>

                        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-3 pt-4 border-top">
                            <a href="${pageContext.request.contextPath}/documentos" class="btn btn-apple-light px-5 w-100 w-md-auto text-decoration-none text-center">
                                <i class="fa-solid fa-chevron-left me-2"></i> Cancelar
                            </a>
                            <button type="submit" id="btnGuardar" class="btn btn-apple-blue px-5 w-100 w-md-auto shadow-lg">
                                <i class="fa-solid fa-cloud-arrow-up me-2"></i> 
                                ${empty documento.id or documento.id == 0 ? 'Expedir Documento' : 'Guardar Cambios'}
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
        document.addEventListener('DOMContentLoaded', function () {
            const anioActual = "${not empty anioActual ? anioActual : '2026'}";
            const contador = "${not empty proximoNumero ? proximoNumero : '001'}";

            const selectTipo = document.getElementById('tipoDoc');
            const inputSerie = document.getElementById('numSerie');
            const inputCedula = document.getElementById('cedulaBusqueda');
            const divInfo = document.getElementById('resultadoCiudadano');
            const btn = document.getElementById('btnGuardar');
            const fechaExp = document.getElementById('fechaExp');
            const fechaVenc = document.getElementById('fechaVenc');
            const divErrorTipo = document.getElementById('errorTipoDoc');

            let fechaNacimientoCiudadano = null;
            let nombreTitular = ""; 
            let edadCalculada = -1; 

            function actualizarSerie() {
                let prefijo = "CC";
                const tipo = selectTipo.value;
                if (tipo === "Tarjeta de Identidad") prefijo = "TI";
                else if (tipo === "Registro Civil") prefijo = "RC";
                else if (tipo === "Contraseña") prefijo = "CT";

                if ("${documento.id}" == "" || "${documento.id}" == "0") {
                    inputSerie.value = prefijo + "-" + anioActual + "-" + contador;
                } else {
                    let serieActual = inputSerie.value;
                    if (serieActual && serieActual.length >= 2) {
                        inputSerie.value = prefijo + serieActual.substring(2);
                    }
                }
            }

            function validarCambioManual() {
                if (edadCalculada === -1) { actualizarSerie(); return; }
                const tipoSeleccionado = selectTipo.value;
                let esValido = true;
                let mensajeError = "";

                if (tipoSeleccionado === "Contraseña") esValido = true;
                else if (edadCalculada < 7 && tipoSeleccionado !== "Registro Civil") {
                    esValido = false; mensajeError = "Menores de 7 años: Solo Registro Civil.";
                    selectTipo.value = "Registro Civil"; 
                } else if (edadCalculada >= 7 && edadCalculada < 18 && tipoSeleccionado !== "Tarjeta de Identidad") {
                    esValido = false; mensajeError = "7 a 17 años: Corresponde Tarjeta de Identidad.";
                    selectTipo.value = "Tarjeta de Identidad"; 
                } else if (edadCalculada >= 18 && tipoSeleccionado !== "Cédula de Ciudadanía") {
                    esValido = false; mensajeError = "Mayores de edad: Deben portar Cédula.";
                    selectTipo.value = "Cédula de Ciudadanía"; 
                }

                if (!esValido) {
                    divErrorTipo.innerHTML = '<span class="text-danger small fw-bold"><i class="fa-solid fa-circle-xmark me-1"></i>' + mensajeError + '</span>';
                    setTimeout(() => divErrorTipo.innerHTML = '', 4000); 
                }
                actualizarSerie();
            }

            function calcularLogicaDocumento(fechaNacStr) {
                if (!fechaNacStr) return;
                const fNac = new Date(fechaNacStr + "T00:00:00");
                const fExp = new Date(fechaExp.value + "T00:00:00");
                edadCalculada = fExp.getFullYear() - fNac.getFullYear();
                const m = fExp.getMonth() - fNac.getMonth();
                if (m < 0 || (m === 0 && fExp.getDate() < fNac.getDate())) edadCalculada--;

                if (edadCalculada < 0) {
                    divInfo.innerHTML = '<div class="alert alert-danger py-2 m-0 fw-bold">Fecha de expedición inválida (menor al nacimiento).</div>';
                    btn.disabled = true; return; 
                }

                if (edadCalculada < 7) {
                    selectTipo.value = "Registro Civil";
                    let f7 = new Date(fNac); f7.setFullYear(f7.getFullYear() + 7);
                    fechaVenc.value = f7.toISOString().split('T')[0];
                } else if (edadCalculada >= 7 && edadCalculada < 18) {
                    selectTipo.value = "Tarjeta de Identidad";
                    let f18 = new Date(fNac); f18.setFullYear(f18.getFullYear() + 18);
                    fechaVenc.value = f18.toISOString().split('T')[0];
                } else {
                    selectTipo.value = "Cédula de Ciudadanía";
                    let f10 = new Date(fExp); f10.setFullYear(f10.getFullYear() + 10);
                    fechaVenc.value = f10.toISOString().split('T')[0];
                }
                
                divInfo.innerHTML = '<div class="alert alert-success py-2 m-0 text-start">' + 
                                    '<div class="fw-bold text-dark"><i class="fa-solid fa-check-circle text-success me-2"></i>' + nombreTitular + '</div>' + 
                                    '<div class="small mt-1">Edad: <strong>' + edadCalculada + ' años</strong>. Tipo sugerido: <strong>' + selectTipo.value + '</strong></div>' + 
                                    '</div>';
                btn.disabled = false;
                actualizarSerie();
            }

            // AJAX de Búsqueda
            inputCedula.addEventListener('blur', function () {
                const cedula = this.value.trim();
                if (cedula.length >= 5) {
                    divInfo.innerHTML = '<span class="text-primary small"><i class="fas fa-spinner fa-spin me-1"></i> Verificando censo...</span>';
                    fetch('${pageContext.request.contextPath}/ciudadanos?action=buscarAjax&cedula=' + cedula)
                        .then(res => res.json())
                        .then(data => {
                            if (data.encontrado) {
                                fechaNacimientoCiudadano = data.fechaNacimiento;
                                nombreTitular = data.nombres + " " + data.apellidos;
                                calcularLogicaDocumento(data.fechaNacimiento);
                            } else {
                                divInfo.innerHTML = '<div class="alert alert-warning py-2 m-0 small fw-bold">El ciudadano no existe en el padrón.</div>';
                                btn.disabled = true;
                            }
                        });
                }
            });

            fechaExp.addEventListener('change', () => calcularLogicaDocumento(fechaNacimientoCiudadano));
            selectTipo.addEventListener('change', validarCambioManual);
            
            if (!fechaExp.value) fechaExp.value = new Date().toISOString().split('T')[0];
            actualizarSerie();
        });
    </script>
</body>
</html>