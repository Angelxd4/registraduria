<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zonas Electorales | RNEC Santa Rosa</title>
    
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
            margin-left: 300px; /* Espacio sidebar premium */
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
            background: white;
            border-radius: var(--card-radius);
            border: none;
            box-shadow: 0 10px 40px rgba(0,0,0,0.03);
            padding: 2.5rem;
            margin-bottom: 2rem;
        }

        .page-title {
            font-weight: 700;
            letter-spacing: -1.5px;
            color: #1d1d1f;
            font-size: 2.2rem;
        }

        /* Buscador Estilo Pill */
        .search-pill {
            background-color: #f5f5f7 !important;
            border: 2px solid transparent !important;
            border-radius: 20px !important;
            padding: 0.7rem 1.5rem !important;
            font-size: 0.95rem !important;
            transition: all 0.3s ease !important;
        }
        .search-pill:focus {
            background-color: white !important;
            border-color: var(--gov-blue) !important;
            box-shadow: 0 0 0 4px rgba(0, 50, 77, 0.05) !important;
        }

        /* Botón Pro */
        .btn-apple-blue {
            background-color: var(--gov-blue);
            color: white;
            border-radius: 15px;
            padding: 10px 24px;
            font-weight: 600;
            border: none;
            transition: all 0.3s;
        }
        .btn-apple-blue:hover {
            background-color: #001c2b;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 50, 77, 0.15);
            color: white;
        }

        /* Estilo de la Tabla */
        .table-container {
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid #f2f2f2;
        }

        .table thead th {
            background-color: #fafafa;
            border-bottom: 1px solid #f2f2f2;
            color: #86868b;
            font-size: 0.72rem;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            padding: 1.2rem;
        }

        .table tbody td {
            padding: 1.2rem;
            border-bottom: 1px solid #f5f5f7;
            vertical-align: middle;
            font-size: 0.95rem;
        }

        .table tbody tr:hover { background-color: #fbfbfb; }

        .icon-box-table {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f0f4f8;
            color: var(--gov-blue);
        }

        .badge-apple {
            background: #f5f5f7;
            color: #424245;
            padding: 6px 14px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.8rem;
            border: 1px solid rgba(0,0,0,0.03);
        }

        .btn-action-apple {
            width: 34px; height: 34px;
            border-radius: 10px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: #f5f5f7;
            color: #424245;
            border: 1px solid rgba(0,0,0,0.03);
            transition: 0.2s;
            text-decoration: none;
        }
        .btn-action-apple:hover { background: #e8e8ed; }
        .btn-edit:hover { color: var(--apple-blue); }
        .btn-delete:hover { color: #dc2626; }

        @media (max-width: 992px) { .main-wrapper { margin-left: 15px; } }
    </style>
</head>
<body>

    <jsp:include page="/sidebar.jsp" />

    <div class="main-wrapper">
        
        <header class="top-navbar d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <i class="fa-solid fa-map-location-dot me-3 text-muted"></i>
                <h6 class="fw-bold mb-0">Infraestructura del Padrón Electoral</h6>
            </div>
            <div class="d-flex align-items-center">
                <div class="text-end me-3 d-none d-md-block">
                    <p class="mb-0 fw-bold small">${usuario.nombreCompleto}</p>
                    <span class="text-muted small">Módulo Logístico</span>
                </div>
                <div class="bg-white rounded-circle shadow-sm d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; border: 1px solid #eee;">
                    <i class="fa-solid fa-city text-primary"></i>
                </div>
            </div>
        </header>

        <div class="container-fluid px-0">
            
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end mb-4 gap-3">
                <div>
                    <h1 class="page-title mb-1">Zonas de Votación.</h1>
                    <p class="text-muted mb-0">Gestión de locaciones y puestos habilitados en el municipio.</p>
                </div>
                <a href="${pageContext.request.contextPath}/zonas?action=nuevo" class="btn btn-apple-blue shadow-sm">
                    <i class="fa-solid fa-location-arrow me-2"></i> Registrar Nueva Zona
                </a>
            </div>

            <c:if test="${not empty param.status}">
                <div class="alert bg-white border-0 shadow-sm mb-4 rounded-4 px-4 py-3 d-flex align-items-center">
                    <i class="fa-solid fa-check-circle text-success me-3 fs-4"></i>
                    <span class="fw-bold small text-dark">La infraestructura ha sido actualizada correctamente en el censo.</span>
                </div>
            </c:if>

            <div class="card-modern">
                <div class="row mb-4">
                    <div class="col-md-6 col-lg-4">
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-0 pe-0" style="position: absolute; z-index: 5; margin-top: 10px; margin-left: 15px;">
                                <i class="fa-solid fa-magnifying-glass text-muted small"></i>
                            </span>
                            <input type="text" id="searchInput" class="form-control search-pill ps-5" placeholder="Buscar por nombre o dirección...">
                        </div>
                    </div>
                </div>

                <div class="table-responsive table-container">
                    <table class="table align-middle mb-0" id="zonasTable">
                        <thead>
                            <tr>
                                <th class="ps-4">Nombre del Puesto</th>
                                <th>Ubicación / Dirección</th>
                                <th>Municipio</th>
                                <th class="text-center pe-4">Gestión</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listaZonas}" var="zona">
                                <tr>
                                    <td class="ps-4">
                                        <div class="d-flex align-items-center">
                                            <div class="icon-box-table me-3">
                                                <i class="fa-solid fa-school-flag"></i>
                                            </div>
                                            <span class="fw-bold text-dark">${zona.nombreZona}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center text-muted">
                                            <i class="fa-solid fa-map-pin me-2 text-danger opacity-50"></i>
                                            <span class="fw-medium">${zona.direccion}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge-apple">
                                            ${zona.nombreCiudad}
                                        </span>
                                    </td>
                                    <td class="text-center pe-4">
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="${pageContext.request.contextPath}/zonas?action=editar&id=${zona.id}" 
                                               class="btn-action-apple btn-edit" title="Editar Zona">
                                                <i class="fa-solid fa-pen-nib"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/zonas?action=eliminar&id=${zona.id}" 
                                               class="btn-action-apple btn-delete" 
                                               onclick="return confirm('¿Eliminar permanentemente este puesto? Esto afectará a las mesas asociadas.');" 
                                               title="Eliminar Zona">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <c:if test="${empty listaZonas}">
                    <div class="text-center py-5">
                        <i class="fa-solid fa-map-location fa-3x text-muted opacity-25 mb-3"></i>
                        <h5 class="fw-bold text-muted">Sin zonas registradas</h5>
                        <p class="small text-muted">Aún no se han configurado puestos de votación para el municipio.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('searchInput').addEventListener('keyup', function() {
            let filter = this.value.toLowerCase();
            let rows = document.querySelector('#zonasTable tbody').rows;
            for (let i = 0; i < rows.length; i++) {
                let text = rows[i].textContent.toLowerCase();
                rows[i].style.display = text.includes(filter) ? '' : 'none';
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>