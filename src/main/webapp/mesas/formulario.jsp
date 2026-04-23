<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty mesa.id or mesa.id == 0 ? 'Crear' : 'Editar'} Mesa | RNEC</title>

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
            margin-left: 300px; /* Consistencia con sidebar premium */
            padding: 2.5rem;
            transition: all 0.3s; 
        }

        /* Top Navbar Glassmorphism */
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

        /* Card Principal */
        .card-modern { 
            border: none; 
            border-radius: var(--card-radius); 
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.05); 
            background: white; 
            overflow: hidden; 
            margin-bottom: 3rem;
        }

        .card-header-apple { 
            background: white;
            border-bottom: 1px solid #f5f5f7;
            padding: 3.5rem 2rem 2.5rem; 
            text-align: center; 
        }

        /* Inputs y Selects Estilo iOS */
        .form-label { 
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            color: #86868b;
            letter-spacing: 1.2px;
            margin-bottom: 8px;
            margin-left: 12px;
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

        /* Botón Pro */
        .btn-apple-blue { 
            background-color: var(--gov-blue); 
            color: white; 
            font-weight: 700; 
            border-radius: 18px; 
            padding: 12px 35px; 
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

        .mesa-icon-circle {
            width: 70px;
            height: 70px;
            background: #f0f4f8;
            color: var(--gov-blue);
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.05);
        }

        @media (max-width: 992px) { .main-wrapper { margin-left: 15px; } }
    </style>
</head>
<body>

    <jsp:include page="/sidebar.jsp" />

    <div class="main-wrapper">
        <header class="top-navbar d-flex justify-content-between align-items-center sticky-top">
            <h6 class="fw-bold text-dark mb-0">
                <i class="fa-solid fa-box-archive me-2 text-muted"></i>Asignación de Mesas
            </h6>
            <div class="d-flex align-items-center">
                <div class="text-end me-3 d-none d-md-block">
                    <p class="mb-0 fw-bold small">${usuario.nombreCompleto}</p>
                    <span class="text-muted small">Logística Electoral</span>
                </div>
                <div class="bg-white rounded-circle shadow-sm d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; border: 1px solid #eee;">
                    <i class="fa-solid fa-check-to-slot text-success"></i>
                </div>
            </div>
        </header>

        <div class="container-fluid px-0" style="max-width: 750px;">
            
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger border-0 shadow-sm rounded-4 px-4 py-3 mb-4 animate__animated animate__shakeX">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i> <strong>Error de sistema:</strong> ${errorMsg}
                </div>
            </c:if>

            <div class="card-modern shadow-lg">
                <div class="card-header-apple">
                    <div class="mesa-icon-circle">
                        <i class="fa-solid ${empty mesa.id or mesa.id == 0 ? 'fa-box-open' : 'fa-pen-to-square'}"></i>
                    </div>
                    <h1 class="fw-bold mb-1" style="letter-spacing: -2px; font-size: 2.5rem;">
                        ${empty mesa.id or mesa.id == 0 ? 'Habilitar Mesa.' : 'Modificar Mesa.'}
                    </h1>
                    <p class="text-muted small">Vincule un número de mesa a una zona geográfica registrada.</p>
                </div>

                <div class="card-body p-4 p-md-5">
                    <form action="${pageContext.request.contextPath}/mesas" method="post">
                        
                        <input type="hidden" name="action" value="${empty mesa.id or mesa.id == 0 ? 'registrar' : 'actualizar'}">
                        
                        <c:if test="${not empty mesa.id and mesa.id != 0}">
                            <input type="hidden" name="id" value="${mesa.id}">
                        </c:if>

                        <div class="mb-4">
                            <label class="form-label">Ubicación (Puesto de Votación)</label>
                            <select name="id_zona" class="form-select form-select-apple" required>
                                <option value="" disabled ${empty mesa.idZona ? 'selected' : ''}>Seleccione el puesto...</option>
                                <c:forEach items="${listaZonas}" var="z">
                                    <option value="${z.id}" ${mesa.idZona == z.id ? 'selected' : ''}>
                                        ${z.nombreZona} &mdash; ${z.direccion}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-5">
                            <label class="form-label">Número Identificador de Mesa</label>
                            <div class="input-group">
                                <input type="number" name="numero_mesa" class="form-control form-control-apple fw-bold" 
                                       placeholder="Ej: 1" min="1" required value="${mesa.numeroMesa}"
                                       style="font-size: 1.5rem; color: var(--gov-blue);">
                            </div>
                            <div class="form-text mt-3 text-center small text-muted">
                                <i class="fa-solid fa-info-circle me-1"></i> El número debe ser único dentro de la zona seleccionada.
                            </div>
                        </div>

                        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-3 pt-4 border-top">
                            <a href="${pageContext.request.contextPath}/mesas" class="btn btn-apple-light px-5 w-100 w-md-auto text-decoration-none text-center">
                                <i class="fa-solid fa-chevron-left me-2"></i> Volver
                            </a>
                            <button type="submit" class="btn btn-apple-blue px-5 w-100 w-md-auto shadow-lg">
                                <i class="fa-solid fa-check-double me-2"></i> 
                                ${empty mesa.id or mesa.id == 0 ? 'Abrir Mesa' : 'Guardar Cambios'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <footer class="text-center">
                <img src="https://aldesarrollo.gov.co/wp-content/uploads/2022/11/LA-REGISTRADURIA-NACIONAL.png.webp" 
                     alt="Logo" style="height: 35px; opacity: 0.4;" class="mb-3">
                <p class="text-muted small fw-medium">Registraduría Municipal - Gestión Logística 2026</p>
            </footer>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>