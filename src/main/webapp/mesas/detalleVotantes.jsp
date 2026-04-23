<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Votantes Mesa #${mesa.numeroMesa} | RNEC</title>
    
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
            margin-left: 300px; /* Consistencia con el Sidebar Premium */
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
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .header-section {
            padding: 3rem 3rem 2rem;
            border-bottom: 1px solid #f5f5f7;
        }

        .page-title {
            font-weight: 700;
            letter-spacing: -1.5px;
            color: #1d1d1f;
            font-size: 2.2rem;
        }

        /* Botón Asignación Manual Estilo Pro */
        .btn-apple-action {
            background-color: var(--gov-blue);
            color: white;
            border-radius: 15px;
            padding: 10px 24px;
            font-weight: 600;
            border: none;
            transition: all 0.3s ease;
        }
        .btn-apple-action:hover {
            background-color: #001c2b;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 50, 77, 0.15);
            color: white;
        }

        .btn-apple-light {
            background-color: #f5f5f7;
            color: #424245;
            border-radius: 12px;
            padding: 8px 20px;
            font-weight: 600;
            border: 1px solid rgba(0,0,0,0.03);
            text-decoration: none;
            transition: 0.2s;
        }
        .btn-apple-light:hover {
            background-color: #e8e8ed;
            color: #1d1d1f;
        }

        /* Estilo de la Tabla de Votantes */
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
            padding: 1.2rem;
            border-bottom: 1px solid #f5f5f7;
            vertical-align: middle;
            font-size: 0.95rem;
        }

        .table-apple tbody tr:hover { background-color: #fbfbfb; }

        .badge-vereda {
            background: #f5f5f7;
            color: #1d1d1f;
            padding: 6px 14px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.8rem;
        }

        .mesa-indicator {
            width: 45px;
            height: 45px;
            background: #f0f4f8;
            color: var(--gov-blue);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        @media (max-width: 992px) { .main-wrapper { margin-left: 15px; } }
    </style>
</head>
<body>

    <jsp:include page="/sidebar.jsp" />

    <div class="main-wrapper">
        
        <header class="top-navbar d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <i class="fa-solid fa-users-rectangle me-3 text-muted"></i>
                <h6 class="fw-bold mb-0">Detalle de Padrón Electoral</h6>
            </div>
            <div class="d-flex align-items-center">
                <div class="text-end me-3 d-none d-md-block">
                    <p class="mb-0 fw-bold small">${usuario.nombreCompleto}</p>
                    <span class="text-muted small">Control de Mesa</span>
                </div>
                <div class="bg-white rounded-circle shadow-sm d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; border: 1px solid #eee;">
                    <i class="fa-solid fa-clipboard-user text-primary"></i>
                </div>
            </div>
        </header>

        <div class="container-fluid px-0">
            
            <div class="card-modern shadow-lg">
                <div class="header-section d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-4">
                    <div class="d-flex align-items-center">
                        <div class="mesa-indicator shadow-sm me-3">
                            <i class="fa-solid fa-box-archive"></i>
                        </div>
                        <div>
                            <h1 class="page-title mb-1">Mesa #${mesa.numeroMesa}.</h1>
                            <p class="text-muted mb-0 fw-medium">
                                <i class="fa-solid fa-location-dot text-danger me-1"></i> ${mesa.nombreZona} &mdash; Santa Rosa de Viterbo
                            </p>
                        </div>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/mesas?action=asignarManual&id=${mesa.id}" class="btn btn-apple-action shadow-sm">
                            <i class="fa-solid fa-user-plus me-2"></i> Asignación Manual
                        </a>
                    </div>
                </div>

                <div class="table-container mt-4">
                    <div class="table-responsive">
                        <table class="table table-apple align-middle mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">Identificación</th>
                                    <th>Ciudadano</th>
                                    <th>Residencia</th>
                                    <th class="text-center pe-4">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${votantes}" var="v">
                                    <tr>
                                        <td class="ps-4">
                                            <span class="fw-bold text-dark">${v.numeroDocumento}</span>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <i class="fa-solid fa-circle-user text-muted me-2 opacity-50"></i>
                                                <span class="fw-bold">${v.apellidos}, ${v.nombres}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge-vereda">
                                                ${v.veredaBarrio}
                                            </span>
                                        </td>
                                        <td class="text-center pe-4">
                                            <a href="mesas?action=quitarVotante&idCiudadano=${v.id}&idMesa=${mesa.id}" 
                                               class="btn-apple-light text-danger border-danger-subtle" 
                                               onclick="return confirm('¿Remover a este ciudadano de la mesa?')">
                                                <i class="fa-solid fa-user-minus me-1"></i> Desvincular
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <c:if test="${empty votantes}">
                        <div class="text-center py-5">
                            <i class="fa-solid fa-users-slash fa-3x text-muted opacity-25 mb-3"></i>
                            <h5 class="fw-bold text-muted">Mesa sin ciudadanos</h5>
                            <p class="small text-muted">Use el sorteo general o la asignación manual para llenar esta mesa.</p>
                        </div>
                    </c:if>

                    <div class="mt-5 pt-4 border-top d-flex flex-column flex-md-row justify-content-between align-items-center gap-3">
                        <div class="d-flex align-items-center gap-2">
                            <span class="text-muted small fw-bold text-uppercase tracking-wider">Censo de mesa:</span>
                            <span class="badge bg-success-subtle text-success px-3 py-2 rounded-pill fw-bold">
                                ${votantes.size()} Ciudadanos Habilitados
                            </span>
                        </div>
                        <a href="mesas" class="btn btn-apple-light px-4">
                            <i class="fa-solid fa-arrow-left me-2"></i> Volver al listado
                        </a>
                    </div>
                </div>
            </div>
            
            <footer class="text-center">
                <p class="text-muted small fw-medium">Registraduría Nacional del Estado Civil - Logística Municipal</p>
            </footer>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>