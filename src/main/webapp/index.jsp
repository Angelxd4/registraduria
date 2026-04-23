<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta Electoral | Santa Rosa de Viterbo</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>

    <style>
        :root { 
            --apple-bg: #e8e8ed; 
            --gov-blue: #00324D; 
            --apple-blue: #0071e3;
            --card-radius: 35px;
        }
        
        body { 
            background-color: var(--apple-bg);
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "Segoe UI", Roboto, sans-serif;
            color: #1d1d1f;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            margin: 0;
            padding-bottom: 50px;
        }

        /* Navbar estilo Apple Glass */
        .apple-nav {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 18px 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        /* Tarjeta Principal Blanca Pura */
        .main-card { 
            background: #ffffff;
            border-radius: var(--card-radius);
            box-shadow: 0 20px 60px rgba(0,0,0,0.06);
            border: 1px solid rgba(255,255,255,0.8);
            overflow: hidden;
            transition: all 0.4s ease;
        }

        /* Inputs Estilo iOS */
        .form-control-apple {
            background-color: #f5f5f7;
            border: 2px solid transparent;
            border-radius: 20px;
            padding: 1.2rem 1.5rem;
            font-size: 1.2rem;
            text-align: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .form-control-apple:focus {
            background-color: white;
            border-color: var(--gov-blue);
            box-shadow: 0 0 0 4px rgba(0, 50, 77, 0.1);
            outline: none;
        }

        /* Botón con el Azul del Login */
        .btn-apple-blue {
            background-color: var(--gov-blue);
            color: white;
            border-radius: 20px;
            padding: 15px 30px;
            font-weight: 700;
            border: none;
            transition: all 0.3s;
            font-size: 1.1rem;
        }
        .btn-apple-blue:hover {
            background-color: #001c2b;
            transform: scale(1.02);
            color: white;
            box-shadow: 0 10px 25px rgba(0, 50, 77, 0.2);
        }

        /* Tiquet de Resultado */
        .result-ticket {
            background-color: white;
            border-radius: var(--card-radius);
            padding: 3rem;
            border: 1px solid rgba(0,0,0,0.03);
            box-shadow: 0 10px 40px rgba(0,0,0,0.04);
        }

        .mesa-big {
            font-size: 6rem;
            font-weight: 900;
            color: var(--gov-blue);
            line-height: 0.9;
            letter-spacing: -3px;
        }

        .label-apple {
            font-size: 0.78rem;
            font-weight: 700;
            text-transform: uppercase;
            color: #86868b;
            letter-spacing: 1.5px;
            margin-bottom: 8px;
            display: block;
        }

        .badge-status {
            background: #f5f5f7;
            color: #1d1d1f;
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            border: 1px solid rgba(0,0,0,0.05);
        }

        @media print {
            .no-print { display: none !important; }
            body { background: white !important; }
            .main-card, .result-ticket { box-shadow: none; border: none; padding: 0; }
        }
    </style>
</head>
<body>

    <nav class="apple-nav no-print">
        <div class="container d-flex justify-content-between align-items-center px-4">
            <div class="d-flex align-items-center">
                <img src="https://aldesarrollo.gov.co/wp-content/uploads/2022/11/LA-REGISTRADURIA-NACIONAL.png.webp" 
                     height="45" alt="Registraduría Nacional">
                <div class="ms-3 d-none d-md-block">
                    <span class="fw-bold d-block" style="color: var(--gov-blue); line-height: 1; font-size: 0.9rem;">Portal Electoral</span>
                    <span class="text-muted small">Santa Rosa de Viterbo</span>
                </div>
            </div>
            <a href="LoginAdmin.jsp" class="btn btn-sm btn-light rounded-pill px-4 fw-bold text-muted border shadow-sm">
                Acceso Funcionario
            </a>
        </div>
    </nav>

    <div class="container d-flex flex-column align-items-center pt-5">
        <div class="col-12 col-md-10 col-lg-7">
            
            <%-- VISTA DE BÚSQUEDA --%>
            <c:if test="${empty resultado}">
                <div class="main-card p-4 p-md-5 mb-4 text-center">
                    <div class="mb-5">
                        <h1 class="fw-bold mb-3" style="letter-spacing: -2px; font-size: 3.2rem;">Consulta de Puesto.</h1>
                        <p class="text-muted fs-5 mx-auto" style="max-width: 500px;">
                            Ingresa tu documento para localizar tu lugar de votación oficial para el 2026.
                        </p>
                    </div>

                    <form action="consulta-mesa" method="get" id="formConsulta" class="col-md-9 mx-auto">
                        <div class="mb-4">
                            <label class="label-apple">Cédula de Ciudadanía</label>
                            <input type="text" name="documento" class="form-control-apple w-100" 
                                   placeholder="Digita tu número aquí" required pattern="[0-9]+">
                        </div>

                        <div class="mb-4 d-flex justify-content-center no-print">
                            <div class="g-recaptcha" data-sitekey="6LdCG70sAAAAALtOPDenf9sEZJLN1pLo5Cu5-V59"></div>
                        </div>

                        <button type="submit" class="btn-apple-blue w-100 py-3 shadow-lg">
                            Localizar mi mesa <i class="fa-solid fa-chevron-right ms-2 small"></i>
                        </button>
                    </form>
                </div>
                
                <div class="text-center mt-4 no-print">
                    <p class="text-muted small fw-medium">Registraduría Municipal de Santa Rosa de Viterbo - Boyacá</p>
                </div>
            </c:if>

            <%-- MENSAJE DE NO ENCONTRADO --%>
            <c:if test="${empty resultado && param.documento != null}">
                <div class="main-card p-5 text-center mt-4">
                    <div class="mb-4 text-danger"><i class="fa-solid fa-circle-exclamation fa-5x opacity-25"></i></div>
                    <h2 class="fw-bold" style="letter-spacing: -1px;">No registrado</h2>
                    <p class="text-muted fs-5 mb-4">El documento <strong>${param.documento}</strong> no figura en el censo actual de este municipio.</p>
                    <a href="index.jsp" class="btn btn-light rounded-pill px-5 py-3 border fw-bold text-muted shadow-sm">
                        <i class="fa-solid fa-arrow-left me-2"></i> Realizar otra búsqueda
                    </a>
                </div>
            </c:if>

            <%-- VISTA DE RESULTADO (EL TICKET) --%>
            <c:if test="${not empty resultado}">
                <div class="result-ticket mb-4 mt-3">
                    <div class="text-center mb-5">
                        <div class="d-inline-block badge-status mb-3">
                            <i class="fa-solid fa-check-circle text-success me-2"></i>CIUDADANO HABILITADO
                        </div>
                        <h2 class="fw-bold mb-1" style="font-size: 2.8rem; letter-spacing: -1.5px;">${resultado.nombres} ${resultado.apellidos}</h2>
                        <p class="text-muted fw-bold">IDENTIFICACIÓN: ${resultado.numeroDocumento}</p>
                    </div>

                    <div class="bg-light rounded-4 p-4 p-md-5 mb-5 border border-white">
                        <div class="row g-4">
                            <div class="col-md-7 border-md-end pe-md-5">
                                <div class="mb-4">
                                    <span class="label-apple">Puesto de Votación</span>
                                    <div class="fw-bold fs-4 text-dark">${resultado.puestoVotacion}</div>
                                </div>
                                <div class="row">
                                    <div class="col-6">
                                        <span class="label-apple">Zona</span>
                                        <div class="fw-bold fs-5">${resultado.nombreZona}</div>
                                    </div>
                                    <div class="col-6">
                                        <span class="label-apple">Municipio</span>
                                        <div class="fw-bold fs-5">S.R. de Viterbo</div>
                                    </div>
                                </div>
                                <div class="mt-4 pt-3 border-top">
                                    <span class="label-apple">Dirección exacta</span>
                                    <div class="text-muted fw-medium">${resultado.direccion}</div>
                                </div>
                            </div>
                            <div class="col-md-5 text-center d-flex flex-column justify-content-center pt-4 pt-md-0">
                                <span class="label-apple mb-2">Mesa Asignada</span>
                                <div class="mesa-big">${resultado.numeroMesa}</div>
                                <div class="mt-3 small text-muted fw-bold">FILA PRIORITARIA DISPONIBLE</div>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex flex-column flex-md-row gap-3 no-print">
                        <a href="index.jsp" class="btn btn-light flex-grow-1 py-3 rounded-4 fw-bold text-muted border shadow-sm text-center text-decoration-none">
                            <i class="fa-solid fa-rotate-left me-2"></i> Nueva consulta
                        </a>
                        <button onclick="window.print()" class="btn-apple-blue flex-grow-1 py-3 shadow-lg">
                            <i class="fa-solid fa-print me-2"></i> Imprimir Comprobante
                        </button>
                    </div>
                </div>
            </c:if>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const form = document.getElementById("formConsulta");
            
            if (form) {
                form.addEventListener("submit", function(event) {
                    // Obtiene la respuesta de Google reCAPTCHA
                    const recaptchaResponse = grecaptcha.getResponse();
                    
                    // Si la longitud de la respuesta es 0, significa que no se ha resuelto
                    if (recaptchaResponse.length === 0) {
                        event.preventDefault(); // Detiene el envío del formulario
                        alert("Por favor, verifique la casilla de 'No soy un robot' antes de continuar.");
                    }
                });
            }
        });
    </script>
</body>
</html>