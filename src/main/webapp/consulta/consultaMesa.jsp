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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

    <style>
        :root { 
            --apple-bg: #f5f5f7; 
            --gov-blue: #00324D; 
            --apple-blue: #0071e3;
            --card-radius: 28px;
        }
        
        body { 
            background-color: var(--apple-bg);
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
            color: #1d1d1f;
            min-height: 100vh;
            margin: 0;
        }

        .apple-nav {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 12px 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            position: sticky; top: 0; z-index: 1000;
        }

        .main-card { 
            background: #ffffff;
            border-radius: var(--card-radius);
            box-shadow: 0 12px 40px rgba(0,0,0,0.06);
            border: 1px solid rgba(0,0,0,0.03);
            overflow: hidden;
        }

        /* --- ESTILOS EXCLUSIVOS PARA EL PDF --- */
        #zona-impresion {
            background: white;
            padding: 40px;
            position: relative;
        }

        /* Marca de agua sutil */
        .watermark {
            position: absolute;
            top: 50%; left: 50%;
            transform: translate(-50%, -50%) rotate(-45deg);
            font-size: 5rem;
            color: rgba(0,0,0,0.02);
            font-weight: 900;
            pointer-events: none;
            white-space: nowrap;
            text-transform: uppercase;
        }

        .pdf-header-bar {
            height: 6px;
            background: linear-gradient(90deg, var(--gov-blue), var(--apple-blue));
            margin-bottom: 30px;
            border-radius: 100px;
        }

        .mesa-display {
            font-size: 6.5rem;
            font-weight: 800;
            color: var(--gov-blue);
            line-height: 0.8;
            letter-spacing: -5px;
        }

        .sello-digital {
            width: 100px; height: 100px;
            border: 2px dashed #d2d2d7;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            color: #d2d2d7;
            font-size: 0.6rem;
            font-weight: 700;
            margin: 0 auto;
        }

        .label-pro {
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            color: #86868b;
            letter-spacing: 1.5px;
            margin-bottom: 8px;
            display: block;
        }

        .map-container {
            width: 100%; height: 260px;
            border-radius: 20px; overflow: hidden;
            border: 1px solid #f5f5f7; margin-top: 15px;
        }

        .btn-apple-primary {
            background-color: var(--gov-blue); color: white;
            border-radius: 16px; padding: 14px 28px;
            font-weight: 600; border: none; transition: 0.3s;
        }

        @media print { .no-print { display: none !important; } }
    </style>
</head>
<body>

    <nav class="apple-nav no-print">
        <div class="container d-flex justify-content-between align-items-center px-4">
            <a href="index.jsp" class="fw-bold text-decoration-none" style="color: var(--gov-blue);">
                <img src="https://aldesarrollo.gov.co/wp-content/uploads/2022/11/LA-REGISTRADURIA-NACIONAL.png.webp" height="30" class="me-2">
                Portal Ciudadano
            </a>
            <a href="index.jsp" class="btn btn-sm btn-light rounded-pill px-3 fw-bold border shadow-sm">
                <i class="fa-solid fa-house me-1"></i> Inicio
            </a>
        </div>
    </nav>

    <div class="container d-flex flex-column align-items-center pt-5 pb-5">
        <div class="col-12 col-md-10 col-lg-8">
            
            <c:if test="${empty resultado}">
                <div class="main-card p-5 text-center">
                    <h1 class="fw-bold mb-4" style="font-size: 2.8rem; letter-spacing: -1.5px;">Consulta de Puesto.</h1>
                    <form action="consulta-mesa" method="get" id="formConsulta" class="col-md-9 mx-auto">
                        <input type="text" name="documento" class="form-control bg-light border-0 p-4 rounded-4 mb-4 text-center fs-5" placeholder="Número de cédula" required>
                        <div class="d-flex justify-content-center mb-4"><div class="g-recaptcha" data-sitekey="6LdCG70sAAAAALtOPDenf9sEZJLN1pLo5Cu5-V59" data-callback="habilitarBoton"></div></div>
                        <button type="submit" id="btnConsultar" class="btn-apple-primary w-100 py-3 fs-5 shadow-lg" disabled>Consultar Puesto</button>
                    </form>
                </div>
            </c:if>

            <c:if test="${not empty resultado}">
                <div class="main-card">
                    <div id="zona-impresion">
                        <div class="watermark no-print">REGISTRADURÍA</div>
                        <div class="pdf-header-bar"></div>
                        
                        <div class="d-flex justify-content-between align-items-start mb-5">
                            <div class="d-flex align-items-center">
                                <img src="https://images.seeklogo.com/logo-png/35/2/registraduria-colombia-logo-png_seeklogo-352722.png" height="50">
                                <div class="ms-3">
                                    <h5 class="fw-bold mb-0" style="color: var(--gov-blue);">COMPROBANTE ELECTORAL</h5>
                                    <small class="text-muted fw-bold">SANTA ROSA DE VITERBO - BOYACÁ</small>
                                </div>
                            </div>
                            <div class="text-end">
                                <span class="badge rounded-pill bg-success-subtle text-success px-3 py-2 fw-bold">ESTADO: VIGENTE</span>
                                <br><small class="text-muted" id="fecha-descarga"></small>
                            </div>
                        </div>

                        <div class="text-center mb-5">
                            <h1 class="fw-bold mb-1" style="font-size: 3rem; letter-spacing: -2px;">${resultado.nombres} ${resultado.apellidos}</h1>
                            <p class="text-muted fs-4">C.C. ${resultado.numeroDocumento}</p>
                        </div>

                        <div class="row g-4 mb-5">
                            <div class="col-7">
                                <div class="p-4 bg-light rounded-4 border-start border-primary border-4">
                                    <span class="label-pro">Puesto de Votación</span>
                                    <h4 class="fw-bold text-dark mb-1">${resultado.nombreZona}</h4>
                                    <p class="text-muted mb-0"><i class="fa-solid fa-location-dot me-2"></i>${resultado.direccion}</p>
                                </div>

                                <div class="map-container no-print">
                                    <iframe width="100%" height="100%" frameborder="0" style="border:0"
                                        src="https://maps.google.com/maps?q=${resultado.nombreZona},+Santa+Rosa+de+Viterbo,+Boyaca&t=&z=16&ie=UTF8&iwloc=&output=embed" allowfullscreen>
                                    </iframe>
                                </div>
                            </div>
                            <div class="col-5 text-center">
                                <div class="h-100 d-flex flex-column justify-content-center p-4 border rounded-4 bg-white shadow-sm">
                                    <span class="label-pro">Mesa Asignada</span>
                                    <div class="mesa-display">${resultado.numeroMesa}</div>
                                    <hr class="w-50 mx-auto my-4">
                                    <div class="sello-digital">
                                        <i class="fa-solid fa-fingerprint fa-2x mb-1"></i>
                                        AUTÉNTICO
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="text-center pt-4 border-top">
                            <p class="text-muted small fw-medium mb-0">Este documento es una representación válida del censo electoral oficial para el municipio de Santa Rosa de Viterbo.</p>
                            
                        </div>
                    </div>

                    <div class="p-5 pt-0 no-print">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <a href="index.jsp" class="btn btn-light w-100 py-3 rounded-4 fw-bold text-muted border shadow-sm">
                                    <i class="fa-solid fa-arrow-left me-2"></i> Otra Consulta
                                </a>
                            </div>
                            <div class="col-md-6">
                                <button onclick="descargarPDF()" class="btn-apple-primary w-100 py-3 shadow-lg">
                                    <i class="fa-solid fa-file-pdf me-2"></i> Descargar PDF Oficial
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <script>
        function habilitarBoton() { document.getElementById('btnConsultar').disabled = false; }
        
        // Poner la fecha actual en el ticket
        const fecha = new Date();
        document.getElementById('fecha-descarga').innerText = "Generado: " + fecha.toLocaleDateString() + " " + fecha.toLocaleTimeString();

        function descargarPDF() {
            const elemento = document.getElementById('zona-impresion');
            const opt = {
                margin: 0, // Quitamos margenes para que sea full page
                filename: 'Comprobante_Electoral_${resultado.numeroDocumento}.pdf',
                image: { type: 'jpeg', quality: 1.0 }, // Máxima calidad de imagen
                html2canvas: { 
                    scale: 4, // Escala 4x para que las letras no se vean borrosas
                    useCORS: true,
                    letterRendering: true 
                },
                jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }
            };

            // Ejecutar la magia
            html2pdf().set(opt).from(elemento).save();
        }
    </script>
</body>
</html>