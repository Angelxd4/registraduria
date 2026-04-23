<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asignar Votantes | Mesa #${mesa.numeroMesa}</title>
    
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
            margin-left: 300px; /* Consistencia con Sidebar Premium */
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
            box-shadow: 0 20px 60px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .header-section {
            padding: 3rem 3rem 1rem;
        }

        .page-title {
            font-weight: 700;
            letter-spacing: -1.5px;
            color: #1d1d1f;
            font-size: 2.2rem;
        }

        /* Buscador Estilo Spotlight */
        .search-pill {
            background-color: #f5f5f7 !important;
            border: 2px solid transparent !important;
            border-radius: 20px !important;
            padding: 0.8rem 1.5rem !important;
            padding-left: 3rem !important;
            font-size: 1rem !important;
            transition: all 0.3s ease !important;
        }
        .search-pill:focus {
            background-color: white !important;
            border-color: var(--gov-blue) !important;
            box-shadow: 0 0 0 4px rgba(0, 50, 77, 0.08) !important;
        }

        /* Botón Asignar Pro */
        .btn-apple-assign {
            background-color: var(--gov-blue);
            color: white;
            border-radius: 12px;
            padding: 8px 18px;
            font-weight: 600;
            border: none;
            transition: all 0.2s ease;
            font-size: 0.85rem;
        }
        .btn-apple-assign:hover {
            background-color: #001c2b;
            transform: scale(1.03);
            color: white;
        }

        .btn-apple-light {
            background-color: #f5f5f7;
            color: #424245;
            border-radius: 15px;
            padding: 12px 25px;
            font-weight: 600;
            border: 1px solid rgba(0,0,0,0.03);
            text-decoration: none;
            transition: 0.2s;
        }
        .btn-apple-light:hover {
            background-color: #e8e8ed;
            color: #000;
        }

        /* Estilo de la Tabla */
        .table-container {
            padding: 0 3rem 3rem;
        }

        .table-apple {
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid #f2f2f2;
        }

        .table-apple thead th {
            background-color: #fafafa;
            color: #86868b;
            font-size: 0.72rem;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            padding: 1.2rem;
            border-bottom: 1px solid #f2f2f2;
        }

        .table-apple tbody td {
            padding: 1rem 1.2rem;
            border-bottom: 1px solid #f5f5f7;
            vertical-align: middle;
            font-size: 0.95rem;
        }

        .table-apple tbody tr:hover { background-color: #fbfbfb; }

        .search-icon-inside {
            position: absolute;
            left: 1.2rem;
            top: 50%;
            transform: translateY(-50%);
            z-index: 5;
            color: #86868b;
        }

        @media (max-width: 992px) { .main-wrapper { margin-left: 15px; } }
    </style>
</head>
<body>

    <jsp:include page="/sidebar.jsp" />

    <div class="main-wrapper">
        
        <header class="top-navbar d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <i class="fa-solid fa-user-check me-3 text-muted"></i>
                <h6 class="fw-bold mb-0">Gestión Manual de Censo</h6>
            </div>
            <div class="d-flex align-items-center">
                <div class="text-end me-3 d-none d-md-block">
                    <p class="mb-0 fw-bold small">${usuario.nombreCompleto}</p>
                    <span class="text-muted small">Módulo Logístico</span>
                </div>
                <div class="bg-white rounded-circle shadow-sm d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; border: 1px solid #eee;">
                    <i class="fa-solid fa-user-plus text-primary"></i>
                </div>
            </div>
        </header>

        <div class="container-fluid px-0">
            
            <div class="card-modern shadow-lg">
                <div class="header-section">
                    <div class="d-flex align-items-center mb-3">
                        <span class="badge bg-primary-subtle text-primary rounded-pill px-3 py-2 fw-bold me-2">MESA #${mesa.numeroMesa}</span>
                        <span class="text-muted small fw-bold text-uppercase tracking-wider">Santa Rosa de Viterbo</span>
                    </div>
                    <h1 class="page-title mb-2">Asignar Votantes.</h1>
                    <p class="text-muted mb-4 fs-5">Solo se listan ciudadanos con cédula vigente que no cuentan con mesa asignada.</p>

                    <div class="row mb-2">
                        <div class="col-md-7 col-lg-6 position-relative">
                            <i class="fa-solid fa-magnifying-glass search-icon-inside"></i>
                            <input type="text" id="busqueda" class="form-control search-pill w-100" 
                                   placeholder="Buscar por nombre o número de documento...">
                        </div>
                    </div>
                </div>

                <div class="table-container mt-4">
                    <div class="table-responsive">
                        <table class="table table-apple align-middle mb-0" id="tablaAsignar">
                            <thead>
                                <tr>
                                    <th class="ps-4">Identificación</th>
                                    <th>Nombre del Ciudadano</th>
                                    <th class="text-center pe-4">Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${disponibles}" var="d">
                                    <tr>
                                        <td class="ps-4">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-light rounded-circle p-2 me-3 d-none d-sm-block">
                                                    <i class="fa-solid fa-id-card text-muted small"></i>
                                                </div>
                                                <span class="fw-bold text-dark">${d.numeroDocumento}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="fw-bold text-dark">${d.apellidos}, ${d.nombres}</span>
                                        </td>
                                        <td class="text-center pe-4">
                                            <a href="mesas?action=guardarAsignacion&idC=${d.id}&idM=${mesa.id}" 
                                               class="btn-apple-assign shadow-sm">
                                                <i class="fa-solid fa-plus-circle me-1"></i> Vincular a Mesa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <c:if test="${empty disponibles}">
                        <div class="text-center py-5">
                            <i class="fa-solid fa-user-slash fa-3x text-muted opacity-25 mb-3"></i>
                            <h5 class="fw-bold text-muted">No hay ciudadanos disponibles</h5>
                            <p class="small text-muted">Todos los ciudadanos habilitados ya tienen una mesa asignada.</p>
                        </div>
                    </c:if>

                    <div class="mt-5 pt-4 border-top">
                        <a href="mesas?action=verVotantes&id=${mesa.id}" class="btn btn-apple-light px-4 shadow-sm">
                            <i class="fa-solid fa-arrow-left me-2"></i> Regresar a la Mesa
                        </a>
                    </div>
                </div>
            </div>
            
            <footer class="text-center">
                <p class="text-muted small fw-medium">Registraduría Nacional del Estado Civil - Boyacá</p>
            </footer>
        </div>
    </div>

    <script>
        document.getElementById('busqueda').addEventListener('keyup', function() {
            let filter = this.value.toLowerCase();
            let rows = document.querySelector('#tablaAsignar tbody').rows;
            for(let i=0; i<rows.length; i++) {
                let text = rows[i].textContent.toLowerCase();
                rows[i].style.display = text.includes(filter) ? '' : 'none';
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>