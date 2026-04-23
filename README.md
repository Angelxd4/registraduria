# Sistema Integral de Gestión Electoral - Registraduría Santa Rosa de Viterbo 🇨🇴

Este es un sistema web de gestión administrativa y consulta ciudadana desarrollado para la Registraduría Municipal del Estado Civil de Santa Rosa de Viterbo. La plataforma permite la administración del censo poblacional, expedición de documentos, configuración de la logística electoral (zonas y mesas) y ofrece un portal público para que los ciudadanos consulten su puesto de votación.

## 🚀 Características Principales

### 1. Portal Ciudadano (Público)
* **Consulta de Puesto de Votación:** Los ciudadanos pueden ingresar su número de documento para conocer su estado en el padrón, zona y mesa asignada.
* **Comprobante Digital:** Generación de un ticket de consulta y opción para descargar un comprobante en PDF (usando `html2pdf`).
* **Seguridad:** Integración con Google reCAPTCHA v2 para evitar consultas automatizadas.

### 2. Panel Administrativo (Privado)
* **Autenticación de Funcionarios:** Acceso seguro mediante validación de credenciales en base de datos.
* **Dashboard Estadístico:** Resumen en tiempo real del censo poblacional, trámites expedidos y logística electoral habilitada.
* **Gestión de Ciudadanos:** Módulo CRUD completo para registrar, editar y dar de baja a ciudadanos en el municipio.
* **Trámites y Documentos:** Expedición y control de estado (Vigente, Trámite, Anulado) de Registros Civiles, Tarjetas de Identidad y Cédulas de Ciudadanía. El sistema calcula automáticamente el tipo de documento recomendado según la fecha de nacimiento.
* **Logística Electoral (Zonas y Mesas):**
    * Creación de Puestos de Votación (Zonas).
    * Apertura de Mesas vinculadas a puestos específicos.
    * **Asignación de Votantes:** Función avanzada para distribuir aleatoriamente el padrón electoral entre las mesas disponibles o asignar ciudadanos de forma manual.

## 🛠️ Tecnologías y Arquitectura

El proyecto está construido bajo la arquitectura **MVC (Modelo-Vista-Controlador)** utilizando el patrón **DAO (Data Access Object)** para el acceso a datos.

**Backend:**
* Java EE (Servlets, JSP, JSTL)
* JDBC (Java Database Connectivity) para la comunicación directa con la base de datos.

**Frontend:**
* HTML5 / CSS3
* Bootstrap 5 (Framework CSS)
* FontAwesome 6 (Íconos)
* Diseño personalizado estilo "Glassmorphism" y componentes limpios (inspiración UI de Apple).

**Base de Datos:**
* PostgreSQL alojado en **Supabase** (conexión a través de IPv4/Pooler).

## 📂 Estructura del Proyecto

```text
src/
 ├── main/
 │   ├── java/sena/adso/registraduriaStaRosaViterbo/
 │   │   ├── config/      # Configuración de base de datos (ConexionDB.java)
 │   │   ├── dao/         # Interfaces y clases de implementación (CRUD)
 │   │   ├── model/       # Entidades o POJOs (Ciudadano, Usuario, DocumentoExpedido...)
 │   │   └── servlet/     # Controladores HTTP que procesan las peticiones de las vistas
 │   ├── resources/
 │   │   └── db.properties # Archivo de credenciales de la base de datos
 │   └── webapp/
 │       ├── ciudadanos/  # Vistas JSP para el módulo de ciudadanos
 │       ├── consulta/    # Vistas JSP para el resultado de consulta pública
 │       ├── documentos/  # Vistas JSP para el módulo de trámites
 │       ├── mesas/       # Vistas JSP para logística de mesas
 │       ├── zonas/       # Vistas JSP para puestos de votación
 │       ├── admin.jsp    # Dashboard principal del administrador
 │       ├── index.jsp    # Landing page (Portal público)
 │       ├── LoginAdmin.jsp
 │       └── sidebar.jsp  # Componente de navegación lateral incluido en vistas privadas
⚙️ Configuración e Instalación
Clonar el repositorio:

Bash
git clone <url-del-repositorio>
Configuración de la Base de Datos:
Asegúrate de configurar el archivo src/main/resources/db.properties con tus credenciales de Supabase:

Properties
db.engine=supabase
supabase.url=jdbc:postgresql://<tu-host-pooler>:6543/postgres?sslmode=require
supabase.user=postgres.<tu-proyecto>
supabase.password=<tu-contraseña>
Despliegue:
El proyecto está empaquetado para ser desplegado en un contenedor de Servlets como Apache Tomcat (v9.0+).

Compila el proyecto con Maven (mvn clean install).

Despliega el archivo .war generado en tu servidor Tomcat o ejecuta el proyecto directamente desde tu IDE (Eclipse, IntelliJ, NetBeans).

🔒 Variables de Entorno y APIs
reCAPTCHA: El archivo index.jsp utiliza un sitekey público de reCAPTCHA. Para entornos de producción completos, asegúrate de validar el token en el backend.

👨‍💻 Autor
Desarrollado por Angel Poveda para el proyecto de formación del SENA - ADSO (Análisis y Desarrollo de Software).