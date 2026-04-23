<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty zona.id or zona.id == 0 ? 'Registrar' : 'Editar'} Zona | RNEC</title>

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
            margin-left: 300px; /* Espacio para el sidebar premium */
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

        /* Labels e Inputs Estilo iOS */
        .form-label { 
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            color: #86868b;
            letter-spacing: 1.2px;
            margin-bottom: 8px;
            margin-left: 12px;
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

        .section-icon {
            width: 60px;
            height: 60px;
            background: #f0f4f8;
            color: var(--gov-blue);
            border-radius: 18px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
        }

        @media (max-width: 992px) { .main-wrapper { margin-left: 15px; } }
    </style>
</head>
<body>

    <jsp:include page="/sidebar.jsp" />

    <div class="main-wrapper">
        <header class="top-navbar d-flex justify-content-between align-items-center sticky-top">
            <h6 class="fw-bold text-dark mb-0">
                <i class="fa-solid fa-map-location-dot me-2 text-muted"></i>Configuración de Puestos
            </h6>
            <div class="d-flex align-items-center">
                <div class="text-end me-3 d-none d-md-block">
                    <p class="mb-0 fw-bold small">${usuario.nombreCompleto}</p>
                    <span class="text-muted small">Logística Electoral</span>
                </div>
                <div class="bg-white rounded-circle shadow-sm d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; border: 1px solid #eee;">
                    <i class="fa-solid fa-gears text-primary"></i>
                </div>
            </div>
        </header>

        <div class="container-fluid px-0" style="max-width: 800px;">
            
            <div class="card-modern shadow-lg">
                <div class="card-header-apple">
                    <div class="section-icon shadow-sm">
                        <i class="fa-solid ${empty zona.id or zona.id == 0 ? 'fa-location-arrow' : 'fa-pen-to-square'}"></i>
                    </div>
                    <h1 class="fw-bold mb-1" style="letter-spacing: -1.5px;">
                        ${empty zona.id or zona.id == 0 ? 'Nueva Zona de Votación.' : 'Editar Puesto Electoral.'}
                    </h1>
                    <p class="text-muted small">Defina la ubicación física para la recepción de sufragios.</p>
                </div>

                <div class="card-body p-4 p-md-5">
                    <form action="${pageContext.request.contextPath}/zonas" method="post">
                        
                        <input type="hidden" name="action" value="${empty zona.id or zona.id == 0 ? 'registrar' : 'actualizar'}">
                        
                        <c:if test="${not empty zona.id and zona.id != 0}">
                            <input type="hidden" name="id" value="${zona.id}">
                        </c:if>

                        <div class="mb-4">
                            <label class="form-label">Nombre del Puesto / Zona</label>
                            <input type="text" name="nombre_zona" class="form-control form-control-apple" 
                                   placeholder="Ej: Colegio Integrado, Coliseo Municipal..." 
                                   required value="${zona.nombreZona}">
                        </div>

                        <div class="row g-4 mb-5">
                            <div class="col-md-7">
                                <label class="form-label">Dirección Exacta</label>
                                <input type="text" name="direccion" class="form-control form-control-apple" 
                                       placeholder="Ej: Calle 5 # 4-20" required value="${zona.direccion}">
                            </div>
                            <div class="col-md-5">
                                <label class="form-label">Ciudad / Municipio</label>
                                <input type="text" name="ciudad" class="form-control form-control-apple" 
                                       style="background-color: #e8e8ed !important; cursor: not-allowed; opacity: 0.8;"
                                       readonly value="Santa Rosa de Viterbo">
                            </div>
                        </div>

                        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-3 pt-4 border-top">
                            <a href="${pageContext.request.contextPath}/zonas" class="btn btn-apple-light px-5 w-100 w-md-auto text-decoration-none text-center">
                                <i class="fa-solid fa-chevron-left me-2"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-apple-blue px-5 w-100 w-md-auto shadow-lg">
                                <i class="fa-solid fa-cloud-arrow-up me-2"></i> 
                                ${empty zona.id or zona.id == 0 ? 'Habilitar Zona' : 'Guardar Cambios'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <footer class="text-center">
                <img src="https://aldesarrollo.gov.co/wp-content/uploads/2022/11/LA-REGISTRADURIA-NACIONAL.png.webp" 
                     alt="Logo" style="height: 35px; opacity: 0.5;" class="mb-3">
                <p class="text-muted small fw-medium">Registraduría Nacional del Estado Civil - Boyacá</p>
            </footer>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>