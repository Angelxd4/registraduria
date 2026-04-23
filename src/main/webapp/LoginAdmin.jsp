<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso Funcionarios | Registraduría Santa Rosa</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        :root {
            --apple-bg: #e8e8ed; /* Gris seda Apple */
            --gov-blue: #00324D; /* Tu azul institucional */
            --card-radius: 35px;
        }
        
        body {
            background-color: var(--apple-bg);
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "Segoe UI", sans-serif;
            min-height: 100vh;
            color: #1d1d1f;
        }
        
        .login-card {
            background: white;
            border-radius: var(--card-radius);
            box-shadow: 0 20px 60px rgba(0,0,0,0.06);
            width: 100%;
            max-width: 420px;
            border: 1px solid rgba(255,255,255,0.8);
            padding: 3.5rem 2.5rem;
            transition: transform 0.3s ease;
        }

        .login-logo {
            height: 50px;
            object-fit: contain;
        }

        .login-title {
            font-weight: 700;
            letter-spacing: -1.5px;
            color: #1d1d1f;
        }

        /* Input Estilo Apple usando base de Bootstrap */
        .form-control-apple {
            background-color: #f5f5f7 !important;
            border: 2px solid transparent !important;
            border-radius: 18px !important;
            padding: 0.8rem 1.2rem !important;
            font-size: 1rem !important;
            transition: all 0.2s ease !important;
        }

        .form-control-apple:focus {
            background-color: white !important;
            border-color: var(--gov-blue) !important;
            box-shadow: 0 0 0 4px rgba(0, 50, 77, 0.08) !important;
            outline: none;
        }

        .label-apple {
            font-size: 0.72rem;
            font-weight: 700;
            text-transform: uppercase;
            color: #86868b;
            letter-spacing: 1.2px;
            margin-bottom: 8px;
            margin-left: 10px;
        }

        /* Botón con el Azul del Login */
        .btn-apple-blue {
            background-color: var(--gov-blue);
            color: white;
            border-radius: 18px;
            padding: 12px;
            font-weight: 700;
            border: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .btn-apple-blue:hover {
            background-color: #001c2b;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 50, 77, 0.2);
            color: white;
        }

        .alert-apple {
            background-color: #fff2f2;
            border: none;
            color: #d70015;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .back-link {
            color: #86868b;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: var(--gov-blue);
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center p-3">

    <div class="container d-flex flex-column align-items-center">
        
        <div class="login-card shadow-lg">
            
            <div class="text-center mb-4">
                <img src="https://aldesarrollo.gov.co/wp-content/uploads/2022/11/LA-REGISTRADURIA-NACIONAL.png.webp" 
                     alt="Logo RNEC" class="login-logo mb-3">
                
                <h2 class="login-title mb-1">Acceso Portal.</h2>
                <p class="text-muted small">Gestión Administrativa Santa Rosa de Viterbo</p>
            </div>

            <%-- Manejo de Errores con Bootstrap Alert --%>
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-apple text-center mb-4 shadow-sm" role="alert">
                    <i class="fa-solid fa-circle-exclamation me-2"></i> ${errorMsg}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login-admin" method="post">
                
                <div class="mb-4">
                    <label for="usuario" class="label-apple">ID de Usuario</label>
                    <input type="text" class="form-control form-control-apple" id="usuario" name="usuario" 
                           required placeholder="Tu nombre de usuario">
                </div>
                
                <div class="mb-4">
                    <label for="password" class="label-apple">Contraseña</label>
                    <input type="password" class="form-control form-control-apple" id="password" name="password" 
                           required placeholder="••••••••">
                </div>
                
                <button type="submit" class="btn btn-apple-blue w-100 shadow-sm">
                    Ingresar al Sistema <i class="fa-solid fa-chevron-right ms-2 small"></i>
                </button>
                
            </form>
            
            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">
                    <i class="fa-solid fa-arrow-left me-2 small"></i> Volver a la consulta ciudadana
                </a>
            </div>
            
        </div>
        
        <footer class="mt-4 text-center">
            <p class="text-muted small fw-medium">© 2026 Registraduría Nacional del Estado Civil</p>
        </footer>
        
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>