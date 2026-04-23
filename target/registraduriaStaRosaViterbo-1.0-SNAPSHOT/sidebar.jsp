<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    :root {
        --apple-blue: #0071e3;
        --gov-blue: #00324D; 
        --bg-darker: #e8e8ed; 
        --sidebar-bg: rgba(255, 255, 255, 0.75); 
    }

    /* Fondo general de la aplicación */
    body {
        background-color: var(--bg-darker) !important;
        margin: 0;
    }

    /* --- ESTILOS DEL SIDEBAR EN COMPUTADORA --- */
    .sidebar {
        width: 275px;
        height: 96vh;
        position: fixed;
        left: 15px;
        top: 2vh;
        background: var(--sidebar-bg);
        backdrop-filter: blur(25px) saturate(190%);
        -webkit-backdrop-filter: blur(25px) saturate(190%);
        border-radius: 32px;
        border: 1px solid rgba(255, 255, 255, 0.4);
        z-index: 1000;
        padding: 24px;
        display: flex;
        flex-direction: column;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
        transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        overflow-y: auto;
    }

    /* Ocultar barra de scroll para un look limpio */
    .sidebar::-webkit-scrollbar { width: 0px; }

    .brand-section {
        padding: 10px 0 25px;
        text-align: center;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        margin-bottom: 25px;
    }

    .brand-section img {
        height: 50px;
        margin-bottom: 10px;
        filter: drop-shadow(0 2px 4px rgba(0,0,0,0.05));
    }

    .nav-label {
        font-size: 0.7rem;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        color: #86868b;
        font-weight: 700;
        margin: 10px 0 12px 15px;
    }

    .nav-menu {
        list-style: none;
        padding: 0;
        margin: 0;
        flex-grow: 1;
    }

    .nav-item { margin-bottom: 4px; position: relative; }

    .nav-link {
        display: flex;
        align-items: center;
        padding: 12px 16px;
        color: #1d1d1f;
        text-decoration: none;
        border-radius: 14px;
        font-weight: 500;
        font-size: 0.92rem;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .nav-link i {
        width: 32px;
        font-size: 1.1rem;
        margin-right: 8px;
        color: #424245;
        transition: color 0.3s;
    }

    .nav-link:hover {
        background: rgba(0, 0, 0, 0.04);
        color: var(--gov-blue);
    }
    .nav-link:hover i { color: var(--gov-blue); }

    .nav-link.active {
        background: white;
        color: var(--gov-blue);
        font-weight: 700;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
    }
    .nav-link.active i { color: var(--gov-blue); }

    .nav-link.active::before {
        content: '';
        position: absolute;
        left: -10px;
        top: 20%;
        height: 60%;
        width: 4px;
        background: var(--gov-blue);
        border-radius: 0 4px 4px 0;
    }

    .user-profile-mini {
        background: rgba(255, 255, 255, 0.5);
        border-radius: 24px;
        padding: 12px;
        display: flex;
        align-items: center;
        gap: 12px;
        margin-top: auto;
        border: 1px solid rgba(255, 255, 255, 0.5);
    }

    .avatar-circle {
        width: 42px;
        height: 42px;
        background: var(--gov-blue);
        color: white;
        border-radius: 14px; 
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        font-size: 1.2rem;
        box-shadow: 0 4px 10px rgba(0, 50, 77, 0.2);
    }

    .logout-btn {
        color: #ff3b30; 
        text-decoration: none;
        font-size: 0.75rem;
        font-weight: 700;
        display: flex;
        align-items: center;
        gap: 4px;
        margin-top: 2px;
        transition: opacity 0.2s;
    }
    .logout-btn:hover { opacity: 0.7; }

    /* --- NUEVO: MAGIA RESPONSIVA MÓVIL ESTILO APPLE --- */
    
    /* Botón flotante estilo "Dynamic Island" (Oculto en PC) */
    .mobile-menu-btn {
        display: none;
        position: fixed;
        bottom: 25px;
        left: 50%;
        transform: translateX(-50%);
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(25px) saturate(180%);
        -webkit-backdrop-filter: blur(25px) saturate(180%);
        border: 1px solid rgba(0,0,0,0.1);
        border-radius: 30px;
        padding: 12px 30px;
        z-index: 1050;
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        color: var(--gov-blue);
        font-weight: 700;
        font-size: 0.95rem;
        cursor: pointer;
        align-items: center;
        gap: 8px;
        transition: 0.3s;
    }

    /* Fondo oscuro al abrir el menú en el celular */
    .mobile-overlay {
        display: none;
        position: fixed;
        top: 0; left: 0; right: 0; bottom: 0;
        background: rgba(0,0,0,0.4);
        backdrop-filter: blur(3px);
        -webkit-backdrop-filter: blur(3px);
        z-index: 999;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    /* Reglas para pantallas de celular y tablet pequeña */
    @media (max-width: 992px) {
        .mobile-menu-btn { display: flex; }
        .mobile-overlay.show { display: block; opacity: 1; }
        
        /* El sidebar se vuelve un menú deslizable desde abajo */
        .sidebar {
            top: auto;
            bottom: 85px; /* Aparece justo encima del botón flotante */
            left: 15px;
            right: 15px;
            width: auto;
            height: auto;
            max-height: 80vh;
            transform: translateY(120%); /* Oculto hacia abajo por defecto */
            padding: 20px;
        }

        /* Clase que activa la animación para mostrarlo */
        .sidebar.show {
            transform: translateY(0);
        }

        /* Ajustes de espacio interno para celular */
        .brand-section { padding-bottom: 15px; margin-bottom: 15px; }
        .user-profile-mini { margin-top: 20px; }
        .nav-link { padding: 10px 16px; }
    }
</style>

<div class="mobile-overlay" id="mobileOverlay" onclick="toggleMenu()"></div>
<div class="mobile-menu-btn" onclick="toggleMenu()">
    <i class="fa-solid fa-bars" id="menuIcon"></i> Menú
</div>

<aside class="sidebar" id="mainSidebar">
    <div class="brand-section">
        <img src="https://aldesarrollo.gov.co/wp-content/uploads/2022/11/LA-REGISTRADURIA-NACIONAL.png.webp" alt="RNEC">
        <div class="fw-bold" style="color: var(--gov-blue); font-size: 0.8rem; letter-spacing: 0.5px;">ADMINISTRACIÓN</div>
    </div>

    <div class="nav-label">General</div>
    <ul class="nav-menu">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin" class="nav-link ${pageContext.request.requestURI.contains('admin') ? 'active' : ''}">
                <i class="fa-solid fa-house-chimney-window"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/ciudadanos" class="nav-link ${pageContext.request.requestURI.contains('ciudadanos') ? 'active' : ''}">
                <i class="fa-solid fa-users-viewfinder"></i> Ciudadanos
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/documentos" class="nav-link ${pageContext.request.requestURI.contains('documentos') ? 'active' : ''}">
                <i class="fa-solid fa-file-invoice"></i> Trámites
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/zonas" class="nav-link ${pageContext.request.requestURI.contains('zonas') ? 'active' : ''}">
                <i class="fa-solid fa-map-location-dot"></i> Zonas
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/mesas" class="nav-link ${pageContext.request.requestURI.contains('mesas') ? 'active' : ''}">
                <i class="fa-solid fa-box-archive"></i> Mesas
            </a>
        </li>
    </ul>

    <div class="user-profile-mini">
        <div class="avatar-circle">
            ${usuario.nombreCompleto.substring(0,1)}
        </div>
        <div class="overflow-hidden">
            <div class="fw-bold text-dark text-truncate" style="font-size: 0.85rem; max-width: 140px;">
                ${usuario.nombreCompleto}
            </div>
            <a href="${pageContext.request.contextPath}/login-admin?action=logout" class="logout-btn">
                <i class="fa-solid fa-power-off"></i> Cerrar sesión
            </a>
        </div>
    </div>
</aside>

<script>
    function toggleMenu() {
        const sidebar = document.getElementById('mainSidebar');
        const overlay = document.getElementById('mobileOverlay');
        const icon = document.getElementById('menuIcon');

        // Pone o quita la clase 'show' que activa la animación CSS
        sidebar.classList.toggle('show');
        
        if (sidebar.classList.contains('show')) {
            overlay.style.display = 'block';
            setTimeout(() => overlay.classList.add('show'), 10);
            icon.classList.replace('fa-bars', 'fa-xmark'); // Cambia a ícono de X
        } else {
            overlay.classList.remove('show');
            setTimeout(() => overlay.style.display = 'none', 300);
            icon.classList.replace('fa-xmark', 'fa-bars'); // Cambia a ícono de hamburguesa
        }
    }
</script>