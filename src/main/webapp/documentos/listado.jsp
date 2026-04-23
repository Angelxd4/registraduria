<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Historial de Trámites | RNEC Santa Rosa</title>
    
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
            margin-left: 300px; /* Espacio para el sidebar Apple */
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
            font-size: 0.92rem;
        }

        .table tbody tr:hover { background-color: #fbfbfb; }

        /* Badges de Estado Apple */
        .badge-state {
            padding: 6px 14px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
        }
        .bg-vigente { background: #e6f9f0; color: #16a34a; }
        .bg-tramite { background: #fff8e6; color: #d97706; }
        .bg-anulado { background: #fff2f2; color: #dc2626; }

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
        .btn-action-apple:hover { background: #e8e8ed; color: var(--gov-blue); }
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
                <i class="fa-solid fa-file-invoice me-3 text-muted"></i>
                <h6 class="fw-bold mb-0">Control de Actas y Documentación</h6>
            </div>
            <div class="d-flex align-items-center">
                <div class="text-end me-3 d-none d-md-block">
                    <p class="mb-0 fw-bold small">${usuario.nombreCompleto}</p>
                    <span class="text-muted small">Oficial Registrador</span>
                </div>
                <div class="bg-white rounded-circle shadow-sm d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; border: 1px solid #eee;">
                    <i class="fa-solid fa-stamp text-primary"></i>
                </div>
            </div>
        </header>

        <div class="container-fluid px-0">
            
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end mb-4 gap-3">
                <div>
                    <h1 class="page-title mb-1">Historial de Expedición.</h1>
                    <p class="text-muted mb-0">Registro oficial de cédulas, tarjetas y trámites civiles vigentes.</p>
                </div>
                <a href="${pageContext.request.contextPath}/documentos?action=nuevo" class="btn btn-apple-blue shadow-sm">
                    <i class="fa-solid fa-plus me-2"></i> Nuevo Trámite
                </a>
            </div>

            <c:if test="${not empty param.status}">
                <div class="alert bg-white border-0 shadow-sm mb-4 rounded-4 px-4 py-3 d-flex align-items-center animate__animated animate__fadeIn">
                    <i class="fa-solid fa-check-circle text-success me-3 fs-4"></i>
                    <span class="fw-bold small text-dark">Operación procesada y guardada en la base de datos nacional.</span>
                </div>
            </c:if>

            <div class="card-modern">
                <div class="row mb-4">
                    <div class="col-md-6 col-lg-4">
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-0 pe-0" style="position: absolute; z-index: 5; margin-top: 10px; margin-left: 15px;">
                                <i class="fa-solid fa-magnifying-glass text-muted small"></i>
                            </span>
                            <input type="text" id="searchInput" class="form-control search-pill ps-5" placeholder="Serie, tipo o nombre...">
                        </div>
                    </div>
                </div>

                <div class="table-responsive table-container">
                    <table class="table align-middle mb-0" id="docsTable">
                        <thead>
                            <tr>
                                <th class="ps-4">N° de Serie</th>
                                <th>Tipo de Documento</th>
                                <th>Ciudadano Titular</th>
                                <th>Expedición</th>
                                <th class="text-center">Estado</th>
                                <th class="text-center pe-4">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listaDocumentos}" var="doc">
                                <tr>
                                    <td class="ps-4 fw-bold text-dark">
                                        <code class="text-primary bg-light px-2 py-1 rounded">${doc.numeroSerie}</code>
                                    </td>
                                    <td>
                                        <div class="fw-bold text-dark small">${doc.tipoDocumento}</div>
                                    </td>
                                    <td>
                                        <div class="fw-bold text-dark">${doc.nombreCiudadano}</div>
                                        <div class="text-muted small">ID Titular: ${doc.idCiudadano}</div>
                                    </td>
                                    <td>
                                        <div class="small text-muted fw-medium"><i class="fa-regular fa-calendar-check me-2 opacity-50"></i>${doc.fechaExpedicion}</div>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${doc.estado == 'vigente'}">
                                                <span class="badge-state bg-vigente"><i class="fa-solid fa-circle me-2" style="font-size: 6px;"></i>Vigente</span>
                                            </c:when>
                                            <c:when test="${doc.estado == 'tramite'}">
                                                <span class="badge-state bg-tramite"><i class="fa-solid fa-circle me-2" style="font-size: 6px;"></i>Trámite</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-state bg-anulado"><i class="fa-solid fa-circle me-2" style="font-size: 6px;"></i>Anulado</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center pe-4">
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="${pageContext.request.contextPath}/documentos?action=editar&id=${doc.id}" 
                                               class="btn-action-apple btn-edit" title="Editar">
                                                <i class="fa-solid fa-pen-nib"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/documentos?action=eliminar&id=${doc.id}" 
                                               class="btn-action-apple btn-delete" 
                                               onclick="return confirm('¿Eliminar registro?');" title="Eliminar">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <c:if test="${empty listaDocumentos}">
                    <div class="text-center py-5">
                        <i class="fa-solid fa-inbox fa-3x text-muted opacity-25 mb-3"></i>
                        <h5 class="fw-bold text-muted">Bandeja de trámites vacía</h5>
                        <p class="small text-muted">No se han registrado expediciones civiles recientemente.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('searchInput').addEventListener('keyup', function() {
            let filter = this.value.toLowerCase();
            let rows = document.querySelector('#docsTable tbody').rows;
            for (let i = 0; i < rows.length; i++) {
                let text = rows[i].textContent.toLowerCase();
                rows[i].style.display = text.includes(filter) ? '' : 'none';
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>