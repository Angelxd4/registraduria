<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Administrativo | RNEC Santa Rosa</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        :root {
            --apple-bg: #e8e8ed; /* Gris seda de Apple */
            --gov-blue: #00324D; /* Tu azul institucional */
            --apple-blue: #0071e3;
            --card-radius: 35px;
        }
        
        body { 
            background-color: var(--apple-bg);
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "Segoe UI", sans-serif;
            color: #1d1d1f;
            margin: 0;
        }
        
        /* Ajuste para el Sidebar */
        .main-wrapper {
            margin-left: 300px; /* Espacio para el sidebar Apple */
            padding: 2rem;
            transition: all 0.3s;
        }

        /* Barra Superior Minimalista */
        .top-navbar {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 0.8rem 2rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(255,255,255,0.5);
            box-shadow: 0 4px 20px rgba(0,0,0,0.02);
        }

        /* Caja de Bienvenida "Apple Style" */
        .welcome-box {
            background: var(--gov-blue);
            color: white;
            border-radius: var(--card-radius);
            padding: 3.5rem;
            box-shadow: 0 20px 40px rgba(0, 50, 77, 0.15);
            position: relative;
            overflow: hidden;
            border: none;
        }

        .welcome-box h1 {
            font-weight: 700;
            letter-spacing: -2px;
            font-size: 2.8rem;
        }

        /* Tarjetas de Estadísticas (Widgets) */
        .stat-card {
            border: none;
            border-radius: var(--card-radius);
            background: white;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.06);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            margin-bottom: 1.5rem;
        }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--gov-blue);
            letter-spacing: -1px;
            margin-bottom: 0.5rem;
        }

        /* Tabla de Acciones Recientes */
        .table-card {
            background: white;
            border-radius: var(--card-radius);
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            padding: 2.5rem;
            margin-top: 1rem;
        }

        .table thead th {
            background: transparent;
            border-bottom: 2px solid var(--apple-bg);
            color: #86868b;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 1.2rem;
        }

        .table tbody td {
            padding: 1.2rem;
            border-bottom: 1px solid #f5f5f7;
            vertical-align: middle;
        }

        /* Botones Pro */
        .btn-apple {
            border-radius: 12px;
            font-weight: 600;
            padding: 10px 20px;
            transition: 0.3s;
            border: none;
            font-size: 0.9rem;
        }

        .btn-apple-primary { background: var(--apple-bg); color: var(--gov-blue); }
        .btn-apple-primary:hover { background: #dcdce0; }

        .badge-pro {
            padding: 8px 16px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 0.75rem;
        }

        @media (max-width: 992px) {
            .main-wrapper { margin-left: 15px; }
            .welcome-box { padding: 2rem; }
            .welcome-box h1 { font-size: 2rem; }
        }
    </style>
</head>
<body>

    <jsp:include page="/sidebar.jsp" />

    <div class="main-wrapper">
        
        <header class="top-navbar d-flex justify-content-between align-items-center">
            <h5 class="fw-bold mb-0" style="letter-spacing: -0.5px;">Resumen de Operaciones</h5>
            <div class="d-flex align-items-center">
                <div class="text-end me-3 d-none d-md-block">
                    <p class="mb-0 fw-bold small">${usuario.nombreCompleto}</p>
                    <span class="text-muted small fw-medium" style="font-size: 0.7rem; text-transform: uppercase;">Sesión Activa</span>
                </div>
                <div class="bg-white rounded-circle shadow-sm d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; border: 1px solid #eee;">
                    <i class="fa-solid fa-user-check text-success"></i>
                </div>
            </div>
        </header>

        <div class="container-fluid px-0">
            
            <div class="welcome-box mb-5">
                <div class="row align-items-center">
                    <div class="col-md-9">
                        <span class="badge bg-white bg-opacity-25 text-white mb-3 px-3 py-2 rounded-pill fw-bold">Sistema Integral de Gestión</span>
                        <h1>Hola, ${usuario.nombreCompleto}.</h1>
                        <p class="lead opacity-75 mb-0">Bienvenido al Panel Administrativo de Santa Rosa de Viterbo.</p>
                    </div>
                    <div class="col-md-3 text-end d-none d-md-block">
                        <i class="fa-solid fa-chart-line fa-6x opacity-25"></i>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-5">
                <div class="col-12 col-md-6 col-xl-4">
                    <div class="stat-card">
                        <div>
                            <div class="stat-icon" style="background: #eef2ff; color: #4f46e5;">
                                <i class="fa-solid fa-users"></i>
                            </div>
                            <p class="text-muted small fw-bold text-uppercase mb-1">Censo Poblacional</p>
                            <div class="stat-value">${totalCiudadanos}</div>
                            <p class="text-muted small">Ciudadanos inscritos en el municipio</p>
                        </div>
                        <a href="ciudadanos" class="btn btn-apple btn-apple-primary w-100 mt-4">
                            Ver Ciudadanos <i class="fa-solid fa-chevron-right ms-2 small"></i>
                        </a>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-xl-4">
                    <div class="stat-card">
                        <div>
                            <div class="stat-icon" style="background: #f0fdf4; color: #16a34a;">
                                <i class="fa-solid fa-id-card-clip"></i>
                            </div>
                            <p class="text-muted small fw-bold text-uppercase mb-1">Trámites Expedidos</p>
                            <div class="stat-value">${totalDocumentos}</div>
                            <p class="text-muted small">Documentos generados exitosamente</p>
                        </div>
                        <a href="documentos" class="btn btn-apple btn-apple-primary w-100 mt-4">
                            Historial de Trámites <i class="fa-solid fa-chevron-right ms-2 small"></i>
                        </a>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-xl-4">
                    <div class="stat-card">
                        <div>
                            <div class="stat-icon" style="background: #fffbeb; color: #d97706;">
                                <i class="fa-solid fa-box-archive"></i>
                            </div>
                            <p class="text-muted small fw-bold text-uppercase mb-1">Logística Electoral</p>
                            <div class="stat-value">${not empty totalMesas ? totalMesas : '0'}</div>
                            <p class="text-muted small">Mesas habilitadas para el censo actual</p>
                        </div>
                        <a href="mesas" class="btn btn-apple btn-apple-primary w-100 mt-4">
                            Gestionar Mesas <i class="fa-solid fa-chevron-right ms-2 small"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="table-card">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0">
                        <i class="fa-solid fa-clock-rotate-left me-2 text-muted"></i>Actividad Reciente
                    </h5>
                    <button class="btn btn-sm btn-light border rounded-pill px-3 fw-bold text-muted">Ver todo</button>
                </div>
                
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th>Operación</th>
                                <th>Fecha de Registro</th>
                                <th>Responsable</th>
                                <th class="text-center">Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="fw-bold text-dark">Expedición Cédula de Ciudadanía</td>
                                <td class="text-muted">Hoy, 10:45 AM</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="bg-light rounded-circle p-2 me-2"><i class="fa-solid fa-user-tie text-secondary small"></i></div>
                                        <span class="fw-bold small text-muted">${usuario.nombreCompleto}</span>
                                    </div>
                                </td>
                                <td class="text-center">
                                    <span class="badge-pro bg-success-subtle text-success">
                                        <i class="fa-solid fa-check-circle me-1"></i> EXITOSO
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>