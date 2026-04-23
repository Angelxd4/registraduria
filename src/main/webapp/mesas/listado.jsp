<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mesas de Votación | RNEC Santa Rosa</title>
    
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
            margin-left: 300px; /* Consistencia con sidebar */
            padding: 2.5rem;
            transition: all 0.3s;
        }

        /* Top Navbar Glass */
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

        /* Botones Apple Pro */
        .btn-apple-blue {
            background-color: var(--gov-blue);
            color: white;
            border-radius: 15px;
            padding: 10px 24px;
            font-weight: 600;
            border: none;
            transition: 0.3s;
        }
        .btn-apple-blue:hover {
            background-color: #001c2b;
            transform: translateY(-2px);
            color: white;
        }

        /* Botón Sorteo - Toque de Oro/Ambar */
        .btn-sorteo-pro {
            background: #f5f5f7;
            color: #af5200;
            border: 1px solid #ffcc00;
            border-radius: 15px;
            padding: 10px 24px;
            font-weight: 700;
            transition: all 0.3s;
        }
        .btn-sorteo-pro:hover {
            background: #fff9e6;
            color: #8a4100;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 204, 0, 0.2);
        }

        /* Tabla Estilo macOS */
        .table-container {
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid #f2f2f2;
        }

        .table thead th {
            background-color: #fafafa;
            color: #86868b;
            font-size: 0.72rem;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            padding: 1.2rem;
            border-bottom: 1px solid #f2f2f2;
        }

        .table tbody td {
            padding: 1.2rem;
            border-bottom: 1px solid #f5f5f7;
            vertical-align: middle;
            font-size: 0.95rem;
        }

        .badge-mesa {
            background: #f0f4f8;
            color: var(--gov-blue);
            font-weight: 800;
            padding: 8px 15px;
            border-radius: 12px;
            font-size: 1rem;
        }

        .count-bubble {
            background: #34c759;
            color: white;
            font-weight: 700;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
        }

        .btn-action-apple {
            width: 36px; height: 36px;
            border-radius: 10px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: #f5f5f7;
            color: #424245;
            text-decoration: none;
            transition: 0.2s;
        }
        .btn-action-apple:hover { background: #e8e8ed; }

        @media (max-width: 992px) { .main-wrapper { margin-left: 15px; } }
    </style>
</head>
<body>

    <jsp:include page="/sidebar.jsp" />

    <div class="main-wrapper">
        
        <header class="top-navbar d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <i class="fa-solid fa-check-to-slot me-3 text-muted"></i>
                <h6 class="fw-bold mb-0">Infraestructura de Votación</h6>
            </div>
            <div class="d-flex align-items-center">
                <div class="text-end me-3 d-none d-md-block">
                    <p class="mb-0 fw-bold small">${usuario.nombreCompleto}</p>
                    <span class="text-muted small">Coordinador Logístico</span>
                </div>
                <div class="bg-white rounded-circle shadow-sm d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; border: 1px solid #eee;">
                    <i class="fa-solid fa-box-archive text-warning"></i>
                </div>
            </div>
        </header>

        <div class="container-fluid px-0">
            
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end mb-4 gap-3">
                <div>
                    <h1 class="page-title mb-1">Mesas de Votación.</h1>
                    <p class="text-muted mb-0">Gestión de puestos de recepción de votos y asignación aleatoria.</p>
                </div>
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/mesas?action=sortear" class="btn btn-sorteo-pro shadow-sm" 
                       onclick="return confirm('¿Ejecutar distribución aleatoria?');">
                        <i class="fa-solid fa-shuffle me-2"></i> Distribuir Padrón
                    </a>
                    <a href="${pageContext.request.contextPath}/mesas?action=nuevo" class="btn btn-apple-blue shadow-sm">
                        <i class="fa-solid fa-plus me-2"></i> Nueva Mesa
                    </a>
                </div>
            </div>

            <c:if test="${param.status == 'sorteo_ok'}">
                <div class="alert bg-white border-0 shadow-sm mb-4 rounded-4 px-4 py-3 d-flex align-items-center">
                    <div class="bg-warning-subtle rounded-circle p-2 me-3">
                        <i class="fa-solid fa-dice text-warning fs-4"></i>
                    </div>
                    <div>
                        <span class="fw-bold d-block text-dark">Sorteo Completado.</span>
                        <span class="text-muted small">Los ciudadanos habilitados han sido distribuidos entre las mesas disponibles.</span>
                    </div>
                </div>
            </c:if>

            <div class="card-modern">
                <div class="row mb-4">
                    <div class="col-md-6 col-lg-4">
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-0 pe-0" style="position: absolute; z-index: 5; margin-top: 10px; margin-left: 15px;">
                                <i class="fa-solid fa-magnifying-glass text-muted small"></i>
                            </span>
                            <input type="text" id="searchInput" class="form-control search-pill ps-5" placeholder="Buscar por número o zona...">
                        </div>
                    </div>
                </div>

                <div class="table-responsive table-container">
                    <table class="table align-middle mb-0" id="mesasTable">
                        <thead>
                            <tr>
                                <th class="ps-4">Identificador</th>
                                <th>Zona / Puesto de Votación</th>
                                <th class="text-center">Censo Asignado</th>
                                <th class="text-center pe-4">Gestión</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listaMesas}" var="mesa">
                                <tr>
                                    <td class="ps-4">
                                        <span class="badge-mesa">#${mesa.numeroMesa}</span>
                                    </td>
                                    <td>
                                        <div class="fw-bold text-dark">${mesa.nombreZona}</div>
                                        <div class="text-muted small"><i class="fa-solid fa-location-dot me-1"></i> Santa Rosa de Viterbo</div>
                                    </td>
                                    <td class="text-center">
                                        <span class="count-bubble">${mesa.cantidadCiudadanos}</span>
                                        <span class="text-muted small ms-1 fw-bold">Votantes</span>
                                    </td>
                                    <td class="text-center pe-4">
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="${pageContext.request.contextPath}/mesas?action=verVotantes&id=${mesa.id}" 
                                               class="btn-action-apple" title="Ver Listado de Votantes">
                                                <i class="fa-solid fa-users-viewfinder text-success"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/mesas?action=editar&id=${mesa.id}" 
                                               class="btn-action-apple" title="Editar Mesa">
                                                <i class="fa-solid fa-pen-nib text-primary"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/mesas?action=eliminar&id=${mesa.id}" 
                                               class="btn-action-apple" 
                                               onclick="return confirm('¿Eliminar mesa?');" title="Eliminar">
                                                <i class="fa-solid fa-trash-can text-danger"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <c:if test="${empty listaMesas}">
                    <div class="text-center py-5">
                        <i class="fa-solid fa-box-open fa-3x text-muted opacity-25 mb-3"></i>
                        <h5 class="fw-bold text-muted">No hay mesas configuradas</h5>
                        <p class="small text-muted">Inicia la apertura de mesas para el proceso electoral.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('searchInput').addEventListener('keyup', function() {
            let filter = this.value.toLowerCase();
            let rows = document.querySelector('#mesasTable tbody').rows;
            for (let i = 0; i < rows.length; i++) {
                let text = rows[i].textContent.toLowerCase();
                rows[i].style.display = text.includes(filter) ? '' : 'none';
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>s